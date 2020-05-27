DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/666600540129591326/XocHJ2b7LijqGnpdnj_-QvcX7FCHmwDJvYoZnF_Uny-6miY1Psh7sDgYDkp_WIkRN4aV'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/666600625769021440/1a-FeI61-FO8_xG-SKrYfJ6HE-Tb8eSQEoTTtJqLipFTfbgH8aCB6_fMQ9r001hJWYy0'
DiscordWebhookChat = 'https://discordapp.com/api/webhooks/666600736196657152/DJLxSD0bW7q6-7SUDBEjbSGps1oIiuQlX1vzT7apZZE8_E0hErBHzcJ70zJ-vDnF41sM'
DiscordWebhookScriptError = 'https://discordapp.com/api/webhooks/705566507262017548/NLCn1FP8HzLQ8mMssQ931z6Q5TQnkLdrQz5gfOfCHCsxKmiFg1FYcK-Kd5O2M1jy-RV5'

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

