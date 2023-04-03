local CONFIG = TUNING.DO_NOT_EAT_TOO_MUCH

local function DoDamage(self)
    if not self:IsDead() then
        self:DoDelta(-self.overflow.damage, true, "food")
    end
end

local function startDamage(self)
    if self.overflow.task ~= nil then
        self.overflow.task:Cancel()
    end
    self.overflow.task = self.inst:DoPeriodicTask(self.overflow.period, function() self:overflow_damage() end)
end

local function stopDamage(self)
    if self.overflow.task ~= nil then
        self.overflow.task:Cancel()
    end
    self.overflow.task = nil
end

local function onHungerChanged(inst, data)
    if data.newpercent > CONFIG.HEALTH_DROP_STOP_POINT then
        inst.components.health.overflow.damage = (data.newpercent - CONFIG.HEALTH_CURE_POINT) * CONFIG.HEALTH_RATE
    else
        inst.components.health.overflow.damage = 0
    end
    if inst:HasTag("MOD_DO_NOT_EAT_TOO_MUCH_DANGER") then
        if data.newpercent > CONFIG.HEALTH_DROP_STOP_POINT then
            if inst.components.health.overflow.task == nil then
                inst.components.health:overflow_start()
            end
        else
            if inst.components.health.overflow.task ~= nil then
                inst.components.health:overflow_stop()
            end
            if data.newpercent < CONFIG.HEALTH_CURE_POINT then
                inst:RemoveTag("MOD_DO_NOT_EAT_TOO_MUCH_DANGER")
            end
        end
    else
        if data.newpercent > CONFIG.HEALTH_DROP_POINT then
            inst:AddTag("MOD_DO_NOT_EAT_TOO_MUCH_DANGER")
            if inst.components.health.overflow.task == nil then
                inst.components.health:overflow_start()
            end
        end
    end
    
    if inst:HasTag("player") then
        if data.newpercent > data.oldpercent then
            if inst.components.health:overflow_IsDropping() then
                inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_EAT", "MOD_DO_NOT_EAT_TOO_MUCH_DANGER"))
            elseif data.newpercent > 1 then
                if data.oldpercent > 1 then
                    inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_EAT", "MOD_DO_NOT_EAT_TOO_MUCH_OVERFLOW"))
                else
                    inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_EAT", "MOD_DO_NOT_EAT_TOO_MUCH_FULL"))
                end
            end
        end
    end
end

local function add_overflow_damage(self)
    self.overflow = {}
    self.overflow.damage = 0
    self.overflow.period = 0.1
    self.overflow.sum = 0
    self.overflow.hurt_count = 0
    self.overflow.task = nil
    self.overflow_IsDropping = function(self)
        return self.overflow.task ~= nil
    end
    self.overflow_start = startDamage
    self.overflow_stop = stopDamage
    self.overflow_hungerChanged = onHungerChanged
    self.overflow_damage = DoDamage
    self.inst:ListenForEvent("hungerdelta", self.overflow_hungerChanged, self.inst)
end

return add_overflow_damage
