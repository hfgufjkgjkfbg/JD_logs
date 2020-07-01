# JD_logs
This is a server log script for FiveM, which is used to log certain actions that are being made in the server.


### Requirements
- A Discord Server
- FiveM FXServer

### Features
- All log channel
- Log to seperate channels
- Log from server or client side
- Easy changeble Avatar and Username

## Download & Installation

- Download the files
- Put it in the server resource directory

### Installation
- Add this to your `server.cfg`
```
ensure logs
```

# Adding more logs

- Add the following code to your existing resource where you execude the code
```
exports.JD_logs:discord('<MESSAGE_YOU_WANT_TO_POST_IN_THE_EMBED>', '1752220', '<WEBHOOK_CHANNEL>')
```
- Create a discord channel with webhook and add this to the webhooks.
```
local webhooks = {
	all = "<DISCORD_WEBHOOK>",
	chat = "<DISCORD_WEBHOOK>",
	joins = "<DISCORD_WEBHOOK>",
	leaving = "<DISCORD_WEBHOOK>",
	deaths = "<DISCORD_WEBHOOK>",
	shooting = "<DISCORD_WEBHOOK>",
	resources = "<DISCORD_WEBHOOK>",
	<WEBHOOK_CHANNEL> = "<DISCORD_WEBHOOK>", <------
}

```

### My Discord: https://discord.gg/m4BvmkG

### Images
![Connecting](https://gyazo.com/d72db089cd6f31f820da097743461b89.png)
![Chat](https://gyazo.com/f0d3381fbcb8eef23ae6d1ed436ac919.png)
![Disconnect](https://gyazo.com/38a62025385f7992876ad82b986638cf.png)
