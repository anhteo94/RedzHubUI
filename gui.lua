-- gui.lua – RedzHubUI
-- Phạm Nghĩa IOS – GUI Style Redz Hub with sample features

-- Load GUI
loadstring([[
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Prepare UI
local function MakeGUI()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    if PlayerGui:FindFirstChild("PhamNghiaIOS_GUI") then
        PlayerGui.PhamNghiaIOS_GUI:Destroy()
    end
    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Name = "PhamNghiaIOS_GUI"
    ScreenGui.ResetOnSpawn = false
    -- Main frame
    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "MainFrame"
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Position = UDim2.new(0.5,0,0.5,0)
    Main.Size = UDim2.new(0,800,0,500)
    Main.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Main.BorderSizePixel = 0
    -- Sidebar
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0,150,1,0)
    Sidebar.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Sidebar.BorderSizePixel = 0
    -- Tabs
    local tabs = {"Discord","Farm","Biển","Đảo","Nhiệm Vụ","Trái/Đột Kích","Stats","Dịch Chuyển","Giao Diện","Khác"}
    local buttons, pages = {}, {}
    for i,name in ipairs(tabs) do
        local btn = Instance.new("TextButton", Sidebar)
        btn.Name = name.."Btn"; btn.Text = name
        btn.Font = Enum.Font.Gotham; btn.TextSize = 14
        btn.Size = UDim2.new(1,0,0,35)
        btn.Position = UDim2.new(0,0,0,(i-1)*37)
        btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        btn.BorderSizePixel = 0
        buttons[name] = btn
        local page = Instance.new("Frame", Main)
        page.Name = name.."Page"
        page.Position = UDim2.new(0,150,0,0)
        page.Size = UDim2.new(1,-150,1,0)
        page.BackgroundColor3 = Color3.fromRGB(25,25,25)
        page.Visible = false
        pages[name] = page
    end
    pages["Discord"].Visible, buttons["Discord"].BackgroundColor3 = true, Color3.fromRGB(60,60,60)
    for name,btn in pairs(buttons) do
        btn.MouseButton1Click:Connect(function()
            for _,p in pairs(pages) do p.Visible=false end
            for _,b in pairs(buttons) do b.BackgroundColor3=Color3.fromRGB(40,40,40) end
            pages[name].Visible=true; btn.BackgroundColor3=Color3.fromRGB(60,60,60)
        end)
    end

    -- Tab Discord
    do
        local p = pages["Discord"]
        local t=Instance.new("TextLabel",p)
        t.Text="Discord: [Link here]";t.Size=UDim2.new(1,0,0,30);t.Position=UDim2.new(0,0,0,10)
        t.TextColor3,t.Font,t.TextSize=Color3.new(1,1,1),Enum.Font.Gotham,16
        t.BackgroundTransparency=1
        local b=Instance.new("TextButton",p)
        b.Text="Copy Link";b.Size, b.Position = UDim2.new(0,150,0,40), UDim2.new(0.5,-75,0,50)
        b.Font, b.TextSize, b.BackgroundColor3 = Enum.Font.Gotham,16,Color3.fromRGB(80,50,200)
        b.MouseButton1Click:Connect(function()
            setclipboard("https://discord.gg/YourServer")
            b.Text="Copied!"; wait(1); b.Text="Copy Link"
        end)
    end

    -- Tab Farm with toggle
    do
        local p=pages["Farm"]
        local tgl=Instance.new("TextButton",p)
        tgl.Text="Auto Farm: OFF";tgl.Size=UDim2.new(0,150,0,40)
        tgl.Position=UDim2.new(0.1,0,0.1,0);tgl.Font=Enum.Font.Gotham;tgl.BackgroundColor3=Color3.fromRGB(80,80,80)
        local farming,conn=false,nil
        tgl.MouseButton1Click:Connect(function()
            if not farming then
                farming=true; tgl.Text="Auto Farm: ON"
                conn = RunService.Stepped:Connect(function()
                    -- example farm logic
                    -- game:GetService("ReplicatedStorage").Remotes.Farm:FireServer()
                end)
            else
                farming=false; tgl.Text="Auto Farm: OFF"
                if conn then conn:Disconnect(); conn=nil end
            end
        end)
    end

    -- Tab Biển
    do local p=pages["Biển"]
        local lbl=Instance.new("TextLabel",p)
        lbl.Text="Auto Taunt Biển (sample)";lbl.Size=UDim2.new(1,0,0,30);lbl.Position=UDim2.new(0,0,0.1,0)
        lbl.TextColor3=Color3.fromRGB(255,255,255);lbl.Font, lbl.TextSize, lbl.BackgroundTransparency=Enum.Font.Gotham,16,true
        local btn=Instance.new("TextButton",p)
        btn.Text="Taunt Now";btn.Size=UDim2.new(0,150,0,40);btn.Position=UDim2.new(0.5,-75,0.2,0)
        btn.MouseButton1Click:Connect(function()
            -- sample function
            -- game:GetService("ReplicatedStorage").Remotes.BienTaunt:FireServer()
        end)
    end

    -- Tab Đảo
    do local p=pages["Đảo"]
        local btn=Instance.new("TextButton",p)
        btn.Text="Teleport to Default Island";btn.Size=UDim2.new(0,200,0,40)
        btn.Position=UDim2.new(0.5,-100,0.2,0)
        btn.MouseButton1Click:Connect(function()
            LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(0,50,0))
        end)
    end

    -- Tab Stats
    do local p=pages["Stats"]
        for i, stat in ipairs({"Health","WalkSpeed","JumpPower"}) do
            local btn=Instance.new("TextButton",p)
            btn.Text = stat
            btn.Size, btn.Position = UDim2.new(0,120,0,30), UDim2.new(0.1,0,0.1*i,0)
            btn.MouseButton1Click:Connect(function()
                if stat=="Health" then LocalPlayer.Character.Humanoid.MaxHealth=math.huge
                elseif stat=="WalkSpeed" then LocalPlayer.Character.Humanoid.WalkSpeed=100
                elseif stat=="JumpPower" then LocalPlayer.Character.Humanoid.JumpPower=100 end
            end)
        end
    end

    -- Tab Dịch Chuyển
    do local p=pages["Dịch Chuyển"]
        for i,info in ipairs({{"Spawn",0,5,0},{"SeaBeast",-100,10,-50}}) do
            local btn=Instance.new("TextButton",p)
            btn.Text="Tp to "..info[1]
            btn.Size, btn.Position = UDim2.new(0,150,0,40), UDim2.new(0.1,0,0.2*i,0)
            btn.MouseButton1Click:Connect(function()
                LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(info[2],info[3],info[4]))
            end)
        end
    end

    -- Tab Giao Diện
    do local p=pages["Giao Diện"]
        local btn=Instance.new("TextButton",p)
        btn.Text="Toggle Dark Mode"
        btn.Size=UDim2.new(0,150,0,40);btn.Position=UDim2.new(0.1,0,0.1,0)
        local dark=true
        btn.MouseButton1Click:Connect(function()
            dark = not dark
            Main.BackgroundColor3 = dark and Color3.fromRGB(30,30,30) or Color3.fromRGB(220,220,220)
        end)
    end

    -- Tab Khác
    do local p=pages["Khác"]
        local lbl=Instance.new("TextLabel",p)
        lbl.Text="Các chức năng khác sắp cập nhật";lbl.Size=UDim2.new(1,0,0,30)
        lbl.Position=UDim2.new(0,0,0.1,0)
        lbl.TextColor3=Color3.fromRGB(200,200,200);lbl.BackgroundTransparency=1
    end

    -- Rounded corners
    for _,v in ipairs(ScreenGui:GetDescendants()) do
        if v:IsA("Frame") or v:IsA("TextButton") or v:IsA("TextLabel") then
            local c=Instance.new("UICorner",v); c.CornerRadius=UDim.new(0,6)
        end
    end

    -- Dragging
    local Drag=Instance.new("Frame",Main)
    Drag.Size=UDim2.new(1,0,0,30);Drag.BackgroundTransparency=1
    local drag, startPos, startInput
    Drag.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then
            drag=true; startInput=i.Position; startPos=Main.Position
            i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then drag=false end end)
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(i)
        if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
            local dt=i.Position - startInput
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + dt.X,
                                     startPos.Y.Scale, startPos.Y.Offset + dt.Y)
        end
    end)
    print("[Pham Nghia IOS GUI] Enhanced loaded")
end

MakeGUI()
]])()
