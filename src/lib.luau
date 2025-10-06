local gradients = require("./gradients/lib")
local loss = require("./loss/lib")
local model = require("./model/lib")
local optim = require("./optim/lib")
local vector = require("./utils/vector")
local matrix = require("./utils/matrix")

export type Instance = model.Instance
export type Param = model.Param

export type Vector = vector.Vector
export type Matrix = matrix.Matrix

export type Adam = optim.Adam
export type Sdg = optim.Sdg

return {
    gradients = gradients,
    loss = loss,
    model = model,
    optim = optim,
    vector = vector,
    matrix = matrix,
}
