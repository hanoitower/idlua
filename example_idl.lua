--
-- example_idl.lua
--

local idl = require 'idlua'


local mytypes = {}

mytypes.uint8 = idl.basetype 'uint8'
mytypes.uint16 = idl.basetype 'uint16'


mytypes.Point = idl.def {
   name = 'Point',
   desc = {
      [[A point in 2 dimesional space.]],
   },
   idl.struct {
      idl.member {
         name = 'x',
         desc = {
            [[The x coordinate of the Point.]],
         },
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
   desc = {
      [[A data type package example.]],
   },
   mytypes.uint8,
   mytypes.uint16,
   mytypes.Point,
}


idl.print_type(mytypes.package)
