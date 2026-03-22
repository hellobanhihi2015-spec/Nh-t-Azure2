local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Nhật Script W-Azure V2 🌊 (FULL SKID)", HidePremium = false, SaveConfig = true, ConfigFolder = "NhatAzureV2"})

-- [[ BIẾN ĐIỀU KHIỂN - SIÊU DÀI ]]
_G.AutoFarm = false
_G.AutoClick = false
_G.BringMob = true
_G.AutoLeviathan = false
_G.AutoSkill = false
_G.AntiShark = true
_G.BoatFly = false
_G.AutoChest = false
_G.AutoStats = "None"
_G.Weapon = "Melee"
_G.AutoRaid = false
_G.AutoBone = false

-- [[ HÀM HỖ TRỢ CHIẾN ĐẤU ]]
function Click()
    game:service'VirtualUser':CaptureController()
    game:service'VirtualUser':ClickButton1(Vector2.new(0,0))
end

-- [[ TABS GIAO DIỆN ]]
local Tab1 = Window:MakeTab({Name = "Main Farm", Icon = "rbxassetid://4483362458"})
local Tab2 = Window:MakeTab({Name = "Leviathan & Sea", Icon = "rbxassetid://4483362458"})
local Tab3 = Window:MakeTab({Name = "Raid & Bone", Icon = "rbxassetid://4483362458"})
local Tab4 = Window:MakeTab({Name = "Stats & Chest", Icon = "rbxassetid://4483362458"})
local Tab5 = Window:MakeTab({Name = "Teleport", Icon = "rbxassetid://4483362458"})

-- [[ TAB 1: AUTO FARM LEVEL ]]
Tab1:AddDropdown({
    Name = "Chọn Vũ Khí",
    Default = "Melee",
    Options = {"Melee", "Sword", "Fruit"},
    Callback = function(v) _G.Weapon = v end    
})

Tab1:AddToggle({
    Name = "Auto Farm Level (Full Quest)",
    Default = false,
    Callback = function(v) _G.AutoFarm = v end    
})

Tab1:AddToggle({
    Name = "Auto Click (Fast Attack)",
    Default = false,
    Callback = function(v) _G.AutoClick = v end    
})

-- [[ TAB 2: LEVIATHAN HUNTER ]]
Tab2:AddToggle({
    Name = "Auto Tìm & Đánh Leviathan",
    Default = false,
    Callback = function(v) _G.AutoLeviathan = v end    
})

Tab2:AddToggle({
    Name = "Auto Skill (Z,X,C,V) Vả Levi",
    Default = false,
    Callback = function(v) _G.AutoSkill = v end    
})

Tab2:AddToggle({
    Name = "Boat Fly (Né Cá Mập)",
    Default = false,
    Callback = function(v) _G.BoatFly = v end
})

-- [[ TAB 3: RAID & BONE ]]
Tab3:AddToggle({
    Name = "Auto Farm Bone (Sea 3)",
    Default = false,
    Callback = function(v) _G.AutoBone = v end    
})

Tab3:AddToggle({
    Name = "Auto Raid (Dọn đảo)",
    Default = false,
    Callback = function(v) _G.AutoRaid = v end    
})

-- [[ TAB 4: STATS & CHEST ]]
Tab4:AddToggle({
    Name = "Auto Gom Rương (Auto Chest)",
    Default = false,
    Callback = function(v) _G.AutoChest = v end
})

Tab4:AddDropdown({
    Name = "Auto Tăng Điểm (Stats)",
    Default = "None",
    Options = {"None", "Melee", "Defense", "Sword", "Fruit"},
    Callback = function(v) _G.AutoStats = v end
})

-- [[ TAB 5: TELEPORT ]]
Tab5:AddButton({Name = "Dịch chuyển: Sea 1", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end})
Tab5:AddButton({Name = "Dịch chuyển: Sea 2", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") end})
Tab5:AddButton({Name = "Dịch chuyển: Sea 3", Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end})

-- [[ LOGIC XỬ LÝ SIÊU NẶNG ]]
spawn(function()
    while wait() do
        if _G.AutoClick then pcall(function() Click() end) end
        
        -- Logic Farm Level
        if _G.AutoFarm then
            pcall(function()
                local Enemy = game.Workspace.Enemies:FindFirstChildOfClass("Model")
                if Enemy and Enemy:FindFirstChild("HumanoidRootPart") then
                    if _G.BringMob then
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") then
                                v.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame
                                v.HumanoidRootPart.CanCollide = false
                            end
                        end
                    end
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                end
            end)
        end

        -- Logic Auto Chest
        if _G.AutoChest then
            for i,v in pairs(game.Workspace:GetChildren()) do
                if v.Name:find("Chest") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    wait(0.1)
                end
            end
        end

        -- Logic Leviathan (Tìm và Né Shark)
        if _G.AutoLeviathan then
            local Levi = game.Workspace.Enemies:FindFirstChild("Leviathan") or game.Workspace.Enemies:FindFirstChild("Leviathan Segment")
            if Levi then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Levi.CFrame * CFrame.new(0, 35, 0)
                if _G.AutoSkill then
                    local keys = {"Z", "X", "C", "V"}
                    for _, k in pairs(keys) do
                        game:service'VirtualInputManager':SendKeyEvent(true, k, false, game)
                        wait(0.1)
                        game:service'VirtualInputManager':SendKeyEvent(false, k, false, game)
                    end
                end
            end
        end

        -- Boat Fly né Shark
        if _G.BoatFly then
            local Boat = game.Workspace.Boats:FindFirstChild(game.Players.LocalPlayer.Name .. "Boat") or game.Workspace.Boats:FindFirstChild("Boat")
            if Boat and Boat:FindFirstChild("VehicleSeat") then
                Boat.VehicleSeat.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 180
                for _,s in pairs(game.Workspace.Enemies:GetChildren()) do
                    if s.Name == "Terror Shark" and _G.AntiShark then
                        Boat.VehicleSeat.Velocity = Vector3.new(0, 120, 0)
                    end
                end
            end
        end
    end
end)

OrionLib:Init()
