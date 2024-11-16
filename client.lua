local index = 1
local data = {0.0, 0.0, 0.0, 0.0, 0.0,0.0}
local interval, interval2 = 0.01, 10.0

RegisterCommand('fashion_dev', function(source)
    local input2 = lib.inputDialog('時裝調整工具', {
        {type = 'input', label = 'model'},
        { type = "select", label = "ped bone", options = {
            {value = 12844, label = '頭上'},
            {value = 31086, label = '臉上'},
            {value = 10706, label = '右肩'},
            {value = 64729, label = '左肩'},
            {value = 24818, label = '背包'},
            {value = 0, label = '身體'},
            {value = 36029, label = '左手'},
            {value = 6286, label = '右手'},
            {value = 14201, label = '左腳'},
            {value = 52301, label = '右腳'},
        }},
    })
    if not input2[1] then return end
    local model = GetHashKey(input2[1])
    if not IsModelInCdimage(model) then
        lib.notify({
            description = '無效模型',
            type = 'error'
        })
        return
    end
    index = 1
    data = {0.0, 0.0, 0.0, 0.0, 0.0,0.0}
    interval, interval2 = 0.01, 10.0
    local coords = GetEntityCoords(PlayerPedId())
    local HandObject = CreateObject(model, coords,  true,  true, true)
    local pedbone = GetPedBoneIndex(PlayerPedId(), input2[2])
	AttachEntityToEntity(HandObject, PlayerPedId(), pedbone, 0.0, 0.0, 0.0, 0.0, 0.0,0.0, true, true, false, true, 0, true)
	lib.registerMenu({
        id = 'fashion_dev_menu',
        title = '時裝調整工具',
        position = 'top-right',
        onClose = function()
            DeleteObject(HandObject)
        end,
        options = {
            {label = 'pos x', values = {'-', '+'}, defaultIndex = 1, close = false},
            {label = 'pos y', values = {'-', '+'}, defaultIndex = 1, close = false},
            {label = 'pos z', values = {'-', '+'}, defaultIndex = 1, close = false},
            {label = 'rot x', values = {'-', '+'}, defaultIndex = 1, close = false},
            {label = 'rot y', values = {'-', '+'}, defaultIndex = 1, close = false},
            {label = 'rot z', values = {'-', '+'}, defaultIndex = 1, close = false},
            {label = '設定改變幅度'},
            {label = '手動輸入參數'},
            {label = '完成'},
        }
    }, function(selected, scrollIndex, args)
        if selected == 7 then
            local input = lib.inputDialog('時裝調整工具', {
                {type = 'input', label = 'pos改變幅度', description='預設: 0.01'},
                {type = 'input', label = 'rot改變幅度', description='預設: 10.0'},
            })
            if tonumber(input?[1]) then
                interval = tonumber(input[1])
            end
            lib.showMenu('fashion_dev_menu')
        elseif selected == 8 then
            local input = lib.inputDialog('時裝調整工具', {
                {type = 'input', label = 'pos x', default = 0.0},
                {type = 'input', label = 'pos y', default = 0.0},
                {type = 'input', label = 'pos z', default = 0.0},
                {type = 'input', label = 'rot x', default = 0.0},
                {type = 'input', label = 'rot y', default = 0.0},
                {type = 'input', label = 'rot z', default = 0.0},
            })
            for i = 1, 6 do
                if tonumber(input?[i]) then
                    data[i] = tonumber(input[i])
                end
            end
            lib.showMenu('fashion_dev_menu')
        elseif selected == 9 then
            lib.setClipboard([[
                {
                    itemname = "]]..input2[1]..[[", 
                    Model = "]]..input2[1]..[[", 
                    Bone = ]]..input2[2]..[[,
                    xPos = ]]..data[1]..[[,
                    yPos = ]]..data[2]..[[,
                    zPos = ]]..data[3]..[[,
                    xRot = ]]..data[4]..[[,
                    yRot = ]]..data[5]..[[,
                    zRot = ]]..data[6]..[[
		        },
            ]])
            lib.notify({
                description = '已複製數據到剪貼簿',
                type = 'success'
            })
            DeleteObject(HandObject)
        else 
            local index = scrollIndex == 1 and -1 or 1
            local _interval = selected < 4 and interval or interval2
            data[selected] += (_interval * index)
            AttachEntityToEntity(HandObject, PlayerPedId(), pedbone, data[1], data[2], data[3], data[4], data[5],data[6], true, true, false, true, 0, true)
        end
    end)
    lib.showMenu('fashion_dev_menu')
end)

--result
   --[[ {
    itemname = "sum_heartglasses", 
    Model = "sum_heartglasses", 
    Bone = 31086,
    xPos = 0.045,
    yPos = 0.07,
    zPos = 0.0,
    xRot = -190.0,
    yRot = -90.0,
    zRot = 0.0		        },
    ]]

