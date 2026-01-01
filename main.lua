-- FFH4X-by xpl0it.d3v | PULISHED UI + NOTIFICATION SYSTEM
-- Optimized for 120 FPS | Ultra-Smooth | Professional UX

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera

local Theme = {
    Main = Color3.fromRGB(12, 12, 12),
    Sidebar = Color3.fromRGB(15, 15, 15),
    Header = Color3.fromRGB(220, 0, 0), 
    Accent = Color3.fromRGB(220, 0, 0), 
    Text = Color3.fromRGB(255, 255, 255),
    NotifyBg = Color3.fromRGB(20, 20, 20)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FFH4X_PREMIUM_UI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999
ScreenGui.ResetOnSpawn = false

-- SISTEMA DE NOTIFICACIÓN
local function ShowNotification()
    local NotifyFrame = Instance.new("Frame")
    NotifyFrame.Name = "Notification"
    NotifyFrame.Size = UDim2.new(0, 320, 0, 75)
    NotifyFrame.Position = UDim2.new(0.5, -160, 0, -100)
    NotifyFrame.BackgroundColor3 = Theme.NotifyBg
    NotifyFrame.BorderSizePixel = 0
    NotifyFrame.ZIndex = 10
    
    local NC = Instance.new("UICorner", NotifyFrame)
    NC.CornerRadius = UDim.new(0, 10)
    
    local NLine = Instance.new("Frame")
    NLine.Name = "Accent"
    NLine.Size = UDim2.new(0, 6, 1, 0) 
    NLine.Position = UDim2.new(0, 0, 0, 0) 
    NLine.BackgroundColor3 = Theme.Header
    NLine.BorderSizePixel = 0
    NLine.ZIndex = 11
    NLine.Parent = NotifyFrame
    
    Instance.new("UICorner", NLine).CornerRadius = UDim.new(0, 10)

    local NTitle = Instance.new("TextLabel")
    NTitle.Text = "FFH4X by @xpl0it.d3v"
    NTitle.Font = Enum.Font.GothamBold
    NTitle.TextColor3 = Theme.Header
    NTitle.TextSize = 14
    NTitle.BackgroundTransparency = 1
    NTitle.Position = UDim2.new(0, 25, 0, 15) 
    NTitle.Size = UDim2.new(1, -35, 0, 15)
    NTitle.TextXAlignment = Enum.TextXAlignment.Left
    NTitle.ZIndex = 12
    NTitle.Parent = NotifyFrame

    local NSub = Instance.new("TextLabel")
    NSub.Text = "MENU MINIMIZADO. DESLICE SU DEDO DESDE EL CENTRO HACIA ABAJO"
    NSub.Font = Enum.Font.GothamMedium
    NSub.TextColor3 = Theme.Text
    NSub.TextSize = 11
    NSub.BackgroundTransparency = 1
    NSub.Position = UDim2.new(0, 25, 0, 35)
    NSub.Size = UDim2.new(1, -35, 0, 30)
    NSub.TextXAlignment = Enum.TextXAlignment.Left
    NSub.TextWrapped = true
    NSub.ZIndex = 12
    NSub.Parent = NotifyFrame

    NotifyFrame.Parent = ScreenGui

    TweenService:Create(NotifyFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -160, 0, 30)}):Play()
    
    task.delay(4, function()
        local out = TweenService:Create(NotifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(0.5, -160, 0, -100)})
        out:Play()
        out.Completed:Connect(function() NotifyFrame:Destroy() end)
    end)
end

-- PANEL PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 300)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
MainFrame.BackgroundColor3 = Theme.Main
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 32)
Header.BackgroundColor3 = Theme.Header
Header.Parent = MainFrame
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Header)
Title.Text = "•  FFH4X PRISON LIFE - @xpl0it.d3v"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Theme.Text
Title.TextSize = 13
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Theme.Text
CloseBtn.TextSize = 18
CloseBtn.AutoButtonColor = false

