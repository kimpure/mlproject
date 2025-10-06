local vector = require("@utils/vector")
local instance = require("@model/instance")

type Instance = instance.Instance

local knn = {}

@native function knn.fit(data: { Instance }, value: vector.Vector, k: number): { Instance }
    local distances = {}

    for i=1, #data do
        table.insert(distances, data[i])
    end

    table.sort(distances, function(a: Instance, b: Instance)
        return vector.magnitude(vector.sub(a.features, value)) < vector.magnitude(vector.sub(b.features, value))
    end)

    local params = {}

    for i=1, math.min(k, #distances) do
        table.insert(params, distances[i])
    end

    return params
end

@native function knn.predict_classify(params: { Instance }): number
    local counts = {}

    for i=1, #params do
        local distance = params[i]

        local label = distance.label
        counts[label] = (counts[label] or 0) + 1
    end

    local best_label, best_count

    for label, count in counts do
        if not best_count or count > best_count then
            best_label, best_count = label, count
        end
    end

    return best_label
end

@native function knn.predict_regress(params: { Instance }): number
    local sum = 0
    local count = #params

    for i=1, count do
        sum += params[i].label
    end

    return sum / count 
end

return knn
