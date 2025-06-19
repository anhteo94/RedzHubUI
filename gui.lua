-- Phạm Nghĩa GUI – Zis Roblox Style (Hoạt động thật)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "PhạmNghĩa_ZisGUI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 350)
main.Position = UDim2.new(0.5, -300, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0

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

    if name == "Auto Hop Mirage" then
        btn.MouseButton1Click:Connect(function()
            while task.wait(3) do
                game:GetService("TeleportService"):Teleport(game.PlaceId)
            end
        end)
    elseif name == "Remove Fog" then
        btn.MouseButton1Click:Connect(function()
            game.Lighting.FogEnd = 100000
            game.Lighting.FogStart = 100000
        end)
    elseif name == "ESP Mirage" then
        btn.MouseButton1Click:Connect(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("MeshPart") and v.Name == "Mirage Island" then
                    local esp = Instance.new("BillboardGui", v)
                    esp.Size = UDim2.new(0, 100, 0, 40)
                    esp.AlwaysOnTop = true
                    esp.Adornee = v

                    local label = Instance.new("TextLabel", esp)
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = "🌙 Mirage Island"
                    label.TextColor3 = Color3.fromRGB(0, 255, 255)
                    label.TextScaled = true
                end
            end
        end)
    elseif name == "Teleport Mirage Island" then
        btn.MouseButton1Click:Connect(function()
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5000, 150, -4500)
        end)
    elseif name == "Teleport Advanced Fruit Dealer" then
        btn.MouseButton1Click:Connect(function()
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "Advanced Fruit Dealer" then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                end
            end
        end)
    elseif name == "Auto Lock Moon" then
        btn.MouseButton1Click:Connect(function()
            game.Lighting.ClockTime = 0
        end)
    elseif name == "Tween Gear" then
        btn.MouseButton1Click:Connect(function()
            local TweenService = game:GetService("TweenService")
            local part = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if part then
                local goal = {}
                goal.CFrame = part.CFrame * CFrame.new(0, 0, -100)
                local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear)
                TweenService:Create(part, tweenInfo, goal):Play()
            end
        end)
    end
end
