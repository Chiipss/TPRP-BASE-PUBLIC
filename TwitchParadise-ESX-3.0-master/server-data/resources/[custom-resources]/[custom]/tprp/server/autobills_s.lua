ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function SocietyInvest(d, h, m)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
        account.addMoney(0) -- Greedy Cops
        -- print("Greedy Cops")
	end)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
		account.addMoney(50000) -- Needy EMS
	end)
end


function PayBills(d, h, m)
	print("Payment of invoices in progress the server can momentarily lag")
	CreateThread(function()
		Wait(0)
		MySQL.Async.fetchAll('SELECT * FROM billing', {}, function (result)
			print("Unpaid Bills: " .. #result)
			for i=1, #result, 1 do
				local xPlayer = ESX.GetPlayerFromIdentifier(result[i].identifier)
				
				-- message player if connected
				if xPlayer then
					local accountMoney = xPlayer.getAccount('bank').money
					
					-- if accountMoney > 0 then
						if math.floor(accountMoney/100*25) >= result[i].amount then
							xPlayer.removeAccountMoney('bank', result[i].amount)
							TriggerClientEvent('esx:showNotification', xPlayer.source, "You have been forced to pay ".. ESX.Math.GroupDigits(result[i].amount).." on a past due invoice")
							TriggerEvent('esx_addonaccount:getSharedAccount', result[i].target, function(account)
								account.addMoney(result[i].amount)
							end)
							MySQL.Sync.execute('DELETE FROM billing WHERE id = @id',
							{
								['@id'] = result[i].id
							})
							print(xPlayer.name.." paid "..result[i].amount.." off an invoice due to "..result[i].target)
						else
							xPlayer.removeAccountMoney('bank', math.floor(accountMoney/100*25))
							TriggerClientEvent('esx:showNotification', xPlayer.source, "You have to pay ".. ESX.Math.GroupDigits(math.floor(accountMoney/100*25)).." on a past due invoice")
							TriggerEvent('esx_addonaccount:getSharedAccount', result[i].target, function(account)
								account.addMoney(math.floor(accountMoney/100*25))
							end)
							MySQL.Sync.execute('UPDATE billing SET amount = amount - @amount WHERE id = @id',
							{
								['@amount'] = math.floor(accountMoney/100*25),
								['@id'] = result[i].id
							})
							print(xPlayer.name.." paid "..(math.floor(accountMoney/100*25)).." off an invoice due to "..result[i].target)
						end
					-- end
				else -- pay rent either way
					MySQL.Async.fetchScalar('SELECT bank FROM users WHERE identifier = @identifier', 
					{
						['@identifier'] = result[i].identifier
					}, function(bankmoney)
						if bankmoney > 0 then
							if math.floor(bankmoney/100*25) >= result[i].amount then
								MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier',
								{
									['@bank']       = result[i].amount,
									['@identifier'] = result[i].identifier
								})
								TriggerEvent('esx_addonaccount:getSharedAccount', result[i].target, function(account)
									account.addMoney(result[i].amount)
								end)
								MySQL.Sync.execute('DELETE FROM billing WHERE `id` = @id',
								{
									['@id'] = result[i].id
								})
								print(result[i].identifier.." paid "..(result[i].amount).." off an invoice due to "..result[i].target)
							else
								MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier',
								{
									['@bank']       = math.floor(bankmoney/100*25),
									['@identifier'] = result[i].identifier
								})
								MySQL.Sync.execute('UPDATE billing SET amount = amount - @amount WHERE id = @id',
								{
									['@amount']       = math.floor(bankmoney/100*25),
									['@id'] = result[i].id
								})
								print(result[i].identifier.." paid "..(math.floor(bankmoney/100*25)).." off an invoice due to "..result[i].target)
							end
						end
					end)
				end
			end
		end)
	end)
end

TriggerEvent('cron:runAt', 22, 0, SocietyInvest)
TriggerEvent('cron:runAt', 3, 10, PayBills)