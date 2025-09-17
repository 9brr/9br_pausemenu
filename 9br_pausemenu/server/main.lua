ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('pausemenu:kickPlayer')
AddEventHandler('pausemenu:kickPlayer', function()
    local src = source
    DropPlayer(src, "الله يستر عليك يا حب .لا تطول علينا")
end)


ESX.RegisterServerCallback('getPlayerInfo', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        cb({
            source = source,
            name = xPlayer.getName(),
            cash = xPlayer.getMoney(),
            bank = xPlayer.getAccount('bank').money
        })
    end
end)
