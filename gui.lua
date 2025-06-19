-- Phạm Nghĩa Hub – GUI Blox Fruits giống Banana Cat Hub
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Clean old GUI
pcall(function() game.CoreGui["PhamNghiaHub"]:Destroy() end)

-- Main ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "PhamNghiaHub"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 540, 0, 360)
main.Position = UDim2.new(0.5, -270, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- Left sidebar
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local tabNames = {
    "Farming", "Stack Farm", "Farming Other",
    "Fruit & Raid", "Sea Event", "Upgrade Race",
    "Get/Upgrade Items", "Volcano Event",
    "ESP", "Local Player", "Status & Server", "Settings"
}
local buttons = {}

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -150, 1, 0)
content.Position = UDim2.new(0,150,0,0)
content.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

-- Create tabs
local pages = {}
for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Position = UDim2.new(0,0,0,(i-1)*34 + 10)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Name = name.."Btn"
    buttons[name] = btn

    local page = Instance.new("Frame", content)
    page.Size = UDim2.new(1,0,1,0)
    page.Position = UDim2.new(0,0,0,0)
    page.BackgroundTransparency = 1
    page.Visible = false
    pages[name] = page

    btn.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible = false end
        for _,b in pairs(buttons) do b.BackgroundColor3 = Color3.fromRGB(45,45,45) end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
    end)
end
-- Default tab
pages["Farming"].Visible = true
buttons["Farming"].BackgroundColor3 = Color3.fromRGB(70,70,70)

-- Add sample toggle to tab Farming: Auto Farm
do
    local page = pages["Farming"]
    local tgl = Instance.new("TextButton", page)
    tgl.Text = "Auto Farm: OFF"
    tgl.Size = UDim2.new(0,200,0,40)
    tgl.Position = UDim2.new(0.1,0,0.1,0)
    tgl.BackgroundColor3 = Color3.fromRGB(60,60,60)
    local farming = false
    local conn
    local function Start()
        farming = true; tgl.Text="Auto Farm: ON"
        conn = game:GetService("RunService").Stepped:Connect(function()
            -- Example auto-click/walk simulate
            game:GetService("ReplicatedStorage").Remotes.Farming:FireServer()
        end)
    end
    local function Stop()
        farming = false; tgl.Text="Auto Farm: OFF"
        if conn then conn:Disconnect() end
    end
    tgl.MouseButton1Click:Connect(function()
        if farming then Stop() else Start() end
    end)
end

-- (Bạn có thể thêm nhiều toggle tương tự cho từng tab)

-- Done
print("[PhamNghia Hub] GUI Loaded!")
