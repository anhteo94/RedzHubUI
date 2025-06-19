--// UI LIBRARY
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("PHAMNGHIA HUB | Blox Fruits", "BloodTheme")

--// GLOBAL VARIABLES
_G.AutoFarm = false
_G.AutoBoss = false
_G.AutoHaki = false
_G.AutoStats = {
    Melee = false,
    Defense = false,
    Sword = false,
    Fruit = false,
    Gun = false
}

--// MAIN TAB
local mainTab = Window:NewTab("Main")
local mainSection = mainTab:NewSection("Auto Farm")

-- Auto Farm Level HOÀN CHỈNH
local AutofarmSection = mainTab:NewSection("Auto Farm")

_G.AutoFarm = false
local CurrentMob, QuestName, QuestLevel, MobPos

-- Danh sách level, quái, quest
local MobList = {
    {Level = 10, Name = "Bandit", Quest = "BanditQuest1", QuestId = 1, Pos = CFrame.new(1035, 17, 1530)},
    {Level = 20, Name = "Monkey", Quest = "JungleQuest", QuestId = 1, Pos = CFrame.new(-1598, 37, 145)},
    {Level = 30, Name = "Gorilla", Quest = "JungleQuest", QuestId = 2, Pos = CFrame.new(-1121, 40, -525)},
    -- Thêm quái tùy theo level bạn muốn
}

-- Xác định quái phù hợp theo level
local function GetMobData()
    local playerLevel = game.Players.LocalPlayer.Data.Level.Value
    for i = #MobList, 1, -1 do
        if playerLevel >= MobList[i].Level then
            CurrentMob = MobList[i].Name
            QuestName = MobList[i].Quest
            QuestLevel = MobList[i].QuestId
            MobPos = MobList[i].Pos
            break
        end
    end
end

-- Tìm quái gần nhất
local function GetMob()
    for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v.Name == CurrentMob and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            return v
        end
    end
    return nil
end

-- Tự đánh quái
local function AttackMob(mob)
    repeat wait()
        pcall(function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
            mob.Humanoid.Health = 0  -- giả lập kill nhanh
        end)
    until mob.Humanoid.Health <= 0 or not _G.AutoFarm
end

-- Bật Auto Farm
AutofarmSection:NewToggle("Auto Farm Level", "Farm theo cấp", 
-- AUTO FARM BOSS HOÀN CHỈNH
_G.AutoBoss = false

local function GetNearestBoss()
    local closest, shortest = nil, math.huge
    for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            -- Lọc boss theo tên hoặc máu lớn
            if string.find(v.Name, "Boss") or v.Humanoid.MaxHealth >= 10000 then
                local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = v
                end
            end
        end
    end
    return closest
end
mainSection:NewToggle("Auto Farm Boss", "Farm boss gần nhất", function(v)
    _G.AutoBoss = v
    while _G.AutoBoss do
        task.wait()
        pcall(function()
            local boss = GetNearestBoss()
            if boss and boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") then

                -- Dịch chuyển tới boss
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                    boss.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)

                -- Tìm vũ khí trong balo và trang bị
                local tool = game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if tool then
                    tool.Parent = game.Players.LocalPlayer.Character
                end

                -- Đánh boss liên tục
                repeat task.wait()
                    if tool and tool.Parent == game.Players.LocalPlayer.Character then
                        pcall(function()
                            tool:Activate()
                        end)
                    end
                until boss.Humanoid.Health <= 0 or not _G.AutoBoss

            end
        end)
    end
end)
    _G.AutoBoss = v
    while _G.AutoBoss do task.wait()
        pcall(function()
            local boss = GetNearestBoss()
            if boss then
                repeat task.wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                    boss.Humanoid.Health = 0 -- giả lập kill
                until boss.Humanoid.Health <= 0 or not _G.AutoBoss
            end
        end)
    end
end)
function(v)
    _G.AutoFarm = v

    while _G.AutoFarm do wait()
        pcall(function()
            GetMobData()
            
            -- Kiểm tra nếu chưa nhận nhiệm vụ
            if not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("QuestTitle") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestName, QuestLevel)
                wait(1)
            end

            local mob = GetMob()
            if mob then
                AttackMob(mob)
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = MobPos
            end
        end)
    end
end)

