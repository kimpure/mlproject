@native local function deppclone(tab: { any })
    local result = {}

    for k, v in tab do
        if typeof(v) == "table" then
            result[k] = deppclone(v)
        else
            result[k] = v
        end
    end

    return result
end

return deppclone
