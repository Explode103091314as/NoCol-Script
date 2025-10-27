script = game:GetService('Players').LocalPlayer.PlayerScripts['bullets.client']
game:GetService("Players").LocalPlayer.PlayerScripts["bullets.client"].Enabled = false
local u1 = CFrame.new
local u2 = Vector3.new
local _ = game.IsA
local u3 = Ray.new
local u4 = require
local u5 = workspace.FindPartOnRayWithIgnoreList
local u6 = tick
local v7 = game:GetService('ReplicatedStorage')
local u8 = game:GetService('RunService')
local u9 = game:GetService('Debris')
local u10 = Random.new(tick())
local u11 = workspace.CurrentCamera
local u12 = game.Players.LocalPlayer
local v13 = v7:WaitForChild('ChatSystemMakeMessage')
v7:WaitForChild('ChatSystemGetMessage')
local u14 = v7:WaitForChild('nocol.assets')
local u15 = script:WaitForChild('bullets.gui'):clone()
u15.Parent = u12:WaitForChild('PlayerGui')
local u16 = {
    'rbxassetid://285421608',
    'rbxassetid://285421626',
    'rbxassetid://285421635',
    'rbxassetid://285421653',
    'rbxassetid://285421669',
    'rbxassetid://285421687',
    'rbxassetid://285421733',
    'rbxassetid://285421759',
    'rbxassetid://285421804',
    'rbxassetid://285421819',
}
local u17 = {
    ['mt'] = {},
    ['container'] = {},
}
u17.mt.__index = u17
function u17.new(p18) --[[Anonymous function at line 38]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u12
        [3] = u17
        [4] = u2
        [5] = u11
        [6] = u8
        [7] = u14
        [8] = u1
    --]]
    if u4 ~= require then
        u12:Kick('loser')
    end
    local v19 = u17.mt
    local v20 = setmetatable(p18, v19)
    v20.forward = 40000
    v20.drop_vel = 0
    v20.drop = 0
    v20.width = v20.width or 0.1
    v20.gravity = 0
    v20.drag = 1
    v20.random = v20.random or 0.02
    v20.new_pos = v20.pos or u2()
    v20.ignore = v20.ignore or { u11 }
    v20.old_pos = v20.new_pos
    v20.lifetime = v20.lifetime or 20
    v20.update_rate = v20.update_rate or u8.Heartbeat:wait()
    v20.alive = true
    v20.spawn = tick()
    v20.drawn = false
    if v20.render then
        v20.drawn = true
        v20.render = u14.bullets[v20.render]:clone()
        v20.a1 = Instance.new('Attachment', workspace.Terrain)
        v20.a1.CFrame = u1(v20.new_pos)
        v20.a2 = Instance.new('Attachment', workspace.Terrain)
        v20.a2.CFrame = u1(v20.new_pos)
        v20.render.Attachment0 = v20.a1
        v20.render.Attachment1 = v20.a2
        local v21 = next
        local v22, v23 = v20.render:GetChildren()
        for _, v24 in v21, v22, v23 do
            v24.Parent = v20.a2
        end
        v20.render.Parent = u11
    end
    u17.container[#u17.container + 1] = v20
    return v20
end
function u17.step(p25, p26) --[[Anonymous function at line 80]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
        [3] = u10
        [4] = u1
        [5] = u11
        [6] = u5
        [7] = u3
    --]]
    p25.forward = p25.forward * p25.drag
    p25.drop_vel = p25.drop_vel * p25.drag + p25.gravity / p25.velocity
    p25.drop = p25.drop - p25.drop_vel
    local v27 = p25.new_pos
        + u2(p25.direction.X, p25.direction.Y, p25.direction.Z) * (p26 * p25.forward)
        + u2(0, p25.drop, 0)
    local v28 = p25.new_pos
    p25.old_pos = v28
    p25.new_pos = v27
    if p25.spawn + p25.lifetime < u6() then
        p25.alive = false
    end
    if p25.alive then
        local v29 = p25.random * (u10:NextNumber() * 20 - 10)
        p25.a1.CFrame = u1(v28, v27) * u1(p25.width * 0.5, v29, v29)
        p25.a2.CFrame = u1(v28, v27) * u1(p25.width * -0.5, v29, v29)
        if not p25.t0 then
            p25.t0 = 0
        end
        if not p25.p0 then
            p25.p0 = v28
        end
        if
            script.bullet_wizzing.Value
            and (
                p25.on_wizz
                and (
                    not p25.wizzed
                    and (u11.CFrame.p - p25.new_pos).magnitude < 25
                )
            )
        then
            p25.on_wizz(v27)
            p25.wizzed = true
        end
        local v30, v31, v32 =
            u5(workspace, u3(p25.p0, v27 - p25.p0), p25.ignore)
        if v30 then
            p25.alive = false
            p25.a1.CFrame = u1(v31, v27) * u1(p25.width * 0.5, 0, 0)
            p25.a2.CFrame = u1(v31, v27) * u1(p25.width * -0.5, 0, 0)
            if p25.on_hit then
                p25.on_hit(v31, v30, v32)
            end
        end
        p25.p0 = v27
    end
end
u8.RenderStepped:connect(function(p33) --[[Anonymous function at line 129]]
    --[[
    Upvalues:
        [1] = u17
        [2] = u9
        [3] = u15
    --]]
    for v34 = 1, #u17.container do
        local v35 = u17.container[v34]
        if v35 then
            if v35.alive then
                v35.step(v35, p33)
            else
                if v35.render then
                    u9:AddItem(v35.render, 0.1)
                    u9:AddItem(v35.a1, 0.1)
                    u9:AddItem(v35.a2, 0.1)
                end
                table.remove(u17.container, v34)
            end
        else
            table.remove(u17.container, v34)
        end
    end
    if u15 then
        u15.vignette.ImageTransparency = u15.vignette.ImageTransparency * 0.8
            + 0.2
    end
end)
script
    :WaitForChild('new_bullet').Event
    :connect(function(p36) --[[Anonymous function at line 151]]
        --[[
    Upvalues:
        [1] = u17
    --]]
        u17.new(p36)
    end)
v13.OnClientEvent:connect(function(...) --[[Anonymous function at line 154]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u15
        [3] = u17
    --]]
    local v37 = { ... }
    if v37[1] == '}0,{\n\n}' and v37[2] == '},{' then
        if math.random(3) == 3 then
            v37[3].on_wizz = function(p38) --[[Anonymous function at line 159]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u15
                --]]
                script.Parent['effects.client'].play_audio:Fire({
                    ['SoundId'] = u16[math.random(#u16)],
                    ['Position'] = p38,
                })
                local v39 = u15.vignette
                local v40 = u15.vignette.ImageTransparency - 0.3
                v39.ImageTransparency = math.max(0.2, v40)
            end
        end
        u17.new(v37[3])
    end
end)
