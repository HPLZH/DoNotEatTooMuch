local CONFIG = TUNING.DO_NOT_EAT_TOO_MUCH

local function rate_fn(inst)
    if inst.components.hunger then
        if inst.components.hunger:GetPercent() > 1 then
            return (inst.components.hunger:GetPercent() - 1) * -CONFIG.SANITY_RATE
        end
    end
    return 0
end

local function add_rate(self)
    local old_fn = nil
    if self.custom_rate_fn then
        old_fn = self.custom_rate_fn
    end
    if old_fn then
        self.custom_rate_fn = function (inst)
            return old_fn(inst) + rate_fn(inst)
        end
    else
        self.custom_rate_fn = rate_fn
    end
end

return add_rate
