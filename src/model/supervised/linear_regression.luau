local param = require("@model/param")
local vector = require("@utils/vector")

local linear_regression = {}

@native function linear_regression.predict(params: { param.Param }, features: vector.Vector): number
    local pred = params[1].weight
    
    for i=1, features.size do
        pred += params[i+1].weight * features.data[i]
    end
    
    return pred
end

return linear_regression
