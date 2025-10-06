local param = require("./param")
local instance = require("./instance")

export type Instance = instance.Instance
export type Param = param.Param

return {
    supervised = require("./supervised/lib"),
    unsupervised = require("./unsupervised/lib"),
    param = param,
    instance = instance,
}
