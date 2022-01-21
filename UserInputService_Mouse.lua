 -- Topic: How to Display an Items Name with Mouse Hover - Roblox Studio Tutorial
-- Reference Source on the YouTube: https://www.youtube.com/watch?v=_qAcPiFAkm0

local UIS = game:GetService("UserInputService")
loca player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local ITT = Instance.new("InvisibleTouchTarget")
ITT.Parent = game.Workspace

-- local ITT_Object = game.Workspace:waitForChild("InvisibleTouchTarget")

UIS.inputChanged:Connect(function(input)
	-- check if mouse points to an object
	if mouse.Target then 
		if mouse.Target:FindFirstChild('InvisibleTouchTarget') then
			-- Option 1: Disable the ITT object
			if mouse.Target.Name == ITT.Name then
				ITT.Enabled = false
				print("ITT Disabled!")
			end
			-- Option 2: Delete the ITT object 
			if mouse.Target.Name == ITT.Name then
				ITT:Destroy()
				print("ITT Deleted!")
			end	
		else
			-- print something else
			print("mouse.Target.Name" .. tostring(mouse.Target.Name))
		end
	end
end)
	
