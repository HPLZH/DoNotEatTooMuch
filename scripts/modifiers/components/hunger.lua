local CONFIG = TUNING.DO_NOT_EAT_TOO_MUCH

local function override_DoDelta(self, delta, overtime, ignore_invincible)
    --[[
    原方法: components.hunger:DoDelta
    此方法是对游戏原有方法的改写，并且不会调用原方法
    此mod与改写此方法且不调用原方法的mod不兼容
    此mod需要在改写此方法的其他mod被加载前被加载

    此方法是对游戏源代码进行整合与修改而成(DS,DST)
    游戏源代码的版权归 Klei Entertainment 所有
    使用这部分代码需要遵循 Klei Entertainment 的相关要求
    --]]
    if (TheSim.GetGameID ~= nil and TheSim:GetGameID() == "DST") then
        if self.redirect ~= nil then
            self.redirect(self.inst, delta, overtime)
            return
        end
        if not ignore_invincible and self.inst.components.health and self.inst.components.health:IsInvincible() or self.inst.is_teleporting then
            return
        end
    else
        if self.redirect then
            self.redirect(self.inst, delta, overtime)
            return
        end
        if not ignore_invincible and self.inst.components.health.invincible == true or self.inst.is_teleporting == true then
            return
        end
    end

    local old = self.current
    local newValue = self.current + delta
    if newValue < 0 then
        newValue = 0
    end
    self.current = newValue
    
    if self.current <= 0 and old > 0 then
        if self.onStarve then
            self.onStarve(self.inst)
        end
    end

    if (TheSim.GetGameID ~= nil and TheSim:GetGameID() == "DST") then
        self.inst:PushEvent("hungerdelta",
            {
                oldpercent = old / self.max,
                newpercent = self.current / self.max,
                overtime = overtime,
                delta = self.current - old
            })
        if old > 0 then
            if self.current <= 0 then
                self.inst:PushEvent("startstarving")
                ProfileStatsSet("started_starving", true)
            end
        elseif self.current > 0 then
            self.inst:PushEvent("stopstarving")
            ProfileStatsSet("stopped_starving", true)
        end
    else
        self.inst:PushEvent("hungerdelta",
            { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime })
        if old > 0 and self.current <= 0 then
            self.inst:PushEvent("startstarving")
            ProfileStatsSet("started_starving", true)
        elseif old <= 0 and self.current > 0 then
            self.inst:PushEvent("stopstarving")
            ProfileStatsSet("stopped_starving", true)
        end
    end
end

local function override_DoDec(self, dt, ignore_damage)
    local multiplier = 1
    if (self.inst.components.health ~= nil and self.inst.components.health.overflow ~= nil) then
        if not self.inst:HasTag("MOD_DO_NOT_EAT_TOO_MUCH_DANGER") then
            if (self.inst.sg ~= nil and self.inst.sg:HasStateTag("moving")) then
                multiplier = CONFIG.HUNGER_MOVING_MULTIPLIER
                if self:GetPercent() > CONFIG.HEALTH_RANDOM_DROP_POINT then
                    self.inst.components.health.overflow.sum = self.inst.components.health.overflow.sum +
                        (self:GetPercent() - 1) * dt * math.random()
                end
                if self.inst.components.health.overflow.sum < 0 then
                    self.inst.components.health.overflow.sum = 0
                end
                if self.inst.components.health.overflow.sum * math.random() > CONFIG.HEALTH_DROP_POINT - CONFIG.HEALTH_RANDOM_DROP_POINT then
                    self.inst.components.health.overflow.sum = 0
                    self.inst.components.health:DoDelta(-self.inst.components.health.overflow.damage * CONFIG.HEALTH_FREQ, false, "food")
                    self.inst.components.health.overflow.hurt_count = self.inst.components.health.overflow.hurt_count + 1
                    if self.inst.components.health.overflow.hurt_count > CONFIG.HEALTH_HURT_COUNT then
                        self.inst:AddTag("MOD_DO_NOT_EAT_TOO_MUCH_DANGER")
                        self.inst.components.health.overflow.hurt_count = 0
                    end
                end
            else
                self.inst.components.health.overflow.sum = self.inst.components.health.overflow.sum +
                    (self:GetPercent() - CONFIG.HEALTH_DROP_POINT) *
                    (CONFIG.HEALTH_DROP_POINT - CONFIG.HEALTH_RANDOM_DROP_POINT) * dt * math.random()
                if self.inst.components.health.overflow.sum < 0 then
                    self.inst.components.health.overflow.sum = 0
                    if self.inst.components.health.overflow.hurt_count > CONFIG.HEALTH_HURT_COUNT * (self:GetPercent() - 1) / (CONFIG.HEALTH_DROP_POINT - 1) then
                        self.inst.components.health.overflow.hurt_count =
                            self.inst.components.health.overflow.hurt_count - 1
                        self.inst.components.health.overflow.sum =
                            CONFIG.HEALTH_DROP_POINT - CONFIG.HEALTH_RANDOM_DROP_POINT
                    end
                end
            end
        else
            self.inst.components.health.overflow.sum = 0
            self.inst.components.health.overflow.hurt_count = 0
        end
    end

    self:overflow_old_DoDec(dt * multiplier, ignore_damage)
end

local function override_hunger(self)
    self.DoDelta = override_DoDelta
    self.overflow_old_DoDec = self.DoDec
    self.DoDec = override_DoDec
end

return override_hunger
