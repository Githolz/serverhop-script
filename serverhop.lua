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

local validServers = {}

for _, server in ipairs(data.data) do
    if server.id ~= game.JobId
       and server.playing >= 1
       and server.playing <= 8
       and server.playing < server.maxPlayers then
        table.insert(validServers, server)
    end
end

if #validServers > 0 then
    local chosen = validServers[math.random(1, #validServers)]

    TeleportService:TeleportToPlaceInstance(
        placeId,
        chosen.id,
        player
    )
else
    warn("No servers with 1-8 players found.")
end
