local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local MainWindow = Rayfield:CreateWindow({
   Name = "Main",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading . . .",
   LoadingSubtitle = "by Leo",
   ShowText = "KingZone", -- for mobile users to unhide Rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

   -- ScriptID = "sid_xxxxxxxxxxxx", -- Your Script ID from developer.sirius.menu — enables analytics, managed keys, and script hosting

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "KingZone Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include Discord.gg/. E.g. Discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the Discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "LeoHub",
      Subtitle = "Key System",
      Note = "Key for Leogametop", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique, as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that the system will accept, can be RAW file links (pastebin, github, etc.) or simple strings ("hello", "key22")
   }
})
Rayfield:Notify({
   Title = "LeoHub",
   Content = "Ready For Use",
   Duration = 6.5,
   Image = 4483362458,
})
local Toggle = Tab:CreateToggle({
   Name = "ESP",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
 local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local function ESP(player)
        if player == LocalPlayer then return end

        local function addESP(character)
            if character:FindFirstChild("PlayerESP") then
                return
            end

            local highlight = Instance.new("Highlight")
            highlight.Name = "PlayerESP"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = character
        end

        if player.Character then
            addESP(player.Character)
        end

        player.CharacterAdded:Connect(function(character)
            task.wait(0.2)
            addESP(character)
        end)
    end

    -- Players already in the server
    for _, player in ipairs(Players:GetPlayers()) do
        ESP(player)
    end

    -- New players joining
    Players.PlayerAdded:Connect(function(player)
        ESP(player)
    end)

end)
   end,
})
local Toggle = Tab:CreateToggle({
   Name = "AimAssist",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    local FOV = 150
    local Smoothness = 0.15

    local function GetTarget()
        local closest
        local shortest = FOV

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then

                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local head = player.Character:FindFirstChild("Head")

                if humanoid and head and humanoid.Health > 0 then
                    local pos, visible =
                        Camera:WorldToViewportPoint(head.Position)

                    if visible then
                        local center = Vector2.new(
                            Camera.ViewportSize.X / 2,
                            Camera.ViewportSize.Y / 2
                        )

                        local distance = (
                            Vector2.new(pos.X, pos.Y) - center
                        ).Magnitude

                        if distance < shortest then
                            shortest = distance
                            closest = head
                        end
                    end
                end
            end
        end

        return closest
    end

    RunService:BindToRenderStep(
        "MyAimAssist",
        Enum.RenderPriority.Camera.Value + 1,
        function()
            local target = GetTarget()

            if target then
                local goal = CFrame.lookAt(
                    Camera.CFrame.Position,
                    target.Position
                )

                Camera.CFrame = Camera.CFrame:Lerp(
                    goal,
                    Smoothness
                )
            end
        end
    )

end)
   end,
})
local Toggle = Tab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
 local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

UserInputService.JumpRequest:Connect(function()
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)
   end,
})