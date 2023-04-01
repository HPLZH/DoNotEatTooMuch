local CONFIG = TUNING.DO_NOT_EAT_TOO_MUCH

local function override_GetSpeedMultiplier(self)
    return self:overflow_old_GetSpeedMultiplier() * self.overflow_multiplier
end

local function onHungerChanged(source, data)
    if data.newpercent > 1 then
        source.components.locomotor.overflow_multiplier = (1 + CONFIG.BASIC_MASS) / (data.newpercent + CONFIG.BASIC_MASS)
    else
        source.components.locomotor.overflow_multiplier = 1
    end
end

local function add_slowdown(self)
    self.overflow_multiplier = 1
    self.overflow_hungerChanged = onHungerChanged
    self.overflow_old_GetSpeedMultiplier = self.GetSpeedMultiplier
    self.GetSpeedMultiplier = override_GetSpeedMultiplier
    self.inst:ListenForEvent("hungerdelta", self.overflow_hungerChanged, self.inst)
end

return add_slowdown
