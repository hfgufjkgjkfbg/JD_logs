Citizen.CreateThread( function()
updatePath = "/JokeDevil/JD_logs" -- your git user/repo path
resourceName = "JD_logs ("..GetCurrentResourceName()..")" -- the resource name

function checkVersion(err,responseText, headers)
	curVersion = LoadResourceFile(GetCurrentResourceName(), "version") -- make sure the "version" file actually exists in your resource root!

	if curVersion ~= responseText then
		print("\n"..resourceName.." is outdated!\n should be: "..responseText.." is: "..curVersion.."\nplease update it from https://github.com"..updatePath.."")
		print( "^1\n\nYour JD_logs version is outdated, visit the FiveM forum post to get the latest version.\nCurrent Version: "..curVersion.."Latest Version: "..responseText.." \n^0" )
	end
end

PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version", checkVersion, "GET")
end)
