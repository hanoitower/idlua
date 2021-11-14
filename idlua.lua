--
-- idlua.lua
--
-- lua as idl
--


---@class IdlLua
local idl = {}


---@class IdlNode
---@field kind string
---@field name string
---@field desc string


---@param node IdlNode
---@return IdlNode
function idl.def(node)
   node.kind = 'def'
   return node
end


---@param node IdlNode
---@return IdlNode
function idl.package(node)
   node.kind = 'package'
   return node
end


---@class IdlStructNode : IdlNode
---@field members IdlStructMemberNode[]

---@param node IdlStructNode
---@return IdlStructNode
function idl.struct(node)
   node.kind = 'struct'
   return node
end


---@class IdlStructMemberNode : IdlNode
---@field datatype string

---@param node IdlStructMemberNode
---@return IdlStructMemberNode
function idl.member(node)
   node.kind = 'member'
   return node
end


---@class IdlArrayNode : IdlNode
---@field datatype string
---@field length string

---@param node IdlArrayNode
---@return IdlArrayNode
function idl.array(node)
   node.kind = 'array'
   return node
end


---@param name string
---@return IdlNode
function idl.platformtype(name)
   return {
      kind = 'platformtype',
      name = name
   }
end



---@param node IdlNode
---@param indent string
function idl.print_type(node, indent)
   indent = indent or ''
   local kind = node.kind
   if kind == 'def' then
      print(indent .. '<def name="' .. node.name .. '">')
      idl.print_type(node[1], indent .. '  ')
      print(indent .. '</def>')
   elseif kind == 'package' then
      print(indent .. '<package name="' .. node.name .. '">')
      for _, element in ipairs(node) do
         idl.print_type(element, indent .. '  ')
      end
      print(indent .. '</package>')
   elseif kind == 'struct' then
      print(indent .. '<struct>')
      for _, element in ipairs(node.members) do
         idl.print_type(element, indent .. '  ')
      end
      print(indent .. '</struct>')
   elseif kind == 'member' then
      print(indent .. '<member name="' .. node.name .. '">')
      idl.print_type(node.datatype, indent .. '  ')
      print(indent .. '</member>')
   elseif kind == 'array' then
      print(indent .. '<array length="' .. node.length .. '">')
      idl.print_type(node.datatype, indent .. '  ')
      print(indent .. '</array>')
   elseif kind == 'platformtype' then
      print(indent .. '<platformtype name="' .. node.name .. '"/>')
   end
end


return idl
