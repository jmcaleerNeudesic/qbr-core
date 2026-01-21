local QBCore = exports['qbr-core']:GetCoreObject()
local tamedHorses = {}
local isNearSellLocation = false
local currentSellLocation = nil

-- Create blips for sell locations
CreateThread(function()
    for _, location in pairs(Config.SellLocations) do
        if location.blip then
            local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, location.coords.x, location.coords.y, location.coords.z)
            SetBlipSprite(blip, 1908979692, 1)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, location.name)
        end
    end
end)

-- Function to check if entity is a wild horse
local function IsWildHorse(entity)
    if not DoesEntityExist(entity) then return false end
    if not IsEntityAPed(entity) then return false end
    
    local model = GetEntityModel(entity)
    for _, wildModel in pairs(Config.WildHorseModels) do
        if model == wildModel then
            -- Check if horse has no owner/saddle
            local hasOwner = Citizen.InvokeNative(0xAD6875BBC0FC899C, entity)
            return not hasOwner
        end
    end
    return false
end

-- Function to get horse name from model
local function GetHorseNameFromModel(model)
    local horses = exports['qbr-core']:GetHorses()
    for name, data in pairs(horses) do
        if data.model == model then
            return name, data.price
        end
    end
    return "Unknown", 10
end

-- Taming prompt
local TamingPrompt = nil
CreateThread(function()
    local str = Config.Lang.tame_prompt
    TamingPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
    PromptSetControlAction(TamingPrompt, 0x760A9C6F)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(TamingPrompt, str)
    PromptSetEnabled(TamingPrompt, false)
    PromptSetVisible(TamingPrompt, false)
    PromptSetHoldMode(TamingPrompt, true)
    PromptSetGroup(TamingPrompt, 0)
    Citizen.InvokeNative(0xF7AA2696A22AD8B9, TamingPrompt)
end)

-- Selling prompt
local SellingPrompt = nil
CreateThread(function()
    local str = Config.Lang.sell_prompt
    SellingPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
    PromptSetControlAction(SellingPrompt, 0x760A9C6F)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(SellingPrompt, str)
    PromptSetEnabled(SellingPrompt, false)
    PromptSetVisible(SellingPrompt, false)
    PromptSetHoldMode(SellingPrompt, true)
    PromptSetGroup(SellingPrompt, 0)
    Citizen.InvokeNative(0xF7AA2696A22AD8B9, SellingPrompt)
end)

-- Main detection thread
CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        
        -- Check for wild horses nearby
        local handle, ped = FindFirstPed()
        local success
        local nearWildHorse = false
        local targetHorse = nil
        
        repeat
            if IsWildHorse(ped) then
                local horseCoords = GetEntityCoords(ped)
                local distance = #(coords - horseCoords)
                
                if distance < Config.DetectionRadius then
                    nearWildHorse = true
                    targetHorse = ped
                    sleep = 0
                    break
                end
            end
            success, ped = FindNextPed(handle)
        until not success
        EndFindPed(handle)
        
        -- Show taming prompt
        if nearWildHorse and targetHorse then
            PromptSetEnabled(TamingPrompt, true)
            PromptSetVisible(TamingPrompt, true)
            
            if PromptHasHoldModeCompleted(TamingPrompt) then
                TameHorse(targetHorse)
            end
        else
            PromptSetEnabled(TamingPrompt, false)
            PromptSetVisible(TamingPrompt, false)
        end
        
        Wait(sleep)
    end
end)

-- Check proximity to sell locations
CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        
        isNearSellLocation = false
        currentSellLocation = nil
        
        for _, location in pairs(Config.SellLocations) do
            local distance = #(coords - location.coords)
            if distance < 3.0 then
                isNearSellLocation = true
                currentSellLocation = location
                sleep = 0
                break
            end
        end
        
        Wait(sleep)
    end
end)

-- Selling prompt thread
CreateThread(function()
    while true do
        local sleep = 1000
        
        if isNearSellLocation then
            local playerPed = PlayerPedId()
            local mount = Citizen.InvokeNative(0xE7E11B8DCBED1058, playerPed)
            
            if mount and mount ~= 0 then
                sleep = 0
                PromptSetEnabled(SellingPrompt, true)
                PromptSetVisible(SellingPrompt, true)
                
                if PromptHasHoldModeCompleted(SellingPrompt) then
                    SellHorse(mount)
                end
            else
                PromptSetEnabled(SellingPrompt, false)
                PromptSetVisible(SellingPrompt, false)
            end
        else
            PromptSetEnabled(SellingPrompt, false)
            PromptSetVisible(SellingPrompt, false)
        end
        
        Wait(sleep)
    end
end)

-- Function to tame horse
function TameHorse(horse)
    if not DoesEntityExist(horse) then return end
    
    local playerPed = PlayerPedId()
    local model = GetEntityModel(horse)
    local horseName, basePrice = GetHorseNameFromModel(model)
    
    -- Show taming notification
    exports['qbr-core']:ShowBasicTopNotification(Config.Lang.taming, Config.TamingTime)
    
    -- Taming progress
    local success = true
    local timer = GetGameTimer()
    
    -- Simple taming mechanic (can be enhanced with mini-game)
    Wait(Config.TamingTime)
    
    -- Random chance of success (80%)
    if math.random(100) <= 80 then
        -- Mark as tamed
        tamedHorses[horse] = {
            model = model,
            name = horseName,
            price = basePrice
        }
        
        -- Set ownership
        Citizen.InvokeNative(0x931B241409216C1F, playerPed, horse, false)
        
        -- Notify success
        exports['qbr-core']:ShowAdvancedRightNotification(
            Config.Lang.tamed,
            'inventory_items',
            'horse_equipment',
            'COLOR_WHITE',
            5000
        )
    else
        -- Horse runs away
        TaskSmartFleeEntity(horse, playerPed, 100.0, -1, 256, 3.0, 0)
        exports['qbr-core']:ShowAdvancedRightNotification(
            Config.Lang.failed,
            'mp_lobby_textures',
            'cross',
            'COLOR_RED',
            5000
        )
    end
end

-- Function to sell horse
function SellHorse(horse)
    if not DoesEntityExist(horse) then
        exports['qbr-core']:ShowBasicTopNotification(Config.Lang.no_horse, 5000)
        return
    end
    
    local model = GetEntityModel(horse)
    local isWild = false
    
    -- Check if it's a tamed wild horse
    if tamedHorses[horse] then
        isWild = true
    else
        -- Check if it's a wild horse model
        for _, wildModel in pairs(Config.WildHorseModels) do
            if model == wildModel then
                isWild = true
                break
            end
        end
    end
    
    if not isWild then
        exports['qbr-core']:ShowBasicTopNotification(Config.Lang.not_wild_horse, 5000)
        return
    end
    
    -- Get horse data
    local horseName, basePrice = GetHorseNameFromModel(model)
    if tamedHorses[horse] then
        horseName = tamedHorses[horse].name
        basePrice = tamedHorses[horse].price
    end
    
    -- Calculate sell price
    local sellPrice = math.floor(basePrice * Config.SellPercentage)
    
    -- Sell to server
    TriggerServerEvent('qbr-horsecapture:server:SellHorse', sellPrice, horseName)
    
    -- Remove from tamed list
    tamedHorses[horse] = nil
    
    -- Delete horse
    SetEntityAsMissionEntity(horse, true, true)
    DeleteEntity(horse)
end

-- Helper function to create var string
function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end
