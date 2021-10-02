--
-- idlua.lua
--
-- lua as idl
--


idl = {}


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


mytypes.Point = idl.struct {
   name = 'Point',
   members = {
      idl.member {
         name = 'x',
         datatype = idl.struct {
            members = {
               idl.member {
                  name = 'value',
                  datatype = mytypes.uint16
               }
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
   if kind == 'struct' then
      if tt.name then
         print(indent .. '<struct name="' .. tt.name .. '">')
      else
         print(indent .. '<struct>')
      end
      for _, member in ipairs(tt.members) do
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
