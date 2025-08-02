---
--- Created by Max
--- Created on: 02/08/2025
---

--- Sandbox var helpers
---@class TeleportOnJoinSandbox
local Sandbox = {}

---@type TeleportOnJoinUtils
local Utils = require "shared/TeleportOnJoin/TeleportOnJoin_Utils"

--- Get the Enabled value.
---@return boolean
Sandbox.getEnabled = function()
    local value = SandboxVars.TeleportOnJoin.Enabled
    if value == nil then
        value = false
        Utils.log("Enabled not found. Using default value of " .. value .. ".")
    end
    return value
end

--- Get the coordinates value.
---@return table
Sandbox.getCoordinates = function()
    local coordsStr = SandboxVars.TeleportOnJoin.Coordinates
    if coordsStr == nil or coordsStr == "" then
        coordsStr = "0,0,0"
        Utils.log("Coordinates not found. Using default string: '0,0,0'.")
    end
    local x, y, z = coordsStr:match("(%-?%d+),(%-?%d+),(%-?%d+)")
    x = tonumber(x) or 0
    y = tonumber(y) or 0
    z = tonumber(z) or 0
    return { X = x, Y = y, Z = z }
end

return Sandbox