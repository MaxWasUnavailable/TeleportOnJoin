---
--- Created by Max
--- Created on: 02/08/2025
---

--- Misc / util / helper methods
---@class TeleportOnJoinModDataUtils
local ModDataUtils = {}

---@type TeleportOnJoin
local TeleportOnJoin = require "shared/TeleportOnJoin/TeleportOnJoin"

---@type TeleportOnJoinUtils
local Utils = require "shared/TeleportOnJoin/TeleportOnJoin_Utils"

---@type TeleportOnJoinModData
local TeleportOnJoinModData = require "shared/TeleportOnJoin/models/TeleportOnJoinModData"

--- Get the mod data for TeleportOnJoin as a TeleportOnJoinModData instance.
---@return TeleportOnJoinModData
ModDataUtils.getModData = function()
    local raw = ModData.getOrCreate(TeleportOnJoin.modName)
    if raw.entries == nil then
        return TeleportOnJoinModData:new()
    end
    local obj = TeleportOnJoinModData:new()
    obj.entries = raw.entries
    return obj
end

--- Set the mod data for TeleportOnJoin from a TeleportOnJoinModData instance.
---@param data TeleportOnJoinModData
ModDataUtils.setModData = function(data)
    local modData = ModDataUtils.getModData()
    if not data or not data.entries then
        Utils.log("Invalid mod data provided. Cannot set mod data.")
        return
    end
    modData:merge(data)
    ModData.add(TeleportOnJoin.modName, modData)
end

return ModDataUtils