ESX = nil
local isPauseMenuActive = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetPauseMenuActive(false)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 322) or IsControlJustPressed(1, 200) then 
            isPauseMenuActive = not isPauseMenuActive
            SetNuiFocus(isPauseMenuActive, isPauseMenuActive)

            SendNUIMessage({ type = "toggleMenu", status = isPauseMenuActive })
            SendNUIMessage({ type = "setLanguage", lang = Config.Locale })

            if isPauseMenuActive then
                ESX.TriggerServerCallback('getPlayerInfo', function(data)
                    SendNUIMessage({
                        type = "playerInfo",
                        id = data.source,
                        name = data.name,
                        cash = data.cash,
                        bank = data.bank,
                        lang = Config.Locale
                    })
                end)
            end
        end
    end
end)

RegisterNUICallback('openMap', function()
    isPauseMenuActive = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "toggleMenu",
        status = false
    })
    CreateThread(function()
        ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), false, -1) 
        Wait(100)
        PauseMenuceptionGoDeeper(0) 
        while true do
            Wait(10)
            if IsControlJustPressed(0, 200) then 
                SetFrontendActive(false)
                Wait(10)
                break
            end
        end
    end)
end)

RegisterNUICallback('openSettings', function()
    isPauseMenuActive = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "toggleMenu",
        status = false
    })
    ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_LANDING_MENU"), true, -1) 
end)

RegisterNUICallback('resumeGame', function()
    isPauseMenuActive = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "toggleMenu",
        status = false
    })
end)

RegisterNUICallback('exitServer', function()
    isPauseMenuActive = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "toggleMenu",
        status = false
    })
    TriggerServerEvent('pausemenu:kickPlayer') 
end)

RegisterNUICallback('closeMenu', function()
    isPauseMenuActive = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "toggleMenu",
        status = false
    })
end)
