

![alt MenuUI](https://github.com/fruitmonkey01/RobloxInventoryMenuLuaScript/blob/main/MenuGUI.png)

<br />

![alt TextButtonProperties](https://github.com/fruitmonkey01/RobloxInventoryMenuLuaScript/blob/main/TextButtonProperties.png)

<br />

![alt InventoryMenuScript](https://github.com/fruitmonkey01/RobloxInventoryMenuLuaScript/blob/main/InventoryMenuScript.png)

<br />

Project goal: Create Roblox Inventory Menu with Lua Script

Date: Jan 16, 2022
Environment: Mac OSX with Roblox Studio
Local Script location: StarterPlayer -> StarterPlayerScripts -> InventoryMenuLocalScript

Lua Script with following functions:
1. Display information to the player:
    PlayerGui -> ScreenGui -> InventoryButton (TextButton)
    To open the InventoryMenu by clicking the TextButton
    To close the Menu by pressinging the keyboard key: 'B'
    
2. Display Material (Recipe) TextButton items with layout:
    PlayerGui -> ScreenGui -> MenuFrame -> InventoryFrame 
    -> ScrollingFrame -> TextButton(s)
    (Please see TextButtonProperties.png image)
    TextButtons available: 
    local itemNames = {'WOOD', 'STONE', 'METAL', 'PLANK', 'SLAB', 'NAILS', 'FUEL', 'SMELT', 'ORE', 'CLEAR'}
    
3. Services used:
    3.1 GuiService to create GUI objects.
    3.2 ContextActionService to bind and unbind key to close inveontory Menu.
    3.3 UserInputService to get the TextButton user used mouse to select and update the inventory information
    
4. Used TextButton Template to create items and properties and store each item in the inventory table.

5. Rules for Materials (Recipes / Items) Quantity update:
    5.1) Raw materials: 'WOOD', 'STONE', 'METAL' quantity increment by 1 when click it's TextButton.
    5.2) Furnace: Used Raw materials with  'FUEL', 'SMELT', 'ORE' to refine and generate 'PLANK', 'SLAB', 'NAILS'
    For example: 
    When click "FUEL" button, the Raw material "WOOD" quantity will decrese by 1, and the product "PLANK" quantity will increase by 1.
    When click "SMELT" button, the Raw material "STONE" quantity will decrese by 1, and the product "SLAB" quantity will increase by 1.    
    When click "ORE" button, the Raw material "METAL" quantity will decrese by 1, and the product "NAILS" quantity will increase by 1.    
    5.3) Click "CLEAR" button, all quantities will set to 0.
    
    
