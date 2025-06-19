-- PhamNghia Hub – Full Edition
if not game:IsLoaded() then repeat task.wait() until game:IsLoaded() end

local Library = loadstring(game:HttpGet(
  "https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"
))()
local Window = Library.CreateLib("PhamNghia Hub", "BloodTheme")

-- 🔧 Main Tab
local main = Window:NewTab("Main")
local msec = main:NewSection("Main")
msec:NewButton("Rejoin", "Reconnect server", function()
  game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
end)

-- 🔄 Automatics
local auto = Window:NewTab("Automatics")
local asec = auto:NewSection("Auto Features")
getgenv().AutoRaid, getgenv().KillAura, getgenv().AutoAwaken = false,false,false

asec:NewToggle("Auto Raid", "Auto Vai Island raid", function(v)
  getgenv().AutoRaid = v
  spawn(function()
    while getgenv().AutoRaid do task.wait(1)
      local portal = workspace:FindFirstChild("RaidPortal") or workspace:FindFirstChild("DimensionalTeleport")
      if portal then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = portal.CFrame + Vector3.new(0,5,0)
      end
    end
  end)
end)

asec:NewToggle("Kill Aura", "Auto attack mob in radius", function(v)
  getgenv().KillAura = v
  spawn(function()
    while getgenv().KillAura do task.wait(0.1)
      for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0,10,0)
        end
      end
    end
  end)
end)

asec:NewToggle("Auto Awakening", "Auto awaken skill every 1 min", function(v)
  getgenv().AutoAwaken = v
  spawn(function()
    while getgenv().AutoAwaken do
      task.wait(60)
      pcall(function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awake")
      end)
    end
  end)
end)

-- 👥 Players Tab
local players = Window:NewTab("Players")
local psec = players:NewSection("Player Options")
psec:NewTextBox("Set WalkSpeed", "Speed value", function(val)
  game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(val) or 16
end)
psec:NewTextBox("Set JumpPower", "Jump value", function(val)
  game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(val) or 50
end)

-- 🌍 Travel Tab
local travel = Window:NewTab("Travel")
local tsec = travel:NewSection("Teleports")
local teleports = {
  ["Spawn Island"] = CFrame.new(0,10,0),
  ["Second Island"] = CFrame.new(500,20,500),
}
for name,cframe in pairs(teleports) do
  tsec:NewButton(name, "", function()
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    hrp.CFrame = cframe
  end)
end

-- 👑 Raid Tab (settings if needed)
local raid = Window:NewTab("Raid")
local rsec = raid:NewSection("Raid Settings")
rsec:NewDropdown("Raid Island", "Select island", {"Ice","Waterfall","Hot"}, function(opt)
  getgenv().RaidIsland = opt
end)

-- 🛍️ Shops Tab
local shops = Window:NewTab("Shops")
local ssec = shops:NewSection("Shop Utils")
ssec:NewButton("Open Devils Fruit Shop", "Teleport to shop", function()
  local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
  hrp.CFrame = CFrame.new(1000,10,1000)
end)

-- 🔧 Misc Tab
local misc = Window:NewTab("Misc")
local miscsec = misc:NewSection("Miscellaneous")
miscsec:NewToggle("Auto Fruit", "Auto collect fruit items", function(v)
  getgenv().AutoFruit = v
  spawn(function()
    while getgenv().AutoFruit do task.wait(1)
      for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj.Name:lower():find("fruit") then
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.Handle.CFrame + Vector3.new(0,2,0)
        end
      end
    end
  end)
end)

miscsec:NewToggle("ESP Players", "Show player names", function(v)
  for _,plr in pairs(game.Players:GetPlayers()) do
    if v and plr~=game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
      if not plr.Character.Head:FindFirstChild("ESP") then
        local bill = Instance.new("BillboardGui",plr.Character.Head)
        bill.Name="ESP"; bill.Size=UDim2.new(0,100,0,30); bill.AlwaysOnTop=true
        local txt = Instance.new("TextLabel",bill)
        txt.Text=plr.Name; txt.Size=UDim2.new(1,0,1,0); txt.BackgroundTransparency=1; txt.TextColor3=Color3.new(1,1,1)
      end
    elseif plr.Character and plr.Character:FindFirstChild("Head") and plr.Character.Head:FindFirstChild("ESP") then
      plr.Character.Head.ESP:Destroy()
    end
  end
end)

-- ⚙️ Settings Tab
local sett = Window:NewTab("Settings")
local s2 = sett:NewSection("UI")
s2:NewKeybind("Toggle GUI", "Show/hide menu", Enum.KeyCode.RightControl, function()
  Library:ToggleUI()
end)
