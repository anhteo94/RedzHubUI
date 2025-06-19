-- Phạm Nghĩa GUI - Phong cách Zis Roblox
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Tạo ScreenGui
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "PhạmNghĩa_ZisGUI"

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 350)
main.Position = UDim2.new(0.5, -300, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0

-- Sidebar (Tab trái)
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local tabs = {"Tab Welcome", "Auto Boss", "Auto Legendary Sword", "Auto Race V4"}
for i, name in pairs(tabs) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, (i - 1) * 42)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
end

-- Nội dung phải
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -160, 1, -10)
content.Position = UDim2.new(0, 160, 0, 10)
content.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local buttons = {
    "Auto Hop Mirage",
    "Remove Fog",
    "ESP Mirage",
    "Teleport Mirage Island",
    "Teleport Advanced Fruit Dealer",
    "Auto Lock Moon",
    "Tween Gear"
}

for i, name in pairs(buttons) do
    local btn = Instance.new("TextButton", content)
    btn.Size = UDim2.new(0, 250, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, (i - 1) * 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)

    btn.MouseButton1Click:Connect(function()
    game.Lighting.FogEnd = 100000
    game.Lighting.FogStart = 100000
end)
