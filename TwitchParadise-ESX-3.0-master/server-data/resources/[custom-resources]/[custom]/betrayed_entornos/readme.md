-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

Requirements
- ESX

Installation
- Extract to resources folder
- Start in server.cfg
- If sql file provided, import it.
- Make sure you read the config for things you might need to change.
- Make sure requirements are installed and started in server.cfg (if not provided, please ask via discord).
- Make sure you're added to webhook. If you have no idea what that is, head to the link above and create a ticket.

Usage

From client:
- TriggerServerEvent('MF_Trackables:Notify','Enter a message here',coordsHere,'jobNameHere')
- TriggerServerEvent('MF_Trackables:Notify','Somebody is in need of assistance.',GetEntityCoords(GetPlayerPed(-1)),'police')

From server:
- TriggerClientEvent('MF_Trackables:DoNotify',-1,'Enter a message here',coordsHere,'jobNameHere')
- TriggerClientEvent('MF_Trackables:DoNotify',-1,'Somebody is in need of assistance.',coordsHere,'police')