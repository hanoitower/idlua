--
-- idlua.lua
--
-- lua as idl
--


idl = {}


function idl.def(tt)
   tt.kind = 'def'
   return tt
end


function idl.struct(tt)
   tt.kind = 'struct'
   return tt
end


function idl.member(tt)
   tt.kind = 'member'
   return tt
end


function idl.array(tt)
   tt.kind = 'array'
   return tt
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


function print_type(tt, indent)
   indent = indent or ''
   kind = tt.kind
   if kind == 'def' then
      print(indent .. '<def name="' .. tt.name .. '">')
      print_type(tt[1], indent .. '  ')
      print(indent .. '</def>')
   elseif kind == 'struct' then
      print(indent .. '<struct>')
      for _, member in ipairs(tt) do
         print_type(member, indent .. '  ')
      end
      print(indent .. '</struct>')
   elseif kind == 'member' then
      print(indent .. '<member name="' .. tt.name .. '">')
      print_type(tt.datatype, indent .. '  ')
      print(indent .. '</member>')
   elseif kind == 'array' then
      print(indent .. '<array length="' .. tt.length .. '">')
      print_type(tt.datatype, indent .. '  ')
      print(indent .. '</array>')
   elseif kind == 'basetype' then
      print(indent .. '<basetype name="' .. tt.name .. '"/>')      
   end
end


function print_type_list(typelist)
   print('<datatypes>')
   indent = '  '
   for _, typedef in pairs(typelist) do
      print_type(typedef, indent)
   end
   print('</datatypes>')      
end


print_type_list(mytypes)
