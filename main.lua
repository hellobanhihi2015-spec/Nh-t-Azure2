local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Nhật Script W-Azure ULTIMATE 🌊", HidePremium = false, SaveConfig = true, ConfigFolder = "NhatAzureFull"})

-- [[ BIẾN TOÀN CỤC - SKID HẾT ]]
_G.AutoFarm = false
_G.AutoClick = false
_G.BringMob = true
_G.AutoLeviathan = false
_G.AutoSkill = false
_G.AntiShark = false
_G.BoatFly = false
_G.AutoChest = false
_G.AutoStats = "None"
_G.Weapon = "Melee"

-- [[ HÀM HỖ TRỢ CHIẾN ĐẤU ]]
local function Click()
    game:service'VirtualUser':CaptureController()
    game:service'VirtualUser':ClickButton1(Vector2.new(0,0))
end

-- [[ TABS GIAO DIỆN ]]
local Tab1 = Window:MakeTab({Name = "Main Farm", Icon = "rbxassetid://4483362458"})
local Tab2 = Window:MakeTab({Name = "Leviathan & Sea", Icon = "rbxassetid://4483362458"})
local Tab3 = Window:MakeTab({Name = "Auto Chest & Stats", Icon = "rbxassetid://4483362458"})
local Tab4 = Window:MakeTab({Name = "Teleport", Icon = "rbxassetid://4483362458"})

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
	Name = "Auto Săn Leviathan (Dịch chuyển/Đánh)",
	Default = false,
	Callback = function(v) _G.AutoLeviathan = v end    
})

Tab2:AddToggle({
	Name = "Auto Skill (Z, X, C, V) - Vả Levi",
	Default = false,
	Callback = function(v) _G.AutoSkill = v end    
})

Tab2:AddToggle({
	Name = "Boat Fly (Bay Né Terror Shark)",
	Default = false,
	Callback = function(v) _G.BoatFly = v end
})

-- [[ HỆ THỐNG LOGIC SIÊU DÀI ]]
spawn(function()
    while wait() do
        -- Auto Click
        if _G.AutoClick then pcall(function() Click() end) end
        
        -- Logic Auto Farm Level (Skid W-Azure)
        if _G.AutoFarm then
            pcall(function()
                local Player = game.Players.LocalPlayer
                local Character = Player.Character
                local Enemy = game.Workspace.Enemies:FindFirstChildOfClass("Model")
                
                if Enemy and Enemy:FindFirstChild("HumanoidRootPart") then
                    -- Gom quái (Bring Mobs)
                    if _G.BringMob then
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") then
                                v.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame
                                v.HumanoidRootPart.CanCollide = false
                                v.Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn
                            end
                        end
                    end
                    -- Bay tới quái
                    Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                end
            end)
        end

        -- Logic Săn Leviathan & Né Cá Mập
        if _G.AutoLeviathan then
            local Levi = game.Workspace.Enemies:FindFirstChild("Leviathan") or game.Workspace.Enemies:FindFirstChild("Leviathan Segment")
            if Levi then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Levi.CFrame * CFrame.new(0, 30, 0)
                if _G.AutoSkill then
                    game:service'VirtualInputManager':SendKeyEvent(true, "Z", false, game)
                    game:service'VirtualInputManager':SendKeyEvent(true, "X", false, game)
                    game:service'VirtualInputManager':SendKeyEvent(true, "C", false, game)
                    game:service'VirtualInputManager':SendKeyEvent(true, "V", false, game)
                end
            end
        end

        -- Boat Fly né Shark
        if _G.BoatFly then
            local Boat = game.Workspace.Boats:FindFirstChild(game.Players.LocalPlayer.Name .. "Boat")
            if Boat and Boat:FindFirstChild("VehicleSeat") then
                Boat.VehicleSeat.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 150
                -- Nếu thấy Shark thì bay lên trời
                for _,s in pairs(game.Workspace.Enemies:GetChildren()) do
                    if s.Name == "Terror Shark" then
                        Boat.VehicleSeat.Velocity = Vector3.new(0, 100, 0)
                    end
                end
            end
        end
    end
end)

OrionLib:Init()
