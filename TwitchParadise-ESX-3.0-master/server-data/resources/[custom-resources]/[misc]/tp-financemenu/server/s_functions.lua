UpdateFinance = function(vehicleProps, amount)
	local sqlQuery = [[
		UPDATE
			owned_vehicles
		SET
			finance = @finance
		WHERE
			plate = @plate
	]]

	MySQL.Async.execute(sqlQuery, {
		["@plate"] = vehicleProps["plate"],
		["@finance"] = amount,
	}, function(rowsChanged)
		if rowsChanged > 0 then
			-- Finance was updated.
		end
	end)
end