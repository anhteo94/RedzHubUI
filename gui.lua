-- Phạm Nghĩa IOS GUI by [your_name_here]
-- GUI Style Redz Hub (Left-Right Split)

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "PhamNghiaIOS_GUI"
ScreenGui.ResetOnSpawn = false

-- Main Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "MainFrame"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 800, 0, 500)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0

-- Left sidebar (tabs)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Name = "Sidebar"
Sidebar.Position = UDim2.new(0, 0, 0, 0)
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Sidebar.BorderSizePixel = 0

-- Tab buttons list
local tabs = {
    "Discord", "Farm", "Biển", "Đảo",
    "Nhiệm Vụ/Vật Phẩm", "Trái/Đột Kích",
    "Stats", "Dịch Chuyển", "Status",
    "Giao Diện", "Cửa Hàng", "Khác"
}

local buttons = {}

for idx, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton", Sidebar)
    btn.Name = tabName .. "Btn"
    btn.Text = tabName
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = UDim2.new(0, 0, 0, (idx - 1) * 37)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 0
    buttons[tabName] = btn
end

-- Right content area
local Content = Instance.new("Frame", Main)
Content.Name = "ContentFrame"
Content.Position = UDim2.new(0, 150, 0, 0)
Content.Size = UDim2.new(1, -150, 1, 0)
Content.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Content.BorderSizePixel = 0

-- Create each tab content
local pages = {}
for _, tabName in ipairs(tabs) do
    local page = Instance.new("Frame", Content)
    page.Name = tabName .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    page.Visible = false

    local lbl = Instance.new("TextLabel", page)
    lbl.Name = tabName .. "Label"
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "Tab: " .. tabName
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 18
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)

    pages[tabName] = page
end

-- Activate first tab
pages["Discord"].Visible = true
buttons["Discord"].BackgroundColor3 = Color3.fromRGB(60, 60, 60)

-- Tab switching logic
for tabName, btn in pairs(buttons) do
    btn.MouseButton1Click:Connect(function()
        -- Reset all
        for _, p in pairs(pages) do p.Visible = false end
        for _, b in pairs(buttons) do b.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end

        -- Activate selected
        pages[tabName].Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
end

-- ========== EXAMPLE CONTENT ========== --

-- 1. Discord Tab
do
    local page = pages["Discord"]
    local btnJoin = Instance.new("TextButton", page)
    btnJoin.Name = "JoinDiscord"
    btnJoin.Text = "Join Discord"
    btnJoin.Size = UDim2.new(0, 150, 0, 40)
    btnJoin.Position = UDim2.new(0.5, -75, 0.5, 0)
    btnJoin.Font = Enum.Font.Gotham
    btnJoin.TextSize = 16
    btnJoin.BackgroundColor3 = Color3.fromRGB(80, 50, 200)
    btnJoin.BorderSizePixel = 0
    btnJoin.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/YourServerLink")
        btnJoin.Text = "Copied Link!"
        wait(1)
        btnJoin.Text = "Join Discord"
    end)
end

-- 2. Farm Tab
do
    local page = pages["Farm"]
    local toggleFarm = Instance.new("TextButton", page)
    toggleFarm.Name = "ToggleFarm"
    toggleFarm.Text = "Auto Farm: OFF"
    toggleFarm.Size = UDim2.new(0, 150, 0, 40)
    toggleFarm.Position = UDim2.new(0.1, 0, 0.1, 0)
    toggleFarm.Font = Enum.Font.Gotham
    toggleFarm.TextSize = 16
    toggleFarm.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    toggleFarm.BorderSizePixel = 0
    local farming = false
    local farmConn

    local function startFarm()
        farming = true
        toggleFarm.Text = "Auto Farm: ON"
        --: Replace with actual farming logic:
        farmConn = game:GetService("RunService").Stepped:Connect(function()
            -- Example: Simulate touch or server invoke
        end)
    end

    local function stopFarm()
        farming = false
        toggleFarm.Text = "Auto Farm: OFF"
        if farmConn then farmConn:Disconnect() end
    end

    toggleFarm.MouseButton1Click:Connect(function()
        if farming then stopFarm() else startFarm() end
    end)
end

-- TODO: Bạn tự triển khai các chức năng cards nội dung trong các tab còn lại
-- Trang Biển, Đảo, Nhiệm Vụ/Vật Phẩm, Trái/Đột Kích, Stats, Dịch Chuyển, Status, Giao Diện, Cửa Hàng, Khác
-- Mỗi tab nên thêm các Toggle, Slider, Dropdown theo kiểu mẫu trên

-- Giao diện theo style Dark + Rounded góc nhẹ
local UICorner = function(inst, radius)
    local corner = Instance.new("UICorner", inst)
    corner.CornerRadius = UDim.new(0, radius or 8)
end
for _, inst in ipairs(ScreenGui:GetDescendants()) do
    if inst:IsA("Frame") or inst:IsA("TextButton") or inst:IsA("TextLabel") then
        UICorner(inst, 6)
    end
end

-- Tự động di chuyển GUI khi cần
local Drag = Instance.new("Frame", Main)
Drag.Name = "DragArea"
Drag.Size = UDim2.new(1, 0, 0, 30)
Drag.BackgroundTransparency = 1

local dragging, dragInput, dragStart, startPos
Drag.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
Drag.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

print("[Pham Nghia IOS GUI] Loaded successfully")
