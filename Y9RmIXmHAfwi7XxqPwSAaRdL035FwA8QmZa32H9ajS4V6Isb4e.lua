local CrossHairList = {}
local Cross
local plr = game.Players.LocalPlayer
local ParticleToolsModule = require(game.ReplicatedStorage.LocalFX.LocalTargetPracticeBeam)
local LocalFlyingEntityModule = require(game.ReplicatedStorage.LocalFlyingEntity)
game.Workspace.Particles.ChildAdded:Connect(function(v)
    if v.Name == "Crosshair" and v ~= nil and v.BrickColor ~= BrickColor.new("Forest green") and v.BrickColor ~= BrickColor.new("Flint") then
        Cross = v
    end
end)
local old
old = hookfunction(ParticleToolsModule.Make,function(...) 
    local Arg = ...
    if tostring(Arg.Player)==plr.Name then 
        if Arg.Action == "Make" then 
            Cross = nil
            local a = old(...)
            if Cross and Arg.FEID then 
                local partcross = LocalFlyingEntityModule.GetEntity(Arg.FEID).Part
                if partcross then 
                    if not CrossHairList[partcross] then 
                        CrossHairList[partcross] = {}
                    end
                    table.insert(CrossHairList[partcross],Cross)
                end
                
            end
            return a
        end
    end
    return old(...)
end)
return CrossHairList
