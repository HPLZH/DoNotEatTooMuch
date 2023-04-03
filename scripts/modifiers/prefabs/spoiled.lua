return function(self)
    if (TheSim.GetGameID ~= nil and TheSim:GetGameID() == "DST" and TheNet:GetIsClient()) then
    else
        self.components.edible.sanityvalue = TUNING.SPOILED_SANITY
    end
end
