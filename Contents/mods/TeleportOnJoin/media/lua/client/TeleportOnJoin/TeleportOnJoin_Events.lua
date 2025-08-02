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
---@param _ number Unused parameter, kept for event signature compatibility (Player number)
---@param player IsoPlayer
---@return void
local function handlePlayerTeleport(_, player)
    Events.OnTick.Remove(handlePlayerTeleport)
    if not Sandbox.getEnabled() then
        return
    end

    if shouldTeleport(player) then
        local coords = Sandbox.getCoordinates()
        Utils.teleportPlayer(player, coords)

        local modData = ModDataUtils.getModData()
        modData:addEntry(player:getDisplayName(), coords)
        ModDataUtils.setModData(modData)
    end
end

local function schedulePlayerTeleport()
    Events.OnTick.Add(handlePlayerTeleport)
end

-- Init

Events.OnCreatePlayer.Add(schedulePlayerTeleport)
Utils.log("Hooked into onCreatePlayer event.")