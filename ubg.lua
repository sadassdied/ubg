-- made by idk changed by sadasd 
warn("!Started!")

local Enabled = true

local set_thread_identity = (setthreadcontext or set_thread_identity or function()
    return print("i have no skills and i need script")
end)

local Client = game.Players.LocalPlayer
local States = workspace:WaitForChild("States")
local Effect = require(game:GetService("ReplicatedStorage").Modules.EffectHelper)


local CustomVIM = {}
CustomVIM.KeyPress = function(keyCode)
    set_thread_identity(7)
    
    keypress(keyCode)
end

CustomVIM.KeyRelease = function(keyCode)
    
    keyrelease(keyCode)
    set_thread_identity(2)
end

local function keypress(keyCode)
    game:GetService("UserInputService"):InputBegan(Enum.KeyCode[keyCode], false)
end

local function keyrelease(keyCode)
    game:GetService("UserInputService"):InputEnded(Enum.KeyCode[keyCode], false)
end

local VIM = CustomVIM  

local function hold(keyCode, time)
    VIM.KeyPress(keyCode)
    wait(time)
    VIM.KeyRelease(keyCode)  
end

function get(n, s)
    return States[n.Name]:FindFirstChild(s, true).Value
end

function get_root(chr)
    return chr.HumanoidRootPart
end

function notif(str, str2)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = str,
        Text = str2,
    })
end

function dash()
    hold(Enum.KeyCode.Space, 0.1)  
end

function random()
    return math.random(15, 15) / 100
end

local waiting = {}

function waitValid(name, func)
    if not waiting[name] then
        waiting[name] = {}
    end
    table.insert(waiting[name], func)
    warn("Added Queue:", name)
end

function valid(name, ...)
    for i = 1, #waiting[name] do
        task.spawn(waiting[name][i], ...)
    end
    waiting[name] = nil
    warn("Cleared Queue:", name)
end

shared.BaseEffectFunction = shared.BaseEffectFunction or {}

for i, v in pairs(Effect) do
    shared.BaseEffectFunction[i] = shared.BaseEffectFunction[i] or v
    Effect[i] = function(d, ...)
        spawn(function() 
            if not Enabled then
                return
            end
            if type(d) == "table" and typeof(d[2]) == "Instance" then
                local Target = get(Client, "LockedOn")
                local Distance = Client:DistanceFromCharacter(get_root(d[2]).Position)

                if States[Client.Name]:FindFirstChild("Blocking", true).Value or
                not States[Client.Name]:FindFirstChild("Equipped", true).Value or
                States[Client.Name]:FindFirstChild("Punching", true).Value then
                    return
                end

                if Distance > 11.336 then
                    return
                end
                if (d[1] == "AttackTrail" or d[1] == "StartupHighlight" or d[1] == "UltimateHighlight") and d[2] ~= Client.Character and type(d[5]) == 'number' then
                    waitValid(d[2].Name, function(LightAttack)
                        local delay = d[5] * math.random(15, 15) / 100
                        local formattedResult = string.format("%.2f", delay)
                        wait(tonumber(formattedResult))
                        coroutine.wrap(dash)()
                    end)
                end
                if d[1] == "StartupHighlight" then
                    valid(d[2].Name, not (d[3] or d[4] or d[5]))
					-- Define the title and text for the notification
local title = "sadasd created this art"
local text = "im gay and dont have skills"

-- Function to send a notification
local function sendNotification()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5, -- How long the notification should be displayed (in seconds)
    })
end

-- Interval between notifications (in seconds)
local notificationInterval = 60  -- Change this to the desired interval

-- Infinite loop to send notifications at regular intervals
while true do
    sendNotification()
    wait(notificationInterval)
end

                end
            end
        end)
        return shared.BaseEffectFunction[i](d, ...)
    end
end