-- SIDEBAR (TUS BOTONES ORIGINALES)
local SideBar = Instance.new("Frame", MainFrame)
SideBar.Size = UDim2.new(0, 65, 1, -32)
SideBar.Position = UDim2.new(0, 0, 0, 32)
SideBar.BackgroundColor3 = Theme.Sidebar
Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 10)

-- GESTIÓN DE PESTAÑAS (SISTEMA NUEVO)
local TabContainers = {}
local CurrentTab = nil

local function ShowTab(name)
    for tabName, container in pairs(TabContainers) do
        container.Visible = (tabName == name)
    end
end

local function CreateTab(name, index)
    -- Botón en la Sidebar
    local TabBtn = Instance.new("TextButton", SideBar)
    TabBtn.Size = UDim2.new(0, 45, 0, 45)
    TabBtn.Position = UDim2.new(0.5, -22, 0, 15 + (index * 55))
    TabBtn.BackgroundColor3 = Theme.Accent
    TabBtn.Text = "" -- Puedes poner un icono o texto corto
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 10)
    
    -- Contenedor de la pestaña
    local NewContainer = Instance.new("Frame", MainFrame)
    NewContainer.Name = name .. "_Container"
    NewContainer.Size = UDim2.new(1, -85, 1, -50)
    NewContainer.Position = UDim2.new(0, 75, 0, 42)
    NewContainer.BackgroundTransparency = 1
    NewContainer.Visible = false
    
    TabContainers[name] = NewContainer
    
    TabBtn.MouseButton1Click:Connect(function()
        ShowTab(name)
    end)
    
    return NewContainer
end

local function CreateCheckbox(parent, text, pos, callback)
    local CheckboxFrame = Instance.new("TextButton")
    CheckboxFrame.Name = text .. "_CB"
    CheckboxFrame.Parent = parent
    CheckboxFrame.Size = UDim2.new(0, 90, 0, 30)
    CheckboxFrame.Position = pos
    CheckboxFrame.BackgroundTransparency = 1
    CheckboxFrame.Text = ""
    CheckboxFrame.ZIndex = 5

    -- El cuadro (Indicator)
    local Indicator = Instance.new("Frame")
    Indicator.Name = "Box"
    Indicator.Parent = CheckboxFrame
    Indicator.Size = UDim2.new(0, 22, 0, 22)
    Indicator.Position = UDim2.new(0, 2, 0.5, -11)
    Indicator.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Indicator.BorderSizePixel = 0
    Indicator.ZIndex = 6
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(0, 3)
    
    -- La marca de verificado
    local CheckMark = Instance.new("TextLabel")
    CheckMark.Parent = Indicator
    CheckMark.Size = UDim2.new(1, 0, 1, 0)
    CheckMark.Text = "✓"
    CheckMark.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckMark.TextSize = 16
    CheckMark.Font = Enum.Font.GothamBold
    CheckMark.BackgroundTransparency = 1
    CheckMark.TextTransparency = 1
    CheckMark.ZIndex = 7
    
    -- El texto (Label)
    local Label = Instance.new("TextLabel")
    Label.Parent = CheckboxFrame
    Label.Size = UDim2.new(1, -35, 1, 0)
    Label.Position = UDim2.new(0, 30, 0, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 6
    
    local active = false
    CheckboxFrame.MouseButton1Click:Connect(function()
        active = not active
        -- Tu animación de 120 FPS
        TweenService:Create(Indicator, TweenInfo.new(0.12, Enum.EasingStyle.Sine), {
            BackgroundColor3 = active and Color3.fromRGB(220, 0, 0) or Color3.fromRGB(40, 40, 40)
        }):Play()
        TweenService:Create(CheckMark, TweenInfo.new(0.12, Enum.EasingStyle.Sine), {
            TextTransparency = active and 0 or 1
        }):Play()
        callback(active)
    end)
end

local function CreateSlider(parent, text, pos, min, max, callback)
    local SliderFrame = Instance.new("Frame", parent)
    SliderFrame.Name = text .. "_Slider"
    SliderFrame.Size = UDim2.new(1, -20, 0, 45)
    SliderFrame.Position = pos
    SliderFrame.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", SliderFrame)
    Label.Text = text .. " : " .. min
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.TextColor3 = Theme.Text
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 12
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Bar = Instance.new("Frame", SliderFrame)
    Bar.Size = UDim2.new(1, -10, 0, 6)
    Bar.Position = UDim2.new(0, 0, 0, 28)
    Bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Bar.BorderSizePixel = 0
    Instance.new("UICorner", Bar).CornerRadius = UDim.new(0, 8)

    local Fill = Instance.new("Frame", Bar)
    Fill.Size = UDim2.new(0, 0, 1, 0)
    Fill.BackgroundColor3 = Theme.Accent
    Fill.BorderSizePixel = 0
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(0, 8)

    local dragging = false
    local function update()
        local mousePos = UserInputService:GetMouseLocation().X
        local barPos = Bar.AbsolutePosition.X
        local barSize = Bar.AbsoluteSize.X
        local percent = math.clamp((mousePos - barPos) / barSize, 0, 1)
        
        Fill.Size = UDim2.new(percent, 0, 1, 0)
        local value = math.floor(min + (max - min) * percent)
        Label.Text = text .. " : " .. tostring(value)
        callback(value)
    end

    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update()
        end
    end)
