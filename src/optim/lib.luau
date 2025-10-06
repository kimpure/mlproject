local adam = require("./adam")
local sdg = require("./sdg")

export type Adam = adam.Adam
export type Sdg = sdg.Sdg

return {
    adam = adam,
    sdg = sdg,
}