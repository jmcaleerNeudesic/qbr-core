local QBCore = exports['qbr-core']:GetCoreObject()

-- Event to handle horse selling
RegisterNetEvent('qbr-horsecapture:server:SellHorse', function(price, horseName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    -- Add money to player
    if Player.Functions.AddMoney('cash', price, 'horse-sale') then
        -- Notify player
        TriggerClientEvent('QBCore:Notify', src, 9, 
            string.format(Config.Lang.sold, price), 
            5000, 0, 'hud_textures', 'check', 'COLOR_GREEN')
        
        -- Log the transaction
        print(string.format('[qbr-horsecapture] %s (ID: %s) sold a %s for $%s', 
            GetPlayerName(src), src, horseName, price))
    end
end)

-- Command to check horse capture stats (admin only)
QBCore.Commands.Add('horsestats', 'Check horse capture statistics (Admin Only)', {}, false, function(source)
    local src = source
    -- This could be expanded to track stats in a database
    TriggerClientEvent('QBCore:Notify', src, 9, 
        'Horse capture system is active', 
        5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
end, 'admin')