end

-- CREACIÓN DE LAS 4 PESTAÑAS
local TabAimbot  = CreateTab("Aimbot", 0)
local TabVisuals  = CreateTab("Visuals", 1)
local TabMisc     = CreateTab("Misc", 2)
local TabSettings = CreateTab("Settings", 3)

-- AIMBOT
local AimlockActive = false
local TeamCheckEnabled = false
local WallCheckEnabled = false
local PredictionEnabled = false
local ShowFOV = false
local ShowAimLine = false
local AimPart = "Head"
local AimFOV = 150
local Smoothness = 0.50
local PredictionIntensity = 0.165

-- 1. FILTRO DE EQUIPO
local function IsEnemy(p)
    if not TeamCheckEnabled then return true end
    local me = Players.LocalPlayer
    if not p.Team or not me.Team then return true end

    local myTeam = me.Team.Name
    local targetTeam = p.Team.Name

    -- LÓGICA DE PRIORIDADES DE GENIO
    if myTeam == "Guardians" then
        return targetTeam == "Criminals" or targetTeam == "Prisoners"
        
    elseif myTeam == "Prisoners" then
        return targetTeam == "Guardians"
        
    elseif myTeam == "Criminals" then
        return targetTeam == "Guardians"
    end

    return targetTeam ~= myTeam
end

-- 2. FILTRO DE PAREDES (RAYCAST)
local function IsVisible(targetPart, character)
    if not WallCheckEnabled then return true end
    
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin).Unit * (targetPart.Position - origin).Magnitude
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {Players.LocalPlayer.Character, character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    
    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
    
    return raycastResult == nil 
end

local function GetClosest()
    local closest, minDist = nil, AimFOV
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= Players.LocalPlayer and v.Character and v.Character:FindFirstChild(AimPart) then
            
            -- Primero verificamos si es enemigo (es el filtro más rápido)
            if IsEnemy(v) then 
                local targetObj = v.Character[AimPart]
                local hum = v.Character:FindFirstChild("Humanoid")
                
                if hum and hum.Health > 0 then
                    local pos, onScreen = Camera:WorldToViewportPoint(targetObj.Position)
                    
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        -- Solo hacemos el Wall Check (que es más pesado) si está cerca y en FOV
                        if dist < minDist then
                            if IsVisible(targetObj, v.Character) then
                                closest = targetObj
                                minDist = dist
                            end
                        end
                    end
                end
            end
        end
    end
    return closest
end 

RunService.RenderStepped:Connect(function()
    if AimlockActive then
        local target = GetClosest()
        if target and target.Parent then
            local targetPos = target.Position
            
            -- LÓGICA DE PREDICCIÓN (Matemática de Genio)
            if PredictionEnabled then
                local rootPart = target.Parent:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    targetPos = targetPos + (rootPart.Velocity * PredictionIntensity)
                end
            end
            
            local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Smoothness)
        end
    end
end)

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Filled = false
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 64

