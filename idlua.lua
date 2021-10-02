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


mytypes = {}

mytypes.uint8 = idl.basetype 'uint8'
mytypes.uint16 = idl.basetype 'uint16'


mytypes.Point = idl.def {
   name = 'Point',
   idl.struct {
      idl.member {
         name = 'x',
         datatype = idl.struct {
            idl.member {
               name = 'value',
               datatype = mytypes.uint16
            }
         }
      },
      idl.member {
         name = 'y',
         datatype = idl.array {
            length = 42,
            datatype = idl.basetype 'uint8'
         }
      }
   }
}


function print_type(node, indent)
   indent = indent or ''
   kind = node.kind
   if kind == 'def' then
      print(indent .. '<def name="' .. node.name .. '">')
      print_type(node[1], indent .. '  ')
      print(indent .. '</def>')
   elseif kind == 'struct' then
      print(indent .. '<struct>')
      for _, member in ipairs(node) do
         print_type(member, indent .. '  ')
      end
      print(indent .. '</struct>')
   elseif kind == 'member' then
      print(indent .. '<member name="' .. node.name .. '">')
      print_type(node.datatype, indent .. '  ')
      print(indent .. '</member>')
   elseif kind == 'array' then
      print(indent .. '<array length="' .. node.length .. '">')
      print_type(node.datatype, indent .. '  ')
      print(indent .. '</array>')
   elseif kind == 'basetype' then
      print(indent .. '<basetype name="' .. node.name .. '"/>')      
   end
end


function print_type_list(node)
   print('<datatypes>')
   indent = '  '
   for _, typedef in pairs(node) do
      print_type(typedef, indent)
   end
   print('</datatypes>')      
end


print_type_list(mytypes)
