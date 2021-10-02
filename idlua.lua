--
-- idlua.lua
--
-- lua as idl
--


idl = {}


function idl.def(node)
   node.kind = 'def'
   return node
end


function idl.package(node)
   node.kind = 'package'
   return node
end


function idl.struct(node)
   node.kind = 'struct'
   return node
end


function idl.member(node)
   node.kind = 'member'
   return node
end


function idl.array(node)
   node.kind = 'array'
   return node
end


function idl.basetype(name)
   return {
      kind = 'basetype',
      name = name
   }
end


function idl.print_type(node, indent)
   indent = indent or ''
   kind = node.kind
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
      for _, element in ipairs(node) do
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
   elseif kind == 'basetype' then
      print(indent .. '<basetype name="' .. node.name .. '"/>')      
   end
end


return idl