RunService.RenderStepped:Connect(function()
    if ShowFOV then
        FOVCircle.Visible = true
        FOVCircle.Radius = AimFOV
        FOVCircle.Position = Camera.ViewportSize / 2
    else
        FOVCircle.Visible = false
    end
end)

local AimLine = Drawing.new("Line")
AimLine.Thickness = 1.5
AimLine.Color = Color3.fromRGB(255, 255, 255)
AimLine.Transparency = 0.8
AimLine.Visible = false

RunService.RenderStepped:Connect(function()
    local targetPart = GetClosest()

    if ShowAimLine and targetPart then
        local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
        
        if onScreen then
            AimLine.From = Camera.ViewportSize / 2
            AimLine.To = Vector2.new(screenPos.X, screenPos.Y)
            AimLine.Visible = true
        else
            AimLine.Visible = false
        end
    else
        AimLine.Visible = false
    end
end)

local ESPBoxesEnabled = false

local function GetHighlightColor(player)
    local team = player.Team
    if not team then return Color3.fromRGB(255, 255, 255) end
    
    local tc = team.TeamColor.Name
    
    if tc == "Bright blue" or tc == "Deep blue" then
        return Color3.fromRGB(0, 160, 255) -- Azul (Guardias)
    elseif tc == "Bright orange" then
        return Color3.fromRGB(255, 165, 0) -- Naranja (Prisioneros)
    elseif tc == "Really red" or tc == "Bright red" then
        return Color3.fromRGB(255, 0, 0)   -- Rojo (Criminales)
    end
    
    return Color3.fromRGB(255, 255, 255) -- Blanco (Neutral/Sin equipo)
end

-- 2. EL BUCLE SE MANTIENE IGUAL (Asegúrate de que OutlineColor = FillColor)
RunService.RenderStepped:Connect(function()
    local closestTarget = GetClosest()

    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= Players.LocalPlayer and v.Character then
            local char = v.Character
            local highlight = char:FindFirstChild("ESPHighlight")

            if ESPBoxesEnabled then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.Parent = char
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                end

                if closestTarget and closestTarget.Parent == char then
                    local green = Color3.fromRGB(0, 255, 0)
                    highlight.FillColor = green
                    highlight.OutlineColor = green
                else
                    local teamCol = GetHighlightColor(v)
                    highlight.FillColor = teamCol
                    highlight.OutlineColor = teamCol
                end
                highlight.Enabled = true
            else
                if highlight then highlight.Enabled = false end
            end
        end
    end
end)

local TracersEnabled = false

local Tracers = {}

RunService.RenderStepped:Connect(function()
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= Players.LocalPlayer then
            -- Solo creamos línea si el jugador es ENEMIGO y los Tracers están ON
            if TracersEnabled and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and IsEnemy(v) then
                local root = v.Character.HumanoidRootPart
                local hum = v.Character:FindFirstChild("Humanoid")
                
                if hum and hum.Health > 0 then
                    local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    
                    if onScreen then
                        -- Si no existe la línea para este jugador, la creamos
                        if not Tracers[v] then
                            Tracers[v] = Drawing.new("Line")
                            Tracers[v].Thickness = 1
                            Tracers[v].Transparency = 0.8
                        end
                        
                        local line = Tracers[v]
                        line.Visible = true
                        line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) -- Desde abajo centro
                        line.To = Vector2.new(pos.X, pos.Y)
                        line.Color = GetHighlightColor(v) -- Naranja, Azul o Rojo según tu equipo
                    else
                        if Tracers[v] then Tracers[v].Visible = false end
                    end
                else
                    if Tracers[v] then Tracers[v].Visible = false end
                end
            else
                -- Si no es enemigo o está muerto, ocultamos la línea
                if Tracers[v] then
                    Tracers[v].Visible = false
                end
            end
        end
    end
