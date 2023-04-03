local CONFIG = TUNING.DO_NOT_EAT_TOO_MUCH

local function override_GetSpeedMultiplier(self)
    local hunger_multiplier = 1
    local sanity_multiplier = 1
    if self.inst.components.hunger ~= nil then
        local hunger_percent = self.inst.components.hunger:GetPercent()
        if hunger_percent > 1 then
            hunger_multiplier = (1 + CONFIG.BASIC_MASS) / (hunger_percent + CONFIG.BASIC_MASS)
            if self.inst.components.sanity ~= nil then
                local sanity_percent = self.inst.components.sanity:GetPercent()
                sanity_multiplier = CONFIG.SPEED_SANITY_MULTIPLIER_MIN +
                    (1 - CONFIG.SPEED_SANITY_MULTIPLIER_MIN) * sanity_percent
            end
        end
    end
    return self:overflow_old_GetSpeedMultiplier() * hunger_multiplier * (sanity_multiplier ^ hunger_multiplier)
end

local function add_slowdown(self)
    self.overflow_old_GetSpeedMultiplier = self.GetSpeedMultiplier
    self.GetSpeedMultiplier = override_GetSpeedMultiplier
end

return add_slowdown
