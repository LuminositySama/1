local a=require(game:GetService("StarterPlayer").StarterPlayerScripts["TSFL Client"].Modules.BallNetworking)local b=require(game:GetService("Players").LocalPlayer.PlayerScripts["TSFL Client"].Modules.BallNetworking)hookfunction(b.IsDistanceTooBig,function()return false end)hookfunction(a.IsDistanceTooBig,function()return false end)hookfunction(b.VerifyHit,function()return false end)hookfunction(a.VerifyHit,function()return false end)hookfunction(b.IsBallBoundingHitbox,function()return true end)hookfunction(a.IsBallBoundingHitbox,function()return true end)

local function c(d)return string.match(d,"^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$")~=nil end
local function e()local f=workspace:FindFirstChild("Balls")if not f then return{}end local g={}for _,h in ipairs(f:GetDescendants())do if h:IsA("BasePart")and c(h.Name)then table.insert(g,h)end end return g end

local i=game.Players.LocalPlayer;local j=game:GetService("RunService")local k=5;local l=100000;local m=true

local n=loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()local o=n:Load("Akram Reach Controller","Default")local p=n.newTab("Reach Settings","Default")

p.newToggle("Enable Reach","",m,function(q)m=q end)p.newSlider("Reach Distance","",l,false,function(r)k=math.floor(r)end)p.newKeybind("Toggle UI","",Enum.KeyCode.RightControl,function()o:Toggle()end)

j.RenderStepped:Connect(function()if not m then return end local s=i.Character;if not s then return end local t={"Right Leg","Left Leg","Torso","Head"}local u=e()for _,v in ipairs(t)do local w=s:FindFirstChild(v)if w then for _,x in ipairs(w:GetDescendants())do if x:IsA("TouchTransmitter")or x.Name=="TouchInterest"then for _,y in ipairs(u)do if(y.Position-w.Position).Magnitude<=k then pcall(function()firetouchinterest(y,x.Parent,0)firetouchinterest(y,x.Parent,1)end)end end end end end end end)
