print("== Inventory Menu ==")
-- InventoryMenu
-- Constants
local INVENTORY_CELL_WIDTH = 0.2
local INVENTORY_CELL_X_MARGIN = 0.04
local INVENTORY_CELL_HEIGHT = 0.1
local INVENTORY_CELL_Y_MARGIN = 0.02

local INVENTORY_COLUMNS = 3
local INVENTORY_ROWS = 4

local MENU_OPEN_POSITION = UDim2.new(0.05, 0, 0.05, 0)
local MENU_CLOSED_POSITION = UDim2.new(0.05, 0, -.9, -36)

local CLOSE_INVENTORY_MENU_BINDING = "CloseInventoryMenu"
local EXIT_INVENTORY_MENU_BINDING = "ExitInventoryMenu"

local MIN_TRANSPARENCY = 0
local MAX_TRANSPARENCY = 0.9
local DELTA = 0.5

local WAIT_INTERVAL = 0.3

-- Services
local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create Menu
local screenGui = Instance.new("ScreenGui", playerGui)

-- Onscreen equipment button
local inventoryBtn = Instance.new("TextButton", screenGui)
inventoryBtn.Name = "InventoryButton"
inventoryBtn.Text = "Inventory"
inventoryBtn.Size = UDim2.new(0, 300, 0, 75)
-- inventoryBtn.Size = UDim2.new(0, 100, 0, 25)
inventoryBtn.Font = Enum.Font.Cartoon
-- inventoryBtn.FontSize = Enum.FontSize.Size60
inventoryBtn.FontSize = Enum.FontSize.Size36
inventoryBtn.BackgroundTransparency = MIN_TRANSPARENCY + DELTA

-- Frame for the menu
local menuFrame = Instance.new("Frame", screenGui)
menuFrame.Size = UDim2.new(0.9, 0, 0.9, 0)
menuFrame.Position = MENU_CLOSED_POSITION
menuFrame.BackgroundTransparency = MIN_TRANSPARENCY + DELTA

-- Frames for the inventory grid
local inventoryFrame = Instance.new("Frame", menuFrame)
inventoryFrame.Name = "InventoryFrame"
inventoryFrame.Size = UDim2.new(0.5, 0, 1, 0)
inventoryFrame.Position = UDim2.new(0.5, 0, 0, 0)
inventoryFrame.BackgroundTransparency = MIN_TRANSPARENCY + DELTA

-- Frame for Scrolling Layout
local inventoryScroll = Instance.new("ScrollingFrame", inventoryFrame)
inventoryScroll.Size = UDim2.new(0.9, 0, 0.9, 0)
inventoryScroll.CanvasSize = UDim2.new(0.9, 0, 1.8, 0)
inventoryScroll.Position = UDim2.new(0.05, 0, 0.05, 0)
inventoryScroll.Selectable = false
inventoryScroll.ScrollBarThickness = 0
inventoryScroll.BackgroundTransparency = MIN_TRANSPARENCY + DELTA

-- Inventory
local inventoryTable = {}

-- index start from 1
local itemNames = {'WOOD', 'STONE', 'METAL', 'PLANK', 'SLAB', 'NAILS', 'FUEL', 'SMELT', 'ORE', 'CLEAR'}

local itemBgColor3 = {
    --WOOD =
    Color3.fromRGB(255, 165, 0),
    --STONE =
    Color3.fromRGB(192, 192, 192),
    --METAL =
    Color3.fromRGB(128, 128, 0),
    --PLANK =
    Color3.fromRGB(0, 128, 128),
    --SLAB =
    Color3.fromRGB(0, 255, 255),
    --NAILS =
    Color3.fromRGB(255, 0, 255),
    --FUEL =
    Color3.fromRGB(255, 165, 0),
    --SMELT =
    Color3.fromRGB(192, 192, 192),
    --ORE =
    Color3.fromRGB(128, 128, 0),
    --CLEAR =
    Color3.fromRGB(255, 255, 255)
}

-- Button Template
local itemTemplate = Instance.new("TextButton")
itemTemplate.Size = UDim2.new(INVENTORY_CELL_WIDTH, 0, INVENTORY_CELL_HEIGHT, 0)
itemTemplate.AutomaticSize = Enum.AutomaticSize.XY
itemTemplate.AutoButtonColor = false
itemTemplate.TextScaled = false
itemTemplate.BackgroundTransparency = MIN_TRANSPARENCY + DELTA
itemTemplate:SetAttribute("Qty", 0)

