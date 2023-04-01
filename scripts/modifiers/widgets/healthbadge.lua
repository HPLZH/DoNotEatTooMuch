local CONFIG = TUNING.DO_NOT_EAT_TOO_MUCH

local function override_OnUpdate_DST(self, dt)
    if TheNet:IsServerPaused() then return end

    local down
    if (self.owner.IsFreezing ~= nil and self.owner:IsFreezing()) or
        (self.owner.replica.health ~= nil and self.owner.replica.health:IsTakingFireDamageFull()) or
        (self.owner.replica.hunger ~= nil and self.owner.replica.hunger:IsStarving()) or
        (self.owner.replica.health ~= nil and self.owner.replica.hunger ~= nil and self.owner:HasTag("MOD_DO_NOT_EAT_TOO_MUCH_DANGER") and self.owner.replica.hunger:GetPercent() > CONFIG.HEALTH_DROP_STOP_POINT) or -- Added
        next(self.corrosives) ~= nil then
        down = "_most"
    elseif self.owner.IsOverheating ~= nil and self.owner:IsOverheating() then
        down = self.owner:HasTag("heatresistant") and "_more" or "_most"
    end

    -- Show the up-arrow when we're sleeping (but not in a straw roll: that doesn't heal us)
    local up = down == nil and
        (
        ((self.owner.player_classified ~= nil and self.owner.player_classified.issleephealing:value()) or
        next(self.hots) ~= nil or next(self.small_hots) ~= nil or
        (self.owner.replica.inventory ~= nil and self.owner.replica.inventory:EquipHasTag("regen"))
        ) or
        (self.owner:HasDebuff("wintersfeastbuff"))
        ) and
        self.owner.replica.health ~= nil and self.owner.replica.health:IsHurt()

    local anim =
        (down ~= nil and ("arrow_loop_decrease" .. down)) or
        (not up and "neutral") or
        (next(self.hots) ~= nil and "arrow_loop_increase_most") or
        "arrow_loop_increase"

    if self.arrowdir ~= anim then
        self.arrowdir = anim
        self.sanityarrow:GetAnimState():PlayAnimation(anim, true)
    end
end

local function override_OnUpdate_DS(self, dt)
    local down = (self.owner.components.temperature.IsOverheating ~= nil and self.owner.components.temperature:IsOverheating()) or
        self.owner.components.temperature:IsFreezing() or
        self.owner.components.hunger:IsStarving() or
        self.owner.components.health:overflow_IsDropping() or
        self.owner.components.health.takingfiredamage

    local poison
    if self.owner.components.poisonable ~= nil then
        if self.owner.components.poisonable.IsPoisoned ~= nil then
            poison = self.owner.components.poisonable:IsPoisoned()
        end
    end

    local anim
    if poison ~= nil then
        anim = poison and "arrow_loop_decrease_more" or "neutral"
        anim = down and "arrow_loop_decrease_most" or anim
    else
        anim = down and "arrow_loop_decrease_most" or "neutral"
    end

    if anim and self.arrowdir ~= anim then
        self.arrowdir = anim
        self.sanityarrow:GetAnimState():PlayAnimation(anim, true)
    end

    if poison ~= nil then
        if self.poison ~= poison then
            self.poison = poison
            if poison then
                self.poisonanim:GetAnimState():PlayAnimation("activate")
                self.poisonanim:GetAnimState():PushAnimation("idle", true)
                self.poisonanim:Show()
            else
                self.owner.SoundEmitter:PlaySound("dontstarve_DLC002/common/HUD_antivenom_use")
                self.poisonanim:GetAnimState():PlayAnimation("deactivate")
            end
        end
    end
end

local function override(self)
    if TheSim:GetGameID() == "DST" then
        self.OnUpdate = override_OnUpdate_DST
    else
        self.OnUpdate = override_OnUpdate_DS
    end
end

return override
