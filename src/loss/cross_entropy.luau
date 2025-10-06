return @native function(y_true: number, y_pred: number)
    local eps = 1e-15
    y_pred = math.max(eps, math.min(1 - eps, y_pred))
    return -(y_true * math.log(y_pred) + (1 - y_true) * math.log(1 - y_pred))
end