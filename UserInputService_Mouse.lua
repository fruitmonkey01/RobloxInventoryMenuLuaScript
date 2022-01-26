-- Topic: How to Display an Items Name with Mouse Hover - Roblox Studio Tutorial
-- Reference Source on the YouTube: https://www.youtube.com/watch?v=_qAcPiFAkm0

local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local Part = Instance.new("Part")
Part.Parent = game.Workspace
Part.Name = "Part"
-- local Part_Object = game.Workspace:waitForChild("Part")

UIS.inputChanged:Connect(function(input)
	-- check if mouse points to an object
	if mouse.Target then 
		print("mouse.Target.Name = [" .. tostring(mouse.Target.Name) .. "]")
		-- Delete the Part object 
		if mouse.Target.Name == Part.Name then
			print("Delete " .. tostring(Part.Name))
			Part:Destroy()
		end	
			
	end
end)