end)

local NameESPEnabled = false

local NameTags = {}

RunService.RenderStepped:Connect(function()
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= Players.LocalPlayer then
            if NameESPEnabled and v.Character and v.Character:FindFirstChild("Head") and IsEnemy(v) then
                local head = v.Character.Head
                local hum = v.Character:FindFirstChild("Humanoid")
                
                if hum and hum.Health > 0 then
                    local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    
                    if onScreen then
                        if not NameTags[v] then
                            NameTags[v] = Drawing.new("Text")
                            NameTags[v].Size = 16 
                            NameTags[v].Center = true
                            NameTags[v].Outline = true
                            NameTags[v].Font = 2 
                        end
                        
                        local tag = NameTags[v]
                        tag.Visible = true
                        -- Posicionamos el nombre justo arriba de la cabeza
                        tag.Position = Vector2.new(pos.X, pos.Y - 30)
                        tag.Text = v.Name -- SOLO EL NOMBRE (Sin Health)
                        tag.Color = GetHighlightColor(v) 
                    else
                        if NameTags[v] then NameTags[v].Visible = false end
                    end
                else
                    if NameTags[v] then NameTags[v].Visible = false end
                end
            else
                -- Limpieza si no debe mostrarse
                if NameTags[v] then NameTags[v].Visible = false end
            end
        end
    end
end)

CreateCheckbox(TabAimbot, "Aimbot Lock", UDim2.new(0, 10, 0, 10), function(v) 
    AimlockActive = v 
end)

CreateCheckbox(TabAimbot, "Team Check", UDim2.new(0, 120, 0, 10), function(v) 
    TeamCheckEnabled = v 
end)

CreateCheckbox(TabAimbot, "Wall Check", UDim2.new(0, 230, 0, 10), function(v) 
    WallCheckEnabled = v 
end)

CreateCheckbox(TabAimbot, "Prediction", UDim2.new(0, 10, 0, 50), function(v) 
    PredictionEnabled = v 
end)

CreateCheckbox(TabAimbot, "Show FOV", UDim2.new(0, 120, 0, 50), function(v) 
    ShowFOV = v 
end)

CreateCheckbox(TabAimbot, "Aim Line", UDim2.new(0, 10, 0, 150), function(v) 
    ShowAimLine = v 
end)

CreateSlider(TabAimbot, "FOV Range", UDim2.new(0, 10, 0, 100), 50, 800, function(v) AimFOV = v end)

CreateCheckbox(TabVisuals, "Esp Boxes", UDim2.new(0, 10, 0, 10), function(v) 
    ESPBoxesEnabled = v 
end)

CreateCheckbox(TabVisuals, "Tracers", UDim2.new(0, 120, 0, 10), function(v) 
    TracersEnabled = v 
end)

CreateCheckbox(TabVisuals, "TracerName", UDim2.new(0, 230, 0, 10), function(v) 
    NameESPEnabled = v 
end)

CreateCheckbox(TabSettings, "Rainbow UI", UDim2.new(0, 10, 0, 10), function(v) end)

ShowTab("Aimbot")

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ShowNotification()
end)

local startPos = nil
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        local posX = input.Position.X
        local screenW = workspace.CurrentCamera.ViewportSize.X
        if posX > (screenW * 0.3) and posX < (screenW * 0.7) then startPos = input.Position end
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if startPos and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
        if (input.Position.Y - startPos.Y) > 120 then MainFrame.Visible = true end
        startPos = nil
    end
end)

-- DRAG
local dragging, dragStart, dragOrigPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position dragOrigPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(dragOrigPos.X.Scale, dragOrigPos.X.Offset + delta.X, dragOrigPos.Y.Scale, dragOrigPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input) dragging = false end)
