local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local placeId = game.PlaceId

local url = string.format(
    "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100",
    placeId
)

local success, response = pcall(function()
    return game:HttpGet(url)
end)

if success then
    local data = HttpService:JSONDecode(response)

    for _, server in ipairs(data.data) do
        -- Find a server that isn't full and isn't the current server
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(
                placeId,
                server.id,
                player
            )
            break
        end
    end
else
    warn("Failed to retrieve server list.")
end
