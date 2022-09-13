ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

function setStuff(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    for _, item in pairs(CreatorSettings.ItemList) do 
        xPlayer.addInventoryItem(item.name, item.count)
    end
end

RegisterServerEvent("cxCreator:setPlayerToBucket")
AddEventHandler("cxCreator:setPlayerToBucket", function()
    local source = source
    local bucketId = source
    SetPlayerRoutingBucket(source, bucketId)
end)

RegisterServerEvent("cxCreator:setPlayerToNormalBucket")
AddEventHandler("cxCreator:setPlayerToNormalBucket", function()
    local source = source
    SetPlayerRoutingBucket(source, 0)
end)

RegisterServerEvent("cxCreator:AddIdentityToPlayer")
AddEventHandler("cxCreator:AddIdentityToPlayer", function(FirstName, LastName, Sex, DDN, Height)
	local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute("UPDATE users SET firstname = @firstname, lastname = @lastname, dateofbirth = @dateofbirth, sex = @sex, height = @height WHERE identifier = @identifier", {
		["@identifier"] = xPlayer.identifier, 
		["@firstname"] = FirstName,
        ["@lastname"] = LastName,
        ["@dateofbirth"] = DDN,
        ["@sex"] = Sex,
        ["@height"] = Height
	})
    setStuff(source)
end)
