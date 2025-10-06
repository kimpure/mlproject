local vector = require("@utils/vector")

export type Instance = {
    features: vector.Vector,
    label: number,
}

local instance = {}

function instance.create(features: { number }, label: number): Instance
    return {
        features = vector.with_array(features),
        label = label,
    }
end

function instance.with_vector(features: vector.Vector, label: number): Instance
    return {
        features = features,
        label = label,
    }
end

return instance
