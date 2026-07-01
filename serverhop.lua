local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local placeId = game.PlaceId

local data = HttpService:JSONDecode(
    game:HttpGet(
        ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100")
        :format(placeId)
    )
)

local bestServer

for _, server in ipairs(data.data) do
    if server.id ~= game.JobId and server.playing < server.maxPlayers then
        if not bestServer or server.playing < bestServer.playing then
            bestServer = server
        end
    end
end

if bestServer then
    TeleportService:TeleportToPlaceInstance(
        placeId,
        bestServer.id,
        player
    )
end
