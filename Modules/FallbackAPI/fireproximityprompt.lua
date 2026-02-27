local assert, task = assert, task

return function(proximity_prompt)
    assert(typeof(proximity_prompt) == "Instance", string.format("bad argument #1 to 'fireproximityprompt' (Instance expected, got %s)", typeof(proximity_prompt)))
    assert(proximity_prompt.ClassName == "ProximityPrompt", string.format("bad argument #1 to 'fireproximityprompt' (ProximityPrompt expected, got %s)", proximity_prompt.ClassName))
    
    local modifying_properties = {
        "HoldDuration",
        "MaxActivationDistance",
        "Enabled",
        "RequiresLineOfSight"
    }

    local original_values = {}

    for index, property in pairs(modifying_properties) do
        original_values[property] = proximity_prompt[property]
        
        if index == 1 then
            proximity_prompt[property] = 0
        elseif index == 2 then
            proximity_prompt[property] = math.huge
        elseif index == 3 then
            proximity_prompt[property] = true
        else
            proximity_prompt[property] = false
        end
    end

    proximity_prompt:InputHoldBegin()
    task.wait()
    proximity_prompt:InputHoldEnd()

    for property, value in pairs(original_values) do
        proximity_prompt[property] = value
    end
end
