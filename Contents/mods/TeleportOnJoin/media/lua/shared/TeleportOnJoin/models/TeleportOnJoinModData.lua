---
--- Created by Max
--- Created on: 02/08/2025
---

--- TeleportOnJoinModData class
---@class TeleportOnJoinModData
---@field entries table[] A list of teleport entries, each containing a player name and coordinates.
local TeleportOnJoinModData = {}
TeleportOnJoinModData.__index = TeleportOnJoinModData

function TeleportOnJoinModData:new()
    local obj = { entries = {} }
    setmetatable(obj, self)
    return obj
end

--- Add an entry to the mod data.
---@param playerName string
---@param coords table
---@return void
function TeleportOnJoinModData:addEntry(playerName, coords)
    if self:hasEntry(playerName, coords) then
        return
    end
    table.insert(self.entries, { player = playerName, coords = coords })
end

--- Check if an entry exists in the mod data.
---@param playerName string
---@param coords table
---@return boolean
function TeleportOnJoinModData:hasEntry(playerName, coords)
    for _, entry in ipairs(self.entries) do
        if entry.player == playerName and entry.coords.X == coords.X and entry.coords.Y == coords.Y and entry.coords.Z == coords.Z then
            return true
        end
    end
    return false
end

--- Merge another TeleportOnJoinModData into this one.
---@param other TeleportOnJoinModData
---@return void
function TeleportOnJoinModData:merge(other)
    for _, entry in ipairs(other.entries) do
        if not self:hasEntry(entry.player, entry.coords) then
            self:addEntry(entry.player, entry.coords)
        end
    end
end

return TeleportOnJoinModData