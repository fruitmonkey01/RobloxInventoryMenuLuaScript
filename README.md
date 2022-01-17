

![alt MenuUI](https://github.com/fruitmonkey01/RobloxInventoryMenuLuaScript/blob/main/MenuGUI.png)

<br />

![alt TextButtonProperties](https://github.com/fruitmonkey01/RobloxInventoryMenuLuaScript/blob/main/TextButtonProperties.png)

<br />

![alt InventoryMenuScript](https://github.com/fruitmonkey01/RobloxInventoryMenuLuaScript/blob/main/InventoryMenuScript.png)

<br />

Project goal: Create Roblox Inventory Menu with Lua Script
<br />
Date: Jan 16, 2022
<br />
Environment: Mac OSX with Roblox Studio
<br />
Local Script location: StarterPlayer -> StarterPlayerScripts -> InventoryMenuLocalScript
<br />
Lua Script with following functions:
1. Display information to the player:
    <br />
    PlayerGui -> ScreenGui -> InventoryButton (TextButton)
    <br />
    To open the InventoryMenu by clicking the TextButton
    <br />
    To close the Menu by pressinging the keyboard key: 'B'
    <br />
    
2. Display Material (Recipe) TextButton items with layout:
    <br />
    PlayerGui -> ScreenGui -> MenuFrame -> InventoryFrame 
    -> ScrollingFrame -> TextButton(s)
    (Please see TextButtonProperties.png image)
    <br />
    TextButtons available: 
    <br />
    local itemNames = {'WOOD', 'STONE', 'METAL', 'PLANK', 'SLAB', 'NAILS', 'FUEL', 'SMELT', 'ORE', 'CLEAR'}
    
3. Services used:
    <br />
    3.1 GuiService: create GUI objects.
    <br />
    3.2 ContextActionService: bind and unbind key to close inveontory Menu.
    <br />
    3.3 UserInputService: get the mouse click location to select the TextButton, and show the updated inventory information for the item clicked.
    <br />
4. Used TextButton Template to create items and properties and store each item in the inventory table.
    <br />
5. Rules for Materials (Recipes / Items) Quantity update:
    <br />
    5.1) Raw materials: 'WOOD', 'STONE', 'METAL' quantity increment by 1 when click it's TextButton.
    <br />
    5.2) Furnace: Used Raw materials with  'FUEL', 'SMELT', 'ORE' to refine and generate 'PLANK', 'SLAB', 'NAILS'
    <br />
    For example: 
    <br />
    When click "FUEL" button, the Raw material "WOOD" quantity will decrese by 1, and the product "PLANK" quantity will increase by 1.
    <br />
    When click "SMELT" button, the Raw material "STONE" quantity will decrese by 1, and the product "SLAB" quantity will increase by 1.    
    <br />
    When click "ORE" button, the Raw material "METAL" quantity will decrese by 1, and the product "NAILS" quantity will increase by 1.    
    <br />
    5.3) Click "CLEAR" button, all quantities will set to 0.
    
    
