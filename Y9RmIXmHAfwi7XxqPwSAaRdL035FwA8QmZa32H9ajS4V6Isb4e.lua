    local LocalFlyingEntityModule = require(game.ReplicatedStorage.LocalFlyingEntity)
    local ListCross = {}
    local Cross
    local plr = game.Players.LocalPlayer
    local ParticleToolsModule = require(game.ReplicatedStorage.LocalFX.LocalTargetPracticeBeam)
    game.Workspace.Particles.ChildAdded:Connect(function(v)
        if v.Name == "Crosshair" and v ~= nil and v.BrickColor ~= BrickColor.new("Forest green") and v.BrickColor ~= BrickColor.new("Flint") then
            Cross = v
        end
    end)
    local old
    old = hookfunction(ParticleToolsModule.Make,function(...) 
        local rac = ...
        if tostring(rac.Player)==plr.Name then 
            if rac.Action == "Make" then 
                Cross = nil
                local a = old(...)
                if Cross and rac and rac.FEID then 
                    local att = LocalFlyingEntityModule.GetEntity(rac.FEID).Part
                    if att then 
                        if not ListCross[att] then 
                            ListCross[att] = {}
                        end
                        table.insert(ListCross[att],Cross)
                    end
                    
                end
                return a
            end
        end
        return old(...)
    end)
    return ListCross
