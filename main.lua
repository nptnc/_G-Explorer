local UserInputService = game:GetService("UserInputService")
setthreadidentity(2)
local loops = {}
local objects = {}

if getgenv()._G.stuff then
    for _,loop in getgenv()._G.stuff.loops do
        loop:Disconnect()
    end
    for _,object in getgenv()._G.stuff.objects do
        object:Destroy()
    end
end

local createInstance = function(Type,data)
    local object = Instance.new(Type)
    for index,value in data do
        object[index] = value
    end
    table.insert(objects,object)
    return object
end

local ui = createInstance("ScreenGui",{
    Parent = game.Players.LocalPlayer.PlayerGui,
    Name = "NipitikisExplorerThingyTwo",
    DisplayOrder = 999,
})

local MainUI = createInstance("Frame",{
    Size = UDim2.new(0.25,0,0.35,0),
    Parent = ui,
    Name = "Wrapper",
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5,0,0.5,0),
    AnchorPoint = Vector2.new(0.5,0.5),
})

local ExplorerFrame = createInstance("Frame",{
    Size = UDim2.new(1,0,0.95,0),
    Position = UDim2.new(0,0,0.05,0),
    Parent = MainUI,
    Name = "Explorer",
    BorderSizePixel = 0,
    BackgroundColor3 = Color3.fromRGB(23,23,23),
    BackgroundTransparency = 0,
})
createInstance("UICorner",{Parent = ExplorerFrame})

local TopbarFrame = createInstance("Frame",{
    Size = UDim2.new(0.7,0,0.08,0),
    Position = UDim2.new(0,0,0,0),
    Parent = MainUI,
    Name = "Topbar",
    BorderSizePixel = 0,
    BackgroundColor3 = Color3.fromRGB(23,23,23),
    BackgroundTransparency = 0,
})
createInstance("UICorner",{Parent = TopbarFrame, CornerRadius = UDim.new(0,5)})

local TopbarButtons = createInstance("Frame",{
    Size = UDim2.new(0.25,-2, 1,-5),
    Position = UDim2.new(0.75,0, 0,5),
    Parent = TopbarFrame,
    Name = "Buttons",
    BorderSizePixel = 0,
    BackgroundTransparency = 1,
})
local TopbarClose = createInstance("TextButton",{
    Size = UDim2.new(0.45,0, 1,0),
    Position = UDim2.new(0.5,0, 0,0),
    Parent = TopbarButtons,
    Name = "Close",
    BorderSizePixel = 0,
    BackgroundColor3 = Color3.fromRGB(0,0,0),
    BackgroundTransparency = 0.6,
    TextColor3 = Color3.fromRGB(106,0,0),
    Text = "X",
})
createInstance("UICorner",{Parent = TopbarClose})
local TopbarMinimize = createInstance("TextButton",{
    Size = UDim2.new(0.45,0, 1,0),
    Position = UDim2.new(0,0, 0,0),
    Parent = TopbarButtons,
    Name = "Minimize",
    BorderSizePixel = 0,
    BackgroundColor3 = Color3.fromRGB(0,0,0),
    BackgroundTransparency = 0.6,
    TextColor3 = Color3.fromRGB(106,106,106),
    Text = "-",
})
createInstance("UICorner",{Parent = TopbarMinimize})

TopbarMinimize.MouseButton1Click:Connect(function()
    ui.Enabled = not ui.Enabled
    if isHours then
        getrenv()._G.SetCameraLock(not ui.Enabled)
    end
end)

local TopbarPath = createInstance("Frame",{
    Size = UDim2.new(0.75,-10,1,-5),
    Position = UDim2.new(0,7,0,5),
    Parent = TopbarFrame,
    Name = "Path",
    BorderSizePixel = 0,
    BackgroundColor3 = Color3.fromRGB(0,0,0),
    BackgroundTransparency = 0.6,
})
createInstance("UICorner",{Parent = TopbarPath})
local TopbarPathScroller = createInstance("ScrollingFrame",{
    Size = UDim2.new(1,-10,1,-5),
    Position = UDim2.new(0,0,0,0),
    Parent = TopbarPath,
    Name = "PathScroller",
    BorderSizePixel = 0,
    BackgroundColor3 = Color3.fromRGB(23,23,23),
    BackgroundTransparency = 1,
    ScrollingDirection = Enum.ScrollingDirection.X,
    CanvasSize = UDim2.new(2.5,0, 2,0),
    ScrollBarThickness = 0,
})
local TopbarPathScrollerText = createInstance("TextLabel",{
    Size = UDim2.new(0,0,0,0),
    Position = UDim2.new(0,8,0,6),
    Parent = TopbarPathScroller,
    Name = "PathText",
    BorderSizePixel = 0,
    BackgroundColor3 = Color3.fromRGB(23,23,23),
    TextColor3 = Color3.fromRGB(103,103,103),
    BackgroundTransparency = 1,
    AutomaticSize = Enum.AutomaticSize.XY,
    Text = "G:/",
})


