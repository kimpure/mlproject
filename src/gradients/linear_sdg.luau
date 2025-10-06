local instance = require("@model/instance")
local param = require("@model/param")

return @native function(data: { instance.Instance }, params: { param.Param }, lr: number)
    local n_data = #data
    local n_features = data[1].features.size

    for i=1, n_data do
        local inst = data[i]
        local x = inst.features.data
        local y = inst.label

        local z = params[1].weight
        
        for j=1, n_features do
            z += params[j+1].weight * x[j]
        end

        local error = z - y

        params[1].weight -= lr * error
        for j=1, n_features do
            params[j+1].weight -= lr * error * x[j]
        end
    end
end