--
-- example_idl.lua
--

---@type IdlLua
local idl = require 'idlua'


local mytypes = {}

mytypes.uint8 = idl.platformtype 'uint8'
mytypes.uint16 = idl.platformtype 'uint16'


mytypes.Point = idl.def {
   name = 'Point',
   desc = {
      [[A point in 2 dimesional space.]],
   },
   idl.struct {
      members = {
         idl.member {
            name = 'x',
            desc = {
               [[The x coordinate of the Point.]],
            },
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
               datatype = idl.platformtype 'uint8'
            }
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
