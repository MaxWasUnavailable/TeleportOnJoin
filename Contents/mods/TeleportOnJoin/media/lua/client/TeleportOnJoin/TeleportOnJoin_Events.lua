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
    local player = getPlayer()
    local coords = Sandbox.getCoordinates()

    if shouldTeleport(player) then
        Utils.teleportPlayer(player, coords)
    end

    -- if current player position is within 10m of the target position, we unsubscribe
    if math.abs(player:getX() - coords.X) < 10 and math.abs(player:getY() - coords.Y) < 10 and math.abs(player:getZ() - coords.Z) < 10 then
        HaloTextHelper.addText(player, "You find yourself somewhere new..", HaloTextHelper.getColorWhite())
        local modData = ModDataUtils.getModData()
        modData:addEntry(player:getDisplayName(), coords)
        ModDataUtils.setModData(modData)

        Events.OnTick.Remove(handlePlayerTeleport)
    end
end

--- Schedule the player teleport event to be handled on the next tick.
---@return void
local function schedulePlayerTeleport(_, _)
    if not Sandbox.getEnabled() then
        return
    end
    Events.OnTick.Add(handlePlayerTeleport)
end

-- Init

Events.OnCreatePlayer.Add(schedulePlayerTeleport)
Utils.log("Hooked into onCreatePlayer event.")