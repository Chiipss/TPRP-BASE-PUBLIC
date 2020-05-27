local CurrentVersion = '2.0.0'
local GithubResourceName = 'RadarWhileDriving'

PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
	PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGES', function(Error, Changes, Header)
	
		if CurrentVersion ~= NewestVersion then

		else
		
		end

	end)
end)

