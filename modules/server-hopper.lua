return function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    print("🔄 SERVER HOPPING")
end