mainSection:NewToggle("Auto Farm Boss", "Farm boss gần nhất", function(v)
    _G.AutoBoss = v
    while _G.AutoBoss do task.wait()
        -- Thêm xử lý farm boss tại đây nếu cần
    end
end)

mainSection:NewToggle("Auto Haki", "Bật haki liên tục", function(v)
    _G.AutoHaki = v
    while _G.AutoHaki do wait()
        pcall(function()
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end)
    end
end)

mainSection:NewToggle("Auto Click", "Tự động đánh", function(v)
    _G.AutoClick = v
    while _G.AutoClick do wait()
        pcall(function()
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,true,game,0)
        end)
    end
end)

--// STATS TAB
local statTab = Window:NewTab("Stats")
local statSection = statTab:NewSection("Tăng chỉ số")

for stat, _ in pairs(_G.AutoStats) do
    statSection:NewToggle("Auto "..stat, "Tăng điểm "..stat, function(v)
        _G.AutoStats[stat] = v
        while _G.AutoStats[stat] do wait()
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", stat, 1)
            end)
        end
    end)
end

--// TELEPORT TAB
local tpTab = Window:NewTab("Teleport")
local tpSection = tpTab:NewSection("Đến địa điểm")

local locations = {
    ["Jungle"] = CFrame.new(-1337, 11, 497),
    ["Marine"] = CFrame.new(-260, 7, 4923),
    ["Desert"] = CFrame.new(927, 7, 4484)
}

for name, cf in pairs(locations) do
    tpSection:NewButton("Đến " .. name, "Dịch chuyển tới " .. name, function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
    end)
end

--// SHOP TAB
local shopTab = Window:NewTab("Shop")
local shopSection = shopTab:NewSection("Mua đồ")

shopSection:NewButton("Mua Random Fruit", "Mua trái ngẫu nhiên", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyRandomDevilFruit", true)
end)

shopSection:NewButton("Mua Katana", "Mua kiếm Katana", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Katana")
end)

--// ESP TAB
local espTab = Window:NewTab("ESP")
local espSection = espTab:NewSection("Phát hiện")

espSection:NewToggle("ESP Người chơi", "Hiện khung quanh người chơi", function(v)
    _G.PlayerESP = v
    while _G.PlayerESP do wait()
        for _,v in pairs(game.Players:GetChildren()) do
            if v ~= game.Players.LocalPlayer and v.Character and not v.Character:FindFirstChild("ESPBox") then
                local esp = Instance.new("BoxHandleAdornment", v.Character)
                esp.Name = "ESPBox"
                esp.Adornee = v.Character:FindFirstChild("HumanoidRootPart")
                esp.AlwaysOnTop = true
                esp.Size = Vector3.new(4,6,1)
                esp.ZIndex = 5
                esp.Color3 = Color3.new(1,0,0)
            end
        end
    end
end)

--// FRUIT TAB
local fruitTab = Window:NewTab("Fruit")
local fruitSection = fruitTab:NewSection("Trái ác quỷ")

fruitSection:NewButton("Tìm trái rơi", "Dịch chuyển đến trái gần nhất", function()
    for _,v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Handle") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
        end
    end
end)

--// RAID TAB
local raidTab = Window:NewTab("Raid")
local raidSection = raidTab:NewSection("Hỗ trợ raid")

raidSection:NewButton("Auto Join Raid", "Tự vào raid", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Raids", "JoinRaid")
end)

--// MISC TAB
local miscTab = Window:NewTab("Misc")
local miscSection = miscTab:NewSection("Tiện ích")

miscSection:NewToggle("Anti AFK", "Chống kick văng khi AFK", function(v)
    if v then
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end
end)

miscSection:NewButton("Speed Hack", "Tăng tốc độ chạy", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 120
end)

--// SERVER TAB
local serverTab = Window:NewTab("Server")
local serverSection = serverTab:NewSection("Server Tools")

serverSection:NewButton("Rejoin", "Vào lại server hiện tại", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)

serverSection:NewButton("Hop Server", "Tìm server mới", function()
    local ts = game:GetService("TeleportService")
    ts:Teleport(game.PlaceId)
end)

--// CREDITS
local creditTab = Window:NewTab("Credits")
local creditSection = creditTab:NewSection("Thông tin")

creditSection:NewLabel("Script by PhamNghia")
creditSection:NewLabel("UI by ChatGPT x Kavo UI")
