local param = require("@model/param")
local vector = require("@utils/vector")

local adam = {}

export type Adam = {
    lr: number,
    beta1: number,
    beta2: number,
    eps: number,

    params: { param.Param },

    m: vector.Vector,
    v: vector.Vector,
    t: number,
}

type CreateOptions = {
    lr: number?,
    beta1: number?,
    beta2: number?,
    eps: number?,
}

function adam.create(params: { param.Param }, options: CreateOptions?): Adam
    local options: CreateOptions = options or {}
    local params_size = #params

    return {
        lr = options.lr or 0.001,
        beta1 = options.beta1 or 0.9,
        beta2 = options.beta2 or 0.999,
        eps = options.eps or 1e-8,
        params = params,
        m = vector.create(params_size),
        v = vector.create(params_size),
        t = 0,
    }
end

@native function adam.zero_grad(self: Adam)
    for i=1, #self.params do
        self.params[i].grad = 0
    end
end

@native function adam.step(self: Adam)
    self.t += 1

    for i=1, #self.params do
        local p = self.params[i]
        local grad = p.grad

        self.m.data[i] = (self.m.data[i] * self.beta1) + (grad * (1 - self.beta1))
        self.v.data[i] = (self.v.data[i] * self.beta2) + (grad ^ 2 * (1 - self.beta2))

        local m_hat = self.m.data[i] / (1 - self.beta1^self.t)
        local v_hat = self.v.data[i] / (1 - self.beta2^self.t)

        local denom = v_hat ^ 0.5 + self.eps

        p.weight -= (m_hat / denom) * self.lr
    end
end

return adam
