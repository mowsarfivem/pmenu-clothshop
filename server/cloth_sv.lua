ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('jamsou:buycloth')
AddEventHandler('jamsou:buycloth', function(job)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    xPlayer.removeMoney(100)
end)

RegisterServerEvent('jamsou:savechapeau')
AddEventHandler('jamsou:savechapeau', function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'user_helmet', xPlayer.identifier, function(store)
        store.set('hasHelmet', true)
        store.set('skin', {
            helmet_1 = skin.helmet_1,
            helmet_2 = skin.helmet_2
        })
    end)
end)

RegisterServerEvent('jamsou:savelunettes')
AddEventHandler('jamsou:savelunettes', function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'user_glasses', xPlayer.identifier, function(store)
        store.set('hasGlasses', true)
        store.set('skin', {
            glasses_1 = skin.glasses_1,
            glasses_2 = skin.glasses_2
        })
    end)
end)

RegisterServerEvent('jamsou:saveoreillette')
AddEventHandler('jamsou:saveoreillette', function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'user_ears', xPlayer.identifier, function(store)
        store.set('hasEars', true)
        store.set('skin', {
            ears_1 = skin.ears_1,
            ears_2 = skin.ears_2
        })
    end)
end)

RegisterServerEvent('jamsou:savemasque')
AddEventHandler('jamsou:savemasque', function(skin)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'user_mask', xPlayer.identifier, function(store)
        store.set('hasMask', true)
        store.set('skin', {
            mask_1 = skin.mask_1,
            mask_2 = skin.mask_2
        })
    end)
end)