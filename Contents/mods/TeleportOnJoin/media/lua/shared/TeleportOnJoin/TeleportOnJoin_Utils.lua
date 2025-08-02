---
--- Created by Max
--- Created on: 02/08/2025
---

--- Misc / util / helper methods
---@class TeleportOnJoinUtils
local Utils = {}

---@type TeleportOnJoin
local TeleportOnJoin = require "TeleportOnJoin/TeleportOnJoin"

--- Log a message.
---@param mod TeleportOnJoin
---@param message string
---@return void
local log_internal = function(mod, message)
    print(mod.modName .. ": " .. message)
end

--- Log a message.
---@param message string
---@return void
Utils.log = function(message)
    log_internal(TeleportOnJoin, message)
end

--- Teleport a player to specified coordinates.
---@param player IsoPlayer
---@param coords table
---@return void
Utils.teleportPlayer = function(player, coords)
    if not player or not coords then
        Utils.log("Invalid player or coordinates for teleportation.")
        return
    end

    local x, y, z = coords.X, coords.Y, coords.Z
    if not x or not y or not z then
        Utils.log("Invalid coordinates provided for teleportation.")
        return
    end

    player:setX(x)
    player:setY(y)
    player:setZ(z)
    player:setLx(x)
    player:setLy(y)
    player:setLz(z)
    Utils.log("Teleported " .. player:getUsername() .. " to coordinates: (" .. x .. ", " .. y .. ", " .. z .. ")")
end

return Utils