export type Vector = {
    data: { number },
    size: number,
}

local vector = {}

function vector.create(size: number): Vector
    local data = {}

    for i=1, size do
        data[i] = 0
    end

    return {
        data = data,
        size = size,
    }
end

function vector.with_array(value: { number }): Vector
    return {
        data = value,
        size = #value,
    }
end

function vector.add(vec1: Vector, vec2: Vector): Vector
    local size = vec1.size
    local arr = vector.create(size)

    for i=1, size do
        arr.data[i] = vec1.data[i] + vec2.data[i]
    end

    return arr
end

function vector.sub(vec1: Vector, vec2: Vector): Vector
    local size = vec1.size
    local arr = {}

    for i=1, size do
        arr[i] = vec1.data[i] - vec2.data[i]
    end

    return vector.with_array(arr)
end

function vector.mul(vec1: Vector, vec2: Vector | number): Vector
    local size = vec1.size
    local arr = vector.create(size)
    
    if typeof(vec2) == "number" then
        for i=1, size do
            arr.data[i] = vec1.data[i] / vec2
        end
    else
        for i=1, size do
            arr.data[i] = vec1.data[i] * vec2.data[i]
        end
    end

    return arr
end

function vector.div(vec1: Vector, vec2: Vector | number): Vector
    local size = vec1.size
    local arr = vector.create(size)
    
    if typeof(vec2) == "number" then
        for i=1, size do
            arr.data[i] = vec1.data[i] / vec2
        end
    else
        for i=1, size do
            arr.data[i] = vec1.data[i] / vec2.data[i]
        end
    end

    return arr
end

@native function vector.sum(self: Vector): number
    local sum = 0

    for i=1, self.size do
        sum += self.data[i]
    end

    return sum
end

@native function vector.magnitude(self: Vector): number
    local magnitude = 0

    for i=1, self.size do
        magnitude += self.data[i] ^ 2
    end

    return magnitude ^ 0.5
end

return vector
