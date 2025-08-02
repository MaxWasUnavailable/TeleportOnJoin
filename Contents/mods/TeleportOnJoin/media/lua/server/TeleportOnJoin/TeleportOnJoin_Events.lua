---
--- Created by Max
--- Created on: 02/08/2025
---

---@type TeleportOnJoin
local TeleportOnJoin = require "TeleportOnJoin/TeleportOnJoin"

---@type TeleportOnJoinUtils
local Utils = require "TeleportOnJoin/TeleportOnJoin_Utils"

---@type TeleportOnJoinSandbox
local Sandbox = require "TeleportOnJoin/TeleportOnJoin_Sandbox"

---@type TeleportOnJoinModDataUtils
local ModDataUtils = require "TeleportOnJoin/TeleportOnJoin_ModDataUtils"

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
local function onPlayerJoin(_, player)
    if shouldTeleport(player) then
        local coords = Sandbox.getCoordinates()
        Utils.teleportPlayer(player, coords)

        local modData = ModDataUtils.getModData()
        modData:addEntry(player:getDisplayName(), coords)
        ModDataUtils.setModData(modData)
    end
end

-- Init

--- Initialize the mod and add event hooks.
---@return void
TeleportOnJoin.init = function()
    Events.onCreatePlayer(onPlayerJoin)

    Utils.log(TeleportOnJoin.modVersion .. " initialized.")

    Events.OnConnected.Remove(TeleportOnJoin.init)
end

-- Init hook

Events.OnConnected.Add(TeleportOnJoin.init)