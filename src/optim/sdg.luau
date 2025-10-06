local param = require("@model/param")

local sgd = {}

export type Sdg = {
    params: { param.Param },
    lr: number
}

type CreateOptions = {
    lr: number?
}

function sgd.create(params: { param.Param }, options: CreateOptions)
    return {
        params = params,
        lr = options.lr or 0.01,
    }
end

function sgd.zero_grad(self: Sdg)
    for i=1, #self.params do
        self.params[i].grad = 0
    end
end

function sgd.step(self: Sdg)
    for i=1, #self.params do
        local p = self.params[i]
        p.weight -= self.lr * p.grad
    end
end

return sgd
