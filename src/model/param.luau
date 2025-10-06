export type Param = {
    weight: number,
    grad: number,
}

local param = {}

function param.create(weight: number, grad: number?): Param
    return {
        weight = weight,
        grad = grad or 0,
    }
end

return param
