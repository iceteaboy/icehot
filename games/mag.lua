local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Maxgat5/UiLib/main/lua')))()
local w = library:CreateWindow("Magnet Masters")
local b = w:CreateFolder("AutoFarm")
local f = w:CreateFolder("AutoBuy")
local e = w:CreateFolder("use codes anti afk")
local u = w:CreateFolder("Credits")
Eggs = {}
SelectedEgg = "Basic Egg"
for i,v in pairs(game:GetService("Workspace").Eggs:GetChildren()) do
    if v.ClassName == "Model" then
        if v:FindFirstChild("Egg") then
            table.insert(Eggs,v.Name)
        end
    end
end
Rebirths = {}
SelectedRebirth = 1
local a = require(game:GetService("ReplicatedStorage").Modules.Data.RebirthData)
for i,v in pairs(a.Amounts) do
    table.insert(Rebirths,v)
end

b:Toggle("AutoCollectCoins",function(bool)
    shared.toggle = bool
    AutoCollectCoins = bool
end)

f:Toggle("Magnets",function(bool)
    shared.toggle = bool
    Magnets = bool
end)

f:Dropdown("Select Egg",Eggs,true,function(a)
    SelectedEgg = a
end)
 
f:Toggle("Egg",function(bool)
    shared.toggle = bool
    AutoEgg = bool
end)

f:Dropdown("Select Rebirth",Rebirths,true,function(a)
    SelectedRebirth = a
end)
 
f:Toggle("Rebirth",function(bool)
    shared.toggle = bool
    Rebirth = bool
end)

f:Toggle("Upgrades",function(bool)
    shared.toggle = bool
    Upgrades = bool
end)

e:Toggle("AntiAfk",function(bool)
    shared.toggle = bool
    AntiAfk = bool
end)

e:Button("Use All Codes",function()
    for i,v in pairs(game:GetService("Workspace").CommunityGoals.Gui.Main.Items.Game.Main:GetDescendants()) do
        if v.ClassName == "TextLabel" then
            a = string.gsub(v.Text,'"',"")
            game:GetService("ReplicatedStorage").Remote:FireServer("Code",tostring(a))
            wait(10)
        end
    end
    local a = require(game:GetService("ReplicatedStorage").Modules.Data.StarCodes)
    for i,v in pairs(a) do
        game:GetService("ReplicatedStorage").Remote:FireServer("Code",tostring(v))
        wait(10)
    end
end)

--Credits
u:Button("Icedtea",function()
end)


if game:GetService("CoreGui"):FindFirstChild("PurchasePromptApp") then
    game:GetService("CoreGui").PurchasePromptApp:Destroy()
end
    
game:GetService('RunService').Stepped:connect(function()
    spawn(function()
        if AntiAfk == true then
            local bb=game:service'VirtualUser'
            bb:CaptureController()
            bb:ClickButton2(Vector2.new())
        end
    end)
end)

spawn(function()
    while wait() do
        if AutoCollectCoins == true then
            for i,v in pairs(game:GetService("Workspace").Coins:GetChildren()) do
                for i,v1 in pairs(v.Coins[game.Players.LocalPlayer.Name]:GetChildren()) do                
                    pcall(function()
                        local tool = game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                        v1.Hitbox.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,0,0)
                    end)
                end
            end
        end
    end
end)

while wait() do
    if Magnets == true then
        for i,v in pairs(game:GetService("ReplicatedStorage").Magnets:GetChildren()) do
            game:GetService("ReplicatedStorage").Remote:FireServer("Magnet","Shop","Purchase",tostring(v.Name))
        end
    end

    if AutoEgg == true then
        game:GetService("ReplicatedStorage").Remote:FireServer("Pet","Egg","Hatch",tostring(SelectedEgg),1)
    end
    
    if Rebirth == true then
        game:GetService("ReplicatedStorage").Remote:FireServer("Rebirth",tonumber(SelectedRebirth))
    end
    
    if Upgrades == true then
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.Pages.Upgrades.Main.List.Scroller:GetChildren()) do
            if v.ClassName == "Frame" then
                game:GetService("ReplicatedStorage").Remote:FireServer("Upgrades","Buy1",tostring(v.Name))
            end
        end
    end
end

