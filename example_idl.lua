--
-- example_idl.lua
--

idl = require 'idlua'


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


mytypes.package = idl.package {
   name = 'example',
   mytypes.uint8,
   mytypes.uint16,
   mytypes.Point,
}


idl.print_type(mytypes.package)
