DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/612737119344918551/mo0FhwUgr9BRCOTziUl-AvZOYKIyZUsNlfJIRQdxx4bdeJz4MyiLrswsHkDV-4pUa0kb'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/621767678545362975/HA41IaDt8NZHQT2osgplTTxqo7vqaB8Vn4M_xxrQ38G4CXKSg4UQH5RjYK_sOoFL_jCC'
DiscordWebhookChat = 'https://discordapp.com/api/webhooks/621767506088034314/3PFpH_oxXqsXVaw9SavlR8nKFprq_ePlsgyzYib9JElSz5EtwwkMZGPs4DgQ23woOhN6'

SystemAvatar = 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png'

UserAvatar = 'https://i.imgur.com/KIcqSYs.png'

SystemName = 'SYSTEM'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/AnotherCommand', 'WEBHOOK_LINK_HERE'},
					  {'/AnotherCommand2', 'WEBHOOK_LINK_HERE'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }

