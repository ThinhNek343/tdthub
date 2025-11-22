-- Maintenance UI v6 - Clear & Bright
-- Tập trung độ rõ chữ + tương phản, dọn blur cũ, bố cục chuẩn
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- ===== CONFIG =====
local CONFIG = {
    DiscordInvite = "https://discord.gg/tdtfreenokey",
    TimeLeft = 120, -- giây
    VN = "Hiện Đang Sửa Chữa Script, Vui Lòng Chờ Đợi!",
    EN = "Script Repairing Now, Please Wait!.",
    Error = { Code = "Blox Fruit", Message = "Chúng Tôi Sẽ Khắc Phục Lỗi Trên Script||  ", Details = "  || We Will Fix The Error On The Script" }
}

-- ===== CLEANUP: gỡ blur cũ nếu tồn tại =====
for _, eff in ipairs(Lighting:GetChildren()) do
    if eff:IsA("BlurEffect") and eff.Name == "MaintenanceBlur" then eff:Destroy() end
end

-- ===== ROOT GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "MaintenanceUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = player:WaitForChild("PlayerGui")

-- Nền nhẹ & blur vừa phải (không chồng)
local blur = Instance.new("BlurEffect")
blur.Name = "MaintenanceBlur"
blur.Size = 12 -- giảm để không làm chữ trôi
blur.Parent = Lighting

-- NỀN TRONG SUỐT (NO BACKDROP)
local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1,1)
bg.BackgroundTransparency = 1     -- không phủ màu
bg.BorderSizePixel = 0
bg.Parent = gui

-- (không tạo UIGradient cho bg)

local g = Instance.new("UIGradient", bg)
g.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 155, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 70, 255))
}
g.Rotation = 35
task.spawn(function()
    while task.wait(0.06) do g.Rotation = (g.Rotation + 0.4) % 360 end
end)

-- ===== CARD =====
local card = Instance.new("Frame")
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.Position = UDim2.fromScale(0.5, 0.5)
card.Size = UDim2.fromScale(0.74, 0.56)
card.BackgroundColor3 = Color3.fromRGB(18, 20, 30) -- nền sẫm sạch
card.BackgroundTransparency = 0.05
card.BorderSizePixel = 0
card.ZIndex = 2
card.Parent = bg

Instance.new("UICorner", card).CornerRadius = UDim.new(0, 18)
local cardStroke = Instance.new("UIStroke", card)
cardStroke.Color = Color3.fromRGB(255,255,255)
cardStroke.Transparency = 0.4
cardStroke.Thickness = 1.2

-- BỐ CỤC: tránh chồng lớp
local layout = Instance.new("UIListLayout", card)
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment   = Enum.VerticalAlignment.Top
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 10)

-- ===== HEADER =====
local header = Instance.new("Frame")
header.BackgroundTransparency = 1
header.Size = UDim2.fromScale(1, 0.22)
header.LayoutOrder = 1
header.ZIndex = 3
header.Parent = card

local title = Instance.new("TextLabel")
 title.Text = "🚧 Update Script Main TDT 🚧"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.BackgroundTransparency = 1
title.Size = UDim2.fromScale(0.96, 1)
title.Position = UDim2.fromScale(0.02, 0)
title.ZIndex = 4
-- 🔥 CHỮ SÁNG & RÕ
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextTransparency = 0 -- không làm mờ
title.TextStrokeTransparency = 0.6  -- viền chữ nhẹ để nổi bật
title.TextStrokeColor3 = Color3.fromRGB(20, 20, 28)
title.Parent = header

-- gradient ánh sáng nhưng KHÔNG làm tối chữ
local titleGrad = Instance.new("UIGradient", title)
titleGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 190, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 120, 255))
}
titleGrad.Rotation = 0
task.spawn(function()
    while task.wait(0.05) do titleGrad.Rotation = (titleGrad.Rotation + 1) % 360 end
end)

-- ===== BODY (VN + EN) =====
local body = Instance.new("Frame")
body.BackgroundTransparency = 1
body.Size = UDim2.fromScale(1, 0.42)
body.LayoutOrder = 2
body.ZIndex = 3
body.Parent = card

local bodyV = Instance.new("UIListLayout", body)
bodyV.FillDirection = Enum.FillDirection.Vertical
bodyV.HorizontalAlignment = Enum.HorizontalAlignment.Center
bodyV.VerticalAlignment = Enum.VerticalAlignment.Top
bodyV.Padding = UDim.new(0, 6)

local vn = Instance.new("TextLabel")
vn.Text = CONFIG.VN
vn.Font = Enum.Font.GothamSemibold
vn.TextScaled = true
vn.TextWrapped = true
vn.Size = UDim2.fromScale(0.94, 0.48)
vn.BackgroundTransparency = 1
-- 🌟 CHỮ SÁNG
vn.TextColor3 = Color3.fromRGB(244, 248, 255)
vn.TextTransparency = 0
vn.TextStrokeTransparency = 0.72
vn.TextStrokeColor3 = Color3.fromRGB(16, 16, 24)
vn.ZIndex = 4
vn.Parent = body

local en = Instance.new("TextLabel")
en.Text = CONFIG.EN
en.Font = Enum.Font.Gotham
en.TextScaled = true
en.TextWrapped = true
en.Size = UDim2.fromScale(0.94, 0.48)
en.BackgroundTransparency = 1
en.TextColor3 = Color3.fromRGB(230, 236, 250) -- sáng hơn nhiều
en.TextTransparency = 0
en.TextStrokeTransparency = 0.75
en.TextStrokeColor3 = Color3.fromRGB(16, 16, 24)
en.ZIndex = 4
en.Parent = body

-- ===== ERROR BOX (nổi bật, dễ đọc) =====
local err = Instance.new("Frame")
err.Size = UDim2.fromScale(0.94, 0.2)
err.BackgroundColor3 = Color3.fromRGB(170, 20, 20) -- đỏ tươi
err.BackgroundTransparency = 0.08
err.LayoutOrder = 3
err.ZIndex = 5
err.Parent = card
Instance.new("UICorner", err).CornerRadius = UDim.new(0, 10)
local errStroke = Instance.new("UIStroke", err)
errStroke.Color = Color3.fromRGB(255, 120, 120)
errStroke.Thickness = 1

local errTxt = Instance.new("TextLabel")
errTxt.Text = string.format("⚠️ ERROR ⚠️ \nGame: %s\n%s — %s",
    CONFIG.Error.Code, CONFIG.Error.Message, CONFIG.Error.Details)
errTxt.Font = Enum.Font.GothamBold
errTxt.TextScaled = true
errTxt.TextWrapped = true
errTxt.Size = UDim2.fromScale(0.96, 0.86)
errTxt.Position = UDim2.fromScale(0.02, 0.07)
errTxt.BackgroundTransparency = 1
-- 🔴 CHỮ TRẮNG NỔI TRÊN ĐỎ
errTxt.TextColor3 = Color3.fromRGB(255, 242, 242)
errTxt.TextTransparency = 0
errTxt.TextStrokeTransparency = 0.5
errTxt.TextStrokeColor3 = Color3.fromRGB(90, 0, 0)
errTxt.ZIndex = 6
errTxt.Parent = err

-- ===== FOOTER: Timer + Discord =====
local footer = Instance.new("Frame")
footer.BackgroundTransparency = 1
footer.Size = UDim2.fromScale(1, 0.16)
footer.LayoutOrder = 4
footer.ZIndex = 3
footer.Parent = card

local ftLayout = Instance.new("UIListLayout", footer)
ftLayout.FillDirection = Enum.FillDirection.Vertical
ftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ftLayout.VerticalAlignment = Enum.VerticalAlignment.Top
ftLayout.Padding = UDim.new(0, 6)

local timer = Instance.new("TextLabel")
timer.Text = "Còn lại: " .. CONFIG.TimeLeft .. "s"
timer.Font = Enum.Font.GothamBlack
timer.TextScaled = true
timer.BackgroundTransparency = 1
timer.Size = UDim2.fromScale(1, 0.55)
-- 💧 SÁNG/XANH CYAN
timer.TextColor3 = Color3.fromRGB(0, 220, 255)
timer.TextTransparency = 0
timer.TextStrokeTransparency = 0.65
timer.TextStrokeColor3 = Color3.fromRGB(10, 22, 32)
timer.ZIndex = 4
timer.Parent = footer

task.spawn(function()
    local t = CONFIG.TimeLeft
    while t > 0 do
        t -= 1
        timer.Text = "Còn lại: " .. t .. "s"
        task.wait(1)
    end
    timer.Text = "Sắp hoàn tất!"
end)

local btn = Instance.new("TextButton")
btn.Text = "💬 Join Discord"
btn.Font = Enum.Font.GothamSemibold
btn.TextScaled = true
btn.Size = UDim2.fromOffset(240, 50)
btn.AnchorPoint = Vector2.new(0.5, 0)
btn.Position = UDim2.fromScale(0.5, 0)
btn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
btn.TextColor3 = Color3.new(1,1,1)
btn.AutoButtonColor = true
btn.ZIndex = 4
btn.Parent = footer
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
local btnStroke = Instance.new("UIStroke", btn)
btnStroke.Color = Color3.fromRGB(255,255,255)
btnStroke.Transparency = 0.25

btn.MouseEnter:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120,140,255)}):Play()
end)
btn.MouseLeave:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(88,101,242)}):Play()
end)
btn.MouseButton1Click:Connect(function()
    local ok = pcall(function() setclipboard(CONFIG.DiscordInvite) end)
    if ok then
        StarterGui:SetCore("SendNotification", {Title="Discord", Text="Đã sao chép link!", Duration=3})
    else
        StarterGui:SetCore("SendNotification", {Title="Discord", Text=CONFIG.DiscordInvite, Duration=3})
    end
end)

-- ===== ENTRANCE ANIMATION =====
card.Size = UDim2.fromScale(0,0)
TweenService:Create(card, TweenInfo.new(0.9, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.fromScale(0.74, 0.56)
}):Play()
