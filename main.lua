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
    DisplayOrder = 999,
})

local frame = createInstance("Frame",{
    Size = UDim2.new(0.25,0,0.3,0),
    Parent = ui,
    BorderSizePixel = 0,
    BackgroundColor3 = Color3.fromRGB(23,23,23),
    BackgroundTransparency = 0,
    Position = UDim2.new(0.5,0,0.5,0),
    AnchorPoint = Vector2.new(0.5,0.5),
})
createInstance("UICorner",{Parent = frame})


local sidebarwrapperthingy = createInstance("Frame",{
    Parent = frame,
    Size = UDim2.new(0.36,0, 0.95,0),
    Position = UDim2.new(0,7, 0,7),
    BorderSizePixel = 0,
    BackgroundTransparency = 0.6,
    BackgroundColor3 = Color3.fromRGB(0,0,0),
})
local sidebar = createInstance("ScrollingFrame",{
    Parent = sidebarwrapperthingy,
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
createInstance("UICorner",{Parent = sidebarwrapperthingy})

local uill = createInstance("UIListLayout",{
    Parent = sidebar,
    SortOrder = Enum.SortOrder.LayoutOrder,
})


local explorer = createInstance("Frame",{
    Parent = frame,
    AnchorPoint = Vector2.new(1,0),
    Size = UDim2.new(0.6,0,0.95,0),
    Position = UDim2.new(1,-7,0,7),
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
        Parent = sidebar,
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

generate = function(path)
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
            generate(newPath)
        end)
    end
    local searchBox = createInstance("TextBox",{
        Parent = sidebar,
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
                print(newPath)
                generate(newPath)
            elseif typeof(value) == "function" then
                for _,instance in explorerInstances do
                    instance:Destroy()
                end
                explorerInstances = {}

                local instance1 = createInstance("TextButton",{
                    Parent = explorer,
                    Text = `call {index}`,
                    Size = UDim2.new(1,0,0.1,0),
                })

                local instance2 = createInstance("TextBox",{
                    Parent = explorer,
                    Text = ``,
                    PlaceholderText = "iggle, gaggle, 1, true",
                    PlaceholderColor3 = Color3.fromRGB(95, 95, 95),
                    Position = UDim2.new(0,0,0.1,0),
                    Size = UDim2.new(1,0,0.1,0),
                })

                instance1.MouseButton1Click:Connect(function()
                    local args = string.split(instance2.Text,", ")
                    local newargs = {}
                    for argIndex,argValue in args do
                        newargs[argIndex] = figureOutVariable(argValue)
                    end
                    value(table.unpack(newargs))
                end)

                table.insert(explorerInstances,instance1)
                table.insert(explorerInstances,instance2)
            else
                for _,instance in explorerInstances do
                    instance:Destroy()
                end
                explorerInstances = {}
                
                local instance3432 = createInstance("TextLabel",{
                    Parent = explorer,
                    Text = `{index} [{typeof(value)}]`,
                    Size = UDim2.new(1,0,0.1,0),
                })

                local instance0 = createInstance("TextLabel",{
                    Parent = explorer,
                    Text = `{tostring(value)}`,
                    TextColor3 = Color3.fromRGB(255,255,255),
                    Size = UDim2.new(1,0,0.1,0),
                    Position = UDim2.new(0,0,0.1,0),
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    BackgroundTransparency = 0.6,
                })

                local instance = createInstance("TextBox",{
                    Parent = explorer,
                    Text = ``,
                    PlaceholderText = "Arguments",
                    PlaceholderColor3 = Color3.fromRGB(95,95,95),
                    Position = UDim2.new(0,0, 0.25,0),
                    Size = UDim2.new(1,0, 0.1,0),
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    BackgroundTransparency = 0.6,
                })

                local instance2 = createInstance("TextButton",{
                    Parent = explorer,
                    Text = `Set`,
                    Position = UDim2.new(0,0, 0.35,0),
                    Size = UDim2.new(1,0, 0.1,0),
                    BackgroundColor3 = Color3.fromRGB(0,0,0),
                    BackgroundTransparency = 0.6,
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
end

generate()

local isHours = game.PlaceId == 5732973455
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
