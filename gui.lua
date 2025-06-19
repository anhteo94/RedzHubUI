-- Banana Hub Style GUI Full Script (Blox Fruits)
if not game:IsLoaded() then repeat task.wait() until game:IsLoaded() end

local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Module-UI/main/source.lua"))()
local Window = KavoUI.CreateLib("RedzHub - Full Edition", "BloodTheme")

-- Auto Farm Tab
local farmTab = Window:NewTab("Auto Farm")
local farmSec = farmTab:NewSection("Farming")
getgenv().AutoFarm = false
farmSec:NewToggle("Auto Farm Mobs", "Đánh quái liên tục", function(state)
    getgenv().AutoFarm = state
    while getgenv().AutoFarm do
        task.wait()
        pcall(function()
            -- Example farm mob logic
            local mob = game.Workspace.Enemies:FindFirstChildWhichIsA("Model")
            if mob and mob:FindFirstChild("HumanoidRootPart") then
                local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                hrp.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)
            end
        end)
    end
end)

-- Boss Tab
local bossTab = Window:NewTab("Boss")
local bossSec = bossTab:NewSection("Auto Boss")
getgenv().AutoBoss = false
bossSec:NewToggle("Auto Farm Boss", "Đánh boss gần nhất", function(state)
    getgenv().AutoBoss = state
    while getgenv().AutoBoss do
        task.wait()
        pcall(function()
            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                if string.find(v.Name:lower(), "boss") and v:FindFirstChild("HumanoidRootPart") then
                    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                    hrp.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0,10,0)
                end
            end
        end)
    end
end)

-- Fruit Tab
local fruitTab = Window:NewTab("Fruit")
local fruitSec = fruitTab:NewSection("Auto Fruit")
getgenv().AutoFruit = false
fruitSec:NewToggle("Auto Collect Fruit", "Nhặt trái cây tự động", function(state)
    getgenv().AutoFruit = state
    while getgenv().AutoFruit do
        task.wait()
        pcall(function()
            for i,v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("Tool") and string.find(v.Name:lower(), "fruit") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame + Vector3.new(0,2,0)
                end
            end
        end)
    end
end)

-- Raid Tab
local raidTab = Window:NewTab("Raid")
local raidSec = raidTab:NewSection("Auto Raid")
getgenv().AutoRaid = false
raidSec:NewToggle("Auto Raid", "Tự dịch chuyển tới Raid Portal", function(state)
    getgenv().AutoRaid = state
    while getgenv().AutoRaid do
        task.wait()
        pcall(function()
            local portal = workspace:FindFirstChild("RaidPortal") or workspace:FindFirstChild("DimensionalTeleport")
            if portal then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = portal.CFrame + Vector3.new(0, 5, 0)
            end
        end)
    end
end)

-- ESP Tab
local espTab = Window:NewTab("ESP")
local espSec = espTab:NewSection("ESP Features")
espSec:NewButton("Enable Player ESP", "Hiện tên người chơi", function()
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Head") and not v.Character.Head:FindFirstChild("NameTag") then
            local Billboard = Instance.new("BillboardGui", v.Character.Head)
            Billboard.Name = "NameTag"
            Billboard.Size = UDim2.new(0, 100, 0, 40)
            Billboard.StudsOffset = Vector3.new(0, 2, 0)
            Billboard.AlwaysOnTop = true
            local Text = Instance.new("TextLabel", Billboard)
            Text.Size = UDim2.new(1, 0, 1, 0)
            Text.Text = v.Name
            Text.TextColor3 = Color3.fromRGB(255, 255, 255)
            Text.BackgroundTransparency = 1
        end
    end
end)

-- Teleport Tab
local tpTab = Window:NewTab("Teleport")
local tpSec = tpTab:NewSection("Location TP")
tpSec:NewButton("Teleport to Start Island", "Dịch chuyển về đảo chính", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
end)

-- UI Tab
local uiTab = Window:NewTab("UI Settings")
local uiSec = uiTab:NewSection("Menu")
uiSec:NewKeybind("Toggle GUI", "Ẩn/Hiện giao diện", Enum.KeyCode.RightControl, function()
    KavoUI:ToggleUI()
end)
