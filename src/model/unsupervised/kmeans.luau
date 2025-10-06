local instance = require("@model/instance")
local vector = require("@utils/vector")

@native local function mean_vector(points: { vector.Vector }): vector.Vector
    local n = #points
    local dim = points[1].size
    local mean = {}
    
    for i=1, dim do 
        mean[i] = 0 
    end
    
    for i=1, n do
        for j=1, dim do
            mean[j] += points[i].data[j]
        end
    end
    
    for j=1, dim do
        mean[j] /= n
    end

    return vector.with_array(mean)
end

local kmeans = {}

@native function kmeans.fit(data: { instance.Instance }, k: number, max_iters: number?): {
    assignments: vector.Vector,
    centroids: { vector.Vector },
}
    local max_iters = max_iters or 100
    local n_data = #data
    local centroids = {}

    for i=1, k do
        centroids[i] = data[math.random(1, n_data)].features
    end

    local assignments = {}

    for iter=1, max_iters do
        local clusters = {}

        for i=1, k do 
            clusters[i] = {} 
        end

        for i=1, n_data do
            local best, best_dist = 1, math.huge

            for j=1, k do
                local diff = vector.sub(data[i].features, centroids[j])
                local dist2 = vector.magnitude(diff) ^ 2

                if dist2 < best_dist then
                    best, best_dist = j, dist2
                end
            end

            table.insert(clusters[best], data[i].features)
            assignments[i] = best
        end

        local new_centroids = {}
        local changed = false

        for j=1, k do
            if #clusters[j] > 0 then
                new_centroids[j] = mean_vector(clusters[j])
            else
                new_centroids[j] = centroids[j]
            end

            local diff = vector.sub(new_centroids[j], centroids[j])

            if vector.magnitude(diff) > 1e-6 then
                changed = true
            end
        end

        centroids = new_centroids

        if not changed then 
            break 
        end
    end

    return { 
        centroids = centroids, 
        assignments = vector.with_array(assignments) 
    }
end

@native function kmeans.predict_classify(centroids: { vector.Vector }, point: vector.Vector): number
    local best, best_dist = 1, math.huge

    for i=1, #centroids do
        local diff = vector.sub(point, centroids[i])
        local dist2 = vector.magnitude(diff) ^ 2

        if dist2 < best_dist then
            best, best_dist = i, dist2
        end
    end

    return best
end

return kmeans
