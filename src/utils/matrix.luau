local deepclone = require("@utils/luau/deppclone")

--// column-major
export type Matrix = {
    data: { { number } },
    rows: number,
    cols: number,
}

local matrix = {}

function matrix.create(rows: number, cols: number): Matrix
    local data = {}

    for i=1, cols do
        data[i] = {}

        for j=1, rows do
            data[i][j] = 0
        end
    end

    return {
        cols = cols,
        rows = rows,
        data = data
    }
end

@native function matrix.with_table(tab: { { number } }): Matrix
    local data = {}
    local cols = #tab
    local rows = #(tab[1])

    for i=1, cols do
        data[i] = {}

        for j=1, rows do
            data[i][j] = tab[i][j]
        end
    end

    return {
        cols = cols,
        rows = rows,
        data = data,
    }
end

@native function matrix.transpose(self: Matrix): Matrix
    local data = {}

    for j=1, self.rows do
        data[j] = {}

        for i=1, self.cols do
            data[j][i] = self.data[i][j]
        end
    end

    return {
        cols = self.rows,
        rows = self.cols,
        data = data,
    }
end

@native function matrix.matmul(mat1: Matrix, mat2: Matrix): Matrix
    local r1, c1 = mat1.rows, mat1.cols
    local c2 = mat2.cols

    local data = {}

    for i = 1, r1 do
        data[i] = {}

        for j = 1, c2 do
            local sum = 0

            for k = 1, c1 do
                sum += mat1.data[i][k] * mat2.data[k][j]
            end

            data[i][j] = sum
        end
    end

    return {
        data = data,
        rows = r1,
        cols = c2,
    }
end

@native function matrix.inverse(self: Matrix): Matrix
    local data = deepclone(self.data)
    local rows = self.rows
    
    local inv = {}

    for i=1, rows do
        inv[i] = {}
        for j=1, rows do
            inv[i][j] = (i == j) and 1 or 0
        end
    end

    for i=1, rows do
        local pivot = data[i][i]
        
        if pivot == 0 then
            local swapped = false

            for k=i+1, rows do
                if data[k][i] ~= 0 then
                    data[i], data[k] = data[k], data[i]
                    inv[i], inv[k] = inv[k], inv[i]
                    pivot = data[i][i]
                    swapped = true
                    break
                end
            end

            assert(swapped, "can not Inverse matrix")
        end

        for j=1, rows do
            data[i][j] = data[i][j] / pivot
            inv[i][j] = inv[i][j] / pivot
        end

        for k = 1, rows do
            if k ~= i then
                local factor = data[k][i]

                for j=1, rows do
                    data[k][j] = data[k][j] - factor * data[i][j]
                    inv[k][j] = inv[k][j] - factor * inv[i][j]
                end
            end
        end
    end

    return {
        data = inv,
        rows = rows,
        cols = rows,
    }
end

return matrix
