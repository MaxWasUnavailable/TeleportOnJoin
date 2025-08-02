---
--- Created by Max
--- Created on: 02/08/2025
---

---@type TeleportOnJoinUtils
local Utils = require "TeleportOnJoin/TeleportOnJoin_Utils"

---@type TeleportOnJoinSandbox
local Sandbox = require "TeleportOnJoin/TeleportOnJoin_Sandbox"

---@type TeleportOnJoinModDataUtils
local ModDataUtils = require "TeleportOnJoin/TeleportOnJoin_ModDataUtils"

-- Variables

---@type IsoPlayer
local cachedPlayer = nil

-- Helper functions

--- Check if a player should be teleported.
---@param player IsoPlayer
---@return boolean
local shouldTeleport = function(player)
    local modData = ModDataUtils.getModData()
    local coords = Sandbox.getCoordinates()
    return not modData:hasEntry(player:getDisplayName(), coords)
end

-- Events

--- Teleport a player to the specified coordinates when they join the game.
---@return void
local function handlePlayerTeleport()
    Events.OnPlayerMove.Remove(handlePlayerTeleport)
    if not Sandbox.getEnabled() then
        return
    end

    if shouldTeleport(cachedPlayer) then
        local coords = Sandbox.getCoordinates()
        Utils.teleportPlayer(cachedPlayer, coords)

        local modData = ModDataUtils.getModData()
        modData:addEntry(cachedPlayer:getDisplayName(), coords)
        ModDataUtils.setModData(modData)
    end
    cachedPlayer = nil
end

--- Schedule the player teleport event to be handled when they next move. This is necessary to ensure the teleport
--- actually happens. Other methods seemed to be unreliable.
---@param _ number Unused parameter. Kept for compatibility with the event signature.
---@param player IsoPlayer Player to teleport
---@return void
local function schedulePlayerTeleport(_, player)
    cachedPlayer = player
    Events.OnPlayerMove.Add(handlePlayerTeleport)
end

-- Init

Events.OnCreatePlayer.Add(schedulePlayerTeleport)
Utils.log("Hooked into onCreatePlayer event.")