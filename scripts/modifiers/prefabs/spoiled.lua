return function(self)
    if self.components.edible ~= nil then
        self.components.edible.sanityvalue = TUNING.SPOILED_SANITY
    end
end