local Sidebar = createInstance("Frame",{
    Parent = ExplorerFrame,
    Name = "Sidebar",
    Size = UDim2.new(0.36,0, 0.93,0),
    Position = UDim2.new(0,7, 0.02,7),
    BorderSizePixel = 0,
    BackgroundTransparency = 0.6,
    BackgroundColor3 = Color3.fromRGB(0,0,0),
})
local SidebarScroller = createInstance("ScrollingFrame",{
    Parent = Sidebar,
    Name = "Scroller",
    Size = UDim2.new(0.95,0, 0.95,0),
    Position = UDim2.new(0,7, 0,7),
    BorderSizePixel = 0,
    BackgroundTransparency = 1,
    BackgroundColor3 = Color3.fromRGB(0,0,0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 5,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    CanvasSize = UDim2.new(1,0,0,0)
})
createInstance("UICorner",{Parent = Sidebar})

local uill = createInstance("UIListLayout",{
    Parent = SidebarScroller,
    SortOrder = Enum.SortOrder.LayoutOrder,
})


local explorer = createInstance("Frame",{
    Parent = ExplorerFrame,
    Name = "Panel",
    AnchorPoint = Vector2.new(1,0),
    Size = UDim2.new(0.6,0,0.93,0),
    Position = UDim2.new(1,-7,0.02,7),
    BorderSizePixel = 0,
    BackgroundTransparency = 0.6,
    BackgroundColor3 = Color3.fromRGB(0,0,0),
})
createInstance("UICorner",{Parent = explorer})

local generate

local sections = {}
local explorerInstances = {}

local currentSectionData = {
    length = 0,
}

local tableindexes = {
    ["table"] = 0,
    ["function"] = 0,
    other = 0,
}

local createSection = function(text,data,onClick)
    local sectionFrame = createInstance("Frame",{
        Parent = SidebarScroller,
        AnchorPoint = Vector2.new(1,0),
        Size = UDim2.new(1,0,0,20),
        Position = UDim2.new(1,0,0,0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        LayoutOrder = 0,
    })

    if data.type == "table" then
        sectionFrame.LayoutOrder = data.index
    elseif data.type == "function" then
        sectionFrame.LayoutOrder = tableindexes.table + data.index
    elseif data.type == nil then
        sectionFrame.LayoutOrder = 0
    else
        sectionFrame.LayoutOrder = 9999
    end

    local textlabel = createInstance("TextButton",{
        Parent = sectionFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1,0,1,0),
        TextColor3 = data.color or Color3.fromRGB(255,255,255),
        Text = text,
        TextSize = 18,
        Font = Enum.Font.RobotoMono,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    textlabel.MouseButton1Click:Connect(function()
        if onClick then
            onClick()
        end
    end)

    table.insert(sections,sectionFrame)
    return sectionFrame
end

local maxRecursion = 10
local deepSearch = function(ot,c)
    local recursion = 0
    local r
    r = function(parent)
        recursion += 1
        for index,value in parent do
            if typeof(value) == "table" then
                if recursion < maxRecursion then
                    r(value)
                end
            end
            c(index,value,parent)
        end
    end
    r(ot)
end

local shallowSearch = function(ot,c)
    local r
    r = function(t)
        for index,value in t do
            c(index,value)
        end
    end
    r(ot)
end

local colors = {
    ["table"] = Color3.fromRGB(255, 255, 255),
    ["function"] = Color3.fromRGB(151, 122, 255),
}

local figureOutVariable = function(variable)
    local newVariable = variable
    if newVariable == "true" then
        newVariable = true
    elseif newVariable == "false" then
        newVariable = false
    elseif tonumber(newVariable) then
        newVariable = tonumber(newVariable)
    end
    return newVariable
end

local len = function(t)
    local index = 0
    for _,_ in t do
        index += 1
    end
    return index
end

local getFromPath = function(path)
    if path == nil then
        return getrenv()._G
    end
    local args = string.split(path,"/")
    local start = getrenv()._G
    for index,arg in args do
        if tonumber(arg) then
            arg = tonumber(arg)
        end
        if start[arg] == nil then
            return start
        end
        start = start[arg]
    end
    return start
end

local lastCanvasPosition = {}
generate = function(path)
    local GRAHHH = ""
    if path == "" or path == nil then
        GRAHHH = "_G"
    else
        GRAHHH = `_G/{path}`
    end
    TopbarPathScrollerText.Text = GRAHHH
    local parent = getFromPath(path)
    for _,section in sections do
        section:Destroy()
    end
    sections = {}
    local goBack = nil
    if path ~= nil then
        goBack = createSection("...",{},function()
            local args = string.split(path,"/")
            local newPath = ""
            for index,arg in args do
                if index >= #args then
                    continue
                end
                if index <= 1 then
                    newPath ..= `{arg}`
                    continue
                end
                newPath ..= `/{arg}`
            end
            if newPath == "" then
                newPath = nil
            end
            lastCanvasPosition[GRAHHH] = SidebarScroller.CanvasPosition
            generate(newPath)
        end)
    end
    local searchBox = createInstance("TextBox",{
        Parent = SidebarScroller,
        Text = ``,
        PlaceholderText = "search",
        PlaceholderColor3 = Color3.fromRGB(75, 75, 75),
        BackgroundTransparency = 1,
        Position = UDim2.new(0,0,0.1,0),
        Size = UDim2.new(1,0,0,20),
        TextSize = 18,
        Font = Enum.Font.RobotoMono,
        TextColor3 = Color3.fromRGB(190, 190, 190),
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        for _,section in sections do
            if section:IsA("TextBox") or section == goBack then
                continue
            end
            if section.TextButton.Text:lower():match(searchBox.Text:lower()) then
                section.Visible = true
            else
                section.Visible = false
            end
        end
    end)
    table.insert(sections,searchBox)
    shallowSearch(parent,function(index,value)
        local TYPE = typeof(value)
        if TYPE ~= "table" and TYPE ~= "function" then
            TYPE = "other"
        end
        tableindexes[TYPE] += 1
    end)

    local tableindexes2 = {
        ["table"] = 0,
        ["function"] = 0,
        other = 0,
    }
    shallowSearch(parent,function(index,value)
        if index == "__parent" then
            return
        end

        local TYPE = typeof(value)
        if TYPE ~= "table" and TYPE ~= "function" then
            TYPE = "other"
        end

        tableindexes2[TYPE] += 1

        createSection(`{index}`,{color = colors[typeof(value)] or Color3.fromRGB(255, 0, 0), index = tableindexes2[TYPE], type = TYPE},function()
            if typeof(value) == "table" then
                local newPath = path == nil and index or `{path}/{index}`
                lastCanvasPosition[GRAHHH] = SidebarScroller.CanvasPosition
                generate(newPath)
            elseif typeof(value) == "function" then
                for _,instance in explorerInstances do
                    instance:Destroy()
                end
                explorerInstances = {}

                local instance = createInstance("TextLabel",{
                    Parent = explorer,
                    Text = `Function: {index}`,
                    Size = UDim2.new(1,0,0.1,0),
                    TextColor3 = Color3.fromRGB(109,109,109),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                })

                local isTable = false
                local arguments = 0
                local correspondingArgUI = {}
                local buttonPosY = 0.22
                local toMove = {}

                local isTableButton = createInstance("TextButton",{
                    Parent = explorer,
                    Text = `Is Table: {isTable}`,
                    AnchorPoint = Vector2.new(0.5,0),
                    BorderColor3 = Color3.fromRGB(22,22,22),
                    Position = UDim2.new(0.5,0,0.1,0),
                    Size = UDim2.new(0.25,0, 0.1,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    BackgroundColor3 = Color3.fromRGB(8,8,8),
                })

                isTableButton.MouseButton1Click:Connect(function()
                    isTable = not isTable
                    isTableButton.Text = `Is Table: {isTable}`
                    arguments = 0
                    for _,arg in correspondingArgUI do
                        if typeof(arg) == "table" then
                            arg.index:Destroy()
                            arg.value:Destroy()
                            continue
                        end
                        arg:Destroy()
                    end
                    correspondingArgUI = {}
                    for _,move in toMove do
                        move.Position = UDim2.new(move.Position.X.Scale,move.Position.X.Offset,buttonPosY + 0.1 * arguments,0)
                    end
                end)

                local instance3 = createInstance("TextButton",{
                    Parent = explorer,
                    Text = `Call`,
                    BorderColor3 = Color3.fromRGB(22,22,22),
                    Position = UDim2.new(0,7, buttonPosY,0),
                    Size = UDim2.new(0.2,0, 0.1,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    BackgroundColor3 = Color3.fromRGB(8,8,8),
                })

                local instance4 = createInstance("TextButton",{
                    Parent = explorer,
                    Text = `Arg`,
                    BorderColor3 = Color3.fromRGB(22,22,22),
                    Position = UDim2.new(0.225,7, buttonPosY,0),
                    Size = UDim2.new(0.2,0, 0.1,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    BackgroundColor3 = Color3.fromRGB(8,8,8),
                })

                local instance6 = createInstance("TextButton",{
                    Parent = explorer,
                    Text = `Remove Arg`,
                    BorderColor3 = Color3.fromRGB(22,22,22),
                    Position = UDim2.new(0.45,7, buttonPosY,0),
                    Size = UDim2.new(0.25,0, 0.1,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    BackgroundColor3 = Color3.fromRGB(8,8,8),
                })

                toMove = {
                    instance3,
                    instance4,
                    instance6,
                }

                instance4.MouseButton1Click:Connect(function()
                    arguments += 1
                    for _,move in toMove do
                        move.Position = UDim2.new(move.Position.X.Scale,move.Position.X.Offset,buttonPosY + 0.1 * arguments,0)
                    end
                    if isTable then
                        local newArg = createInstance("TextBox",{
                            Parent = explorer,
                            Text = arguments,
                            PlaceholderText = "Index",
                            PlaceholderColor3 = Color3.fromRGB(95,95,95),
                            Position = UDim2.new(0,7, 0.20 + (0.10 * math.clamp(arguments-1,0,100)),0),
                            Size = UDim2.new(0.45,0, 0.1,0),
                            BorderColor3 = Color3.fromRGB(22,22,22),
                            BackgroundColor3 = Color3.fromRGB(8,8,8),
                            TextColor3 = Color3.fromRGB(255,255,255),
                        })
                        local newArg2 = createInstance("TextBox",{
                            Parent = explorer,
                            Text = "",
                            PlaceholderText = "Value",
                            PlaceholderColor3 = Color3.fromRGB(95,95,95),
                            AnchorPoint = Vector2.new(1,0),
                            Position = UDim2.new(1,-7, 0.20 + (0.10 * math.clamp(arguments-1,0,100)),0),
                            Size = UDim2.new(0.5,0, 0.1,0),
                            BorderColor3 = Color3.fromRGB(22,22,22),
                            BackgroundColor3 = Color3.fromRGB(8,8,8),
                            TextColor3 = Color3.fromRGB(255,255,255),
                        })
                        correspondingArgUI[arguments] = {
                            index = newArg,
                            value = newArg2,
                        }
                        table.insert(explorerInstances, newArg)
                        table.insert(explorerInstances, newArg2)
                        return
                    end
                    local newArg = createInstance("TextBox",{
                        Parent = explorer,
                        Text = ``,
                        PlaceholderText = "Argument",
                        PlaceholderColor3 = Color3.fromRGB(95,95,95),
                        Position = UDim2.new(0,7, 0.20 + (0.10 * math.clamp(arguments-1,0,100)),0),
                        Size = UDim2.new(0.95,0, 0.1,0),
                        BorderColor3 = Color3.fromRGB(22,22,22),
                        BackgroundColor3 = Color3.fromRGB(8,8,8),
                        TextColor3 = Color3.fromRGB(255,255,255),
                    })
                    correspondingArgUI[arguments] = newArg
                    table.insert(explorerInstances, newArg)
                end)

                instance3.MouseButton1Click:Connect(function()
                    local newargs = {}
                    if isTable then
                        newargs[1] = {}
                    end
                    for argIndex,argValue in correspondingArgUI do
                        if isTable then
                            newargs[1][argValue.index.Text] = figureOutVariable(argValue.value.Text)
                        else
                            newargs[argIndex] = figureOutVariable(argValue.Text)
                        end
                    end
                    value(table.unpack(newargs))
                end)

                instance6.MouseButton1Click:Connect(function()
                    if arguments <= 0 then
                        return
                    end
                    arguments -= 1
                    for _,move in toMove do
                        move.Position = UDim2.new(move.Position.X.Scale,move.Position.X.Offset,buttonPosY + 0.1 * arguments,0)
                    end
                    if typeof(correspondingArgUI[#correspondingArgUI]) == "table" then
                        correspondingArgUI[#correspondingArgUI].index:Destroy()
                        correspondingArgUI[#correspondingArgUI].value:Destroy()
                        correspondingArgUI[#correspondingArgUI] = nil
                        return
                    end
                    correspondingArgUI[#correspondingArgUI]:Destroy()
                    correspondingArgUI[#correspondingArgUI] = nil
                end)
                
                table.insert(explorerInstances,instance)
                table.insert(explorerInstances,instance3)
                table.insert(explorerInstances,instance4)
                table.insert(explorerInstances,instance6)
                table.insert(explorerInstances,isTableButton)
            else
                for _,instance in explorerInstances do
                    instance:Destroy()
                end
                explorerInstances = {}

                local instance3432 = createInstance("TextLabel",{
                    Parent = explorer,
                    Text = `{index} [{typeof(value)}]`,
                    Position = UDim2.new(0,0, 0,0),
                    TextColor3 = Color3.fromRGB(109,109,109),
                    Size = UDim2.new(1,0,0.1,0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(8,8,8),
                    BackgroundTransparency = 1,
                })

                local instance0 = createInstance("TextLabel",{
                    Parent = explorer,
                    Text = `{tostring(value)}`,
                    TextColor3 = Color3.fromRGB(150,150,150),
                    Size = UDim2.new(1,0,0.1,0),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0,0,0.05,0),
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    BackgroundTransparency = 1,
                })

                local instance = createInstance("TextBox",{
                    Parent = explorer,
                    Text = ``,
                    PlaceholderText = "Value",
                    PlaceholderColor3 = Color3.fromRGB(95,95,95),
                    BorderColor3 = Color3.fromRGB(22,22,22),
                    Position = UDim2.new(0,7, 0.15,0),
                    Size = UDim2.new(0.74,0, 0.1,0),
                    BackgroundColor3 = Color3.fromRGB(8,8,8),
                    TextColor3 = Color3.fromRGB(255,255,255),
                })

                local instance2 = createInstance("TextButton",{
                    Parent = explorer,
                    Text = `Set`,
                    BorderColor3 = Color3.fromRGB(22,22,22),
                    Position = UDim2.new(0.75,7, 0.15,0),
                    Size = UDim2.new(0.2,0, 0.1,0),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    BackgroundColor3 = Color3.fromRGB(8,8,8),
                })

                instance2.MouseButton1Click:Connect(function()
                    parent[index] = figureOutVariable(instance.Text)
                    instance0.Text = instance.Text
                    instance3432.Text = `{index} [{typeof(parent[index])}]`,

                    generate(getrenv()._G)
                end)

                table.insert(explorerInstances,instance0)
                table.insert(explorerInstances,instance)
                table.insert(explorerInstances,instance2)
                table.insert(explorerInstances,instance3432)
            end
        end)
    end)
    if lastCanvasPosition[GRAHHH] then
        SidebarScroller.CanvasPosition = lastCanvasPosition[GRAHHH]
    end
end

generate()

isHours = game.PlaceId == 5732973455
if isHours then
    getrenv()._G.SetCameraLock(not ui.Enabled)
end

table.insert(loops,UserInputService.InputBegan:Connect(function(i,g)
    if i.KeyCode == Enum.KeyCode.RightBracket then
        ui.Enabled = not ui.Enabled
        if isHours then
            getrenv()._G.SetCameraLock(not ui.Enabled)
        end
    end
end))

getgenv()._G.stuff = {
    loops = loops,
    objects = objects,
}