local function getInventoryItem(cellName)
    for idx = 1, #inventoryTable do
        local item = inventoryTable[idx]

        if cellName == item.Name then
            print("Found item: ", item.Name)
            return item
        end
    end
    print("Item: '" .. cellName .. "' not found.")
    return nil
end

-- Create cells for inventory grid
local function createInventoryItems()
    local itemIndex = 1
    local rowIdxMax = INVENTORY_ROWS - 1
    local colIdxMax = INVENTORY_COLUMNS - 1
    for y = 0, rowIdxMax do
        for x = 0, colIdxMax do
            if itemIndex > tonumber(#itemNames) then
                print("Items filled.")
                continue
            end
            
            -- create TextButton for each item
            local inventoryCell = itemTemplate:Clone()
            -- add position and name
            inventoryCell.Position = UDim2.new(INVENTORY_CELL_X_MARGIN + INVENTORY_CELL_X_MARGIN * x + INVENTORY_CELL_WIDTH * x, 0,
                INVENTORY_CELL_Y_MARGIN + INVENTORY_CELL_Y_MARGIN * y + INVENTORY_CELL_HEIGHT * y, 0)
            inventoryCell.Name = tostring(itemNames[itemIndex])
            local itemName = tostring(inventoryCell.Name)
            if (itemName == "FUEL") or (itemName == "SMELT") or (itemName == "SMELT") or (itemName == "ORE") or (itemName == "CLEAR") then
                print("Without quantity attribute item: " .. itemName)
                inventoryCell.Text = tostring(itemNames[itemIndex])
            else
                -- Items with additional Qty attribute
                inventoryCell.Text = tostring(itemNames[itemIndex]) .. "\nQty: " .. tostring(inventoryCell:GetAttribute("Qty"))
            end

            inventoryCell.BackgroundColor3 = itemBgColor3[itemIndex]
            inventoryCell.Parent = inventoryScroll

            -- add item to the inventory table
            table.insert(inventoryTable, inventoryCell)

            itemIndex += 1
        end
    end
end

-- print inventory table
local function printInventories()
    for idx = 1, #inventoryTable do
        local item = inventoryTable[idx]
        print("idx: " .. idx .. ", cell name: ", item.Name)
    end
end

-- Closes the equipment menu
local function closeInventoryMenu()
    -- Play closing animation
    menuFrame:TweenPosition(MENU_CLOSED_POSITION, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, false, function(status)

        -- When animation finished, unbind the close function and reset Gui selection
        ContextActionService:UnbindAction(CLOSE_INVENTORY_MENU_BINDING)
        GuiService.SelectedObject = nil
    end)
end

-- get inventory item from mouse click
local function getButton(objPosition)
    for idx = 1, #inventoryTable do
        local item = inventoryTable[idx]
        print("idx: " .. idx .. ", cell name: ", item.Name)
        print("objPosition: ", tostring(objPosition))

        local minX = tonumber(item.AbsolutePosition.X)
        local maxX = tonumber(item.AbsolutePosition.X) + tonumber(item.AbsoluteSize.X)
        local minY = tonumber(item.AbsolutePosition.Y)
        local maxY = tonumber(item.AbsolutePosition.Y) + tonumber(item.AbsoluteSize.Y)

        if tonumber(objPosition.X) >= minX and tonumber(objPosition.X) <= maxX then
            if tonumber(objPosition.Y) >= minY and tonumber(objPosition.Y) <= maxY then
                print("Item selected: ", item.Name)
                return item
            end
        end
    end
    print("Warning: Button not found.")
    return nil
end

-- Opens the equipment menu
local function openInventoryMenu()

    GuiService.AutoSelectGuiEnabled = false

    -- Play opening animation
    menuFrame:TweenPosition(MENU_OPEN_POSITION, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, false, function(status)

        -- When animation finished, bind closeInventoryMenu to the B button
        ContextActionService:BindAction(CLOSE_INVENTORY_MENU_BINDING, function(actionName, inputState, inputObject)
            if inputState == Enum.UserInputState.Begin then
                closeInventoryMenu()
            end
        end, false, Enum.KeyCode.B)

    end)
end

-- Moves selection from the inventory menu back to the material menu
local function exitInventoryMenu()
    ContextActionService:UnbindAction(EXIT_INVENTORY_MENU_BINDING)
    GuiService.SelectedObject = nil
end

local function onItemSelect(itemObj)
    print("Inventory selected: " .. tostring(itemObj))
end

-- Find inventory item selected and bind keyboard key 'B' for close Inventory Menu
local function onInventorySlotClicked()

    -- Bind exitInventoryMenu to B button
    ContextActionService:BindAction(EXIT_INVENTORY_MENU_BINDING, function(actionName, inputState, inputObject)
        if inputState == Enum.UserInputState.Begin then
            exitInventoryMenu()
        end
    end , false, Enum.KeyCode.B)

    -- check selected item
    if GuiService.SelectedObject then
        onItemSelect(GuiService.SelectedObject)
    else
        print("No inventory selected.")
    end
end

-- get current mouse click location when user click the inventory item
local function getMouseLocation()
    local mouseLocation = UserInputService:GetMouseLocation()
    print("Mouse Location X: " .. tostring(mouseLocation.X) .. ", Y: " .. tostring(mouseLocation.Y))
    return mouseLocation
end

-- update inventory
local function updateInventory(item1, item2)
    local qty1 = item1:GetAttribute("Qty")
    local qty2 = item2:GetAttribute("Qty")
    if qty1 > 0 then
        -- for item1
        qty1 -= 1
        print("Update " .. tostring(item1.Name) .. " quantity to " .. tostring(qty1))
        item1:SetAttribute("Qty", qty1)
        item1.Text = tostring(item1.Name) .. "\nQty: " .. tostring(item1:GetAttribute("Qty"))
        -- for item2
        qty2 += 1
        print("Update " .. tostring(item2.Name) .. " quantity to " .. tostring(qty2))
        item2:SetAttribute("Qty", qty2)
        item2.Text = tostring(item2.Name) .. "\nQty: " .. tostring(item2:GetAttribute("Qty"))
    end
end

-- get and update inventory info
local function onButtonActivated()
    local mouseLocation = getMouseLocation()
    local selectedBtn = getButton(mouseLocation)

    if selectedBtn == nil then
        -- wait(WAIT_INTERVAL)
        print("getting mouse location...")
        selectedBtn = getButton(mouseLocation)
    end

    GuiService.SelectedObject = selectedBtn

    if selectedBtn == nil then
        print("Warning: No item selected!")
    else
        
        local btnName = tostring(selectedBtn.Name)
        if (btnName == "FUEL") then
            -- for wood and plank items
            local item1 = getInventoryItem("WOOD")
            local item2 = getInventoryItem("PLANK")
            updateInventory(item1, item2)
            return
        end
        if (btnName == "SMELT") then
            -- for stone and slab items
            local item1 = getInventoryItem("STONE")
            local item2 = getInventoryItem("SLAB")
            updateInventory(item1, item2)
            return
        end
        if (btnName == "ORE") then
            -- for metal and nails items
            local item1 = getInventoryItem("METAL")
            local item2 = getInventoryItem("NAILS")
            updateInventory(item1, item2)
            return
        end
        if (btnName == "CLEAR") then
            -- reset items to zero
            for idx = 1, #inventoryTable do
                local item = inventoryTable[idx]
                print("CLEAR: " .. idx .. ", item name: ", item.Name)
                item:SetAttribute("Qty", 0)
            end
            return
        end
            
        -- 'WOOD', 'STONE', 'METAL' inventory update
        if (btnName == "WOOD") or (btnName == "STONE") or (btnName == "METAL") then
            -- add items when click item's button
            local qty = selectedBtn:GetAttribute("Qty")
            qty += 1
            print("Current quantity for " .. tostring(selectedBtn) .. ": " .. tostring(qty))
            -- Update quantity info
            selectedBtn:SetAttribute("Qty", qty)
            selectedBtn.Text = tostring(selectedBtn.Name) .. "\nQty: " .. tostring(selectedBtn:GetAttribute("Qty"))
        end
    end
end

-- create inventory and register events
local function createInventoryMenu()

    -- Add selection group for the section of the menu
    GuiService:AddSelectionParent("InventoryMenu", inventoryScroll)

    -- Input binding
    inventoryBtn.MouseButton1Click:Connect(openInventoryMenu)

    for _, child in pairs(inventoryScroll:GetChildren()) do
        print("Mouse click event for inventory: " .. tostring(child))
        child.MouseButton1Click:Connect(onInventorySlotClicked)
        child.Activated:Connect(onButtonActivated)
        --- Listen for attribute 'Quantity' change
        child:GetAttributeChangedSignal("Qty"):Connect(function()
            print("Current quantity for " .. tostring(child) .. ": " .. tostring(child:GetAttribute("Qty")))
            -- Update quantity info
            child.Text = tostring(child.Name) .. "\nQty: " .. tostring(child:GetAttribute("Qty"))
        end)
    end
end

local function main()
    createInventoryItems()
    printInventories()
    createInventoryMenu()
end

-- run lua script
main()
