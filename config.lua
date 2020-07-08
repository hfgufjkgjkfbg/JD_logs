Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.username = "Bot Username Here" 							-- Bot Username
Config.avatar = "https://via.placeholder.com/30x30"				-- Bot Avatar
Config.communtiyName = "Community Name Here"					-- Icon top of the Embed
Config.communtiyLogo = "https://via.placeholder.com/30x30"		-- Icon top of the Embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam D in the logs


-- Change color of the default embeds here
-- It used Decimal color codes witch you can get and convert here: https://jokedevil.com/colorPicker
Config.joinColor = "3863105" 		-- Player Connecting
Config.leaveColor = "15874618"		-- Player Disconnected
Config.chatColor = "10592673"		-- Chat Message
Config.shootingColor = "10373"		-- Shooting a weapon
Config.deathColor = "000000"		-- Player Died
Config.resourceColor = "15461951"	-- Resource Stopped/Started


Config.webhooks = {
	all = "<DISCORD_WEBHOOK>",
	chat = "<DISCORD_WEBHOOK>",
	joins = "<DISCORD_WEBHOOK>",
	leaving = "<DISCORD_WEBHOOK>",
	deaths = "<DISCORD_WEBHOOK>",
	shooting = "<DISCORD_WEBHOOK>",
	resources = "<DISCORD_WEBHOOK>",

  -- You can add more logs by using exports in other resources
  -- When the action is done call the function below in the script to send the information to JD_logs
  -- exports.JD_logs:discord('<MESSAGE_YOU_WANT_TO_POST_IN_THE_EMBED>', '1752220', '<WEBHOOK_CHANNEL>')
  -- Then create a webhook for the action you just executed
  -- <YOUR NEW WEBHOOK NAME> = "<DISCORD_WEBHOOK>",
  }
