return @native function(y_true: number, y_pred: number)
    return (y_pred - y_true) ^ 2
end