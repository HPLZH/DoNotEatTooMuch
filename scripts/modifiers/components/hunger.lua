local function override_DoDelta(self, delta, overtime, ignore_invincible)
    --[[
    原方法: components.hunger:DoDelta
    此方法是对游戏原有方法的改写，并且不会调用原方法
    此mod与改写此方法且不调用原方法的mod不兼容
    此mod需要在改写此方法的其他mod被加载前被加载

    此方法是对游戏源代码进行整合与修改而成(DS,DST)
    游戏源代码的版权归 Klei Entertainment 所有

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
    self.current = self.current + delta
    if self.current < 0 then
        self.current = 0
    end

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

local function override_hunger(self)
    self.DoDelta = override_DoDelta
end

return override_hunger
