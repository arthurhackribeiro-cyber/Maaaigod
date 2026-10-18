if not game:IsLoaded() then game.Loaded:Wait() end
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Character, Humanoid, RootPart

local LANGUAGES = {
	{ code = "en", flag = "🇺🇸" }, { code = "pt-br", flag = "🇧🇷" }, { code = "pt-pt", flag = "🇵🇹" },
	{ code = "ru", flag = "🇷🇺" }, { code = "es", flag = "🇪🇸" }, { code = "fr", flag = "🇫🇷" },
}
local I18N = {
	["en"] = { config = "SETTINGS", lang_sec = "LANGUAGE", btn_sec = "BUTTONS", on = "ON", off = "OFF", drag = "Drag Buttons", transparency = "Transparency", crosshair = "Crosshair", drones = "Drones", r6 = "R6 Mode", symbiote = "Symbiote Mode", keep_orig = "Keep Colors", xray_btn = "Xray Button", hud = "HUD", telemetry = "Telemetry", credit = "Credit", hide = "Hide Buttons", trails = "Hand Trails", web_arm = "WEB ARM", left_only = "LEFT: ON", both_arms = "BOTH: ON", left_off = "LEFT: OFF", both_off = "BOTH: OFF", swing_speed = "Swing Speed", restore = "Restore", size = "Size", save_pos = "SAVE POSITIONS", reset_pos = "RESET POSITIONS", close = "CLOSE HUB", wall_climb = "WALL CLIMB BUTTON?", web_wings = "WEB WINGS?", wing_speed = "Wing Speed", emote_toggle = "ENABLE EMOTE?" },
	["pt-br"] = { config = "CONFIGURACOES", lang_sec = "IDIOMA", btn_sec = "BOTOES", on = "LIGADO", off = "DESLIGADO", drag = "Arrastar Botoes", transparency = "Transparencia", crosshair = "Mira", drones = "Drones", r6 = "Modo R6", symbiote = "Modo Simbionte", keep_orig = "Manter Cores", xray_btn = "Botao Xray", hud = "HUD", telemetry = "Telemetria", credit = "Credito", hide = "Ocultar Botoes", trails = "Trilhas Maos", web_arm = "BRACO DA TEIA", left_only = "ESQ: LIGADO", both_arms = "AMBOS: LIGADO", left_off = "ESQ: DESLIGADO", both_off = "AMBOS: DESLIGADO", swing_speed = "Velocidade Balanco", restore = "Restaurar", size = "Tamanho", save_pos = "SALVAR POSICOES", reset_pos = "RESETAR POSICOES", close = "FECHAR HUB", wall_climb = "BOTAO WALL CLIMB?", web_wings = "ATIVAR ASAS?", wing_speed = "Velocidade Voo", emote_toggle = "ATIVAR EMOTE?" },
	["pt-pt"] = { config = "DEFINICOES", lang_sec = "IDIOMA", btn_sec = "BOTOES", on = "LIGADO", off = "DESLIGADO", drag = "Arrastar", transparency = "Transparencia", crosshair = "Mira", drones = "Drones", r6 = "Modo R6", symbiote = "Simbionte", keep_orig = "Manter Cores", xray_btn = "Xray", hud = "HUD", telemetry = "Telemetria", credit = "Credito", hide = "Ocultar", trails = "Rastos", web_arm = "BRACO TEIA", left_only = "ESQ: LIGADO", both_arms = "AMBOS: LIGADO", left_off = "ESQ: DESLIGADO", both_off = "AMBOS: DESLIGADO", swing_speed = "Velocidade", restore = "Restaurar", size = "Tamanho", save_pos = "GUARDAR", reset_pos = "REPOR", close = "FECHAR", wall_climb = "BOTAO WALL CLIMB?", web_wings = "ASAS?", wing_speed = "Velocidade Voo", emote_toggle = "ATIVAR EMOTE?" },
	["ru"] = { config = "NASTROYKI", lang_sec = "YAZYK", btn_sec = "KNOPKI", on = "VKL", off = "VYKL", drag = "Perek", transparency = "Proz", crosshair = "Pricel", drones = "Drony", r6 = "Rezhim R6", symbiote = "Simbiot", keep_orig = "Sohranit", xray_btn = "Xray", hud = "HUD", telemetry = "Telemetriya", credit = "Avtor", hide = "Skryt", trails = "Sledy", web_arm = "RUKA", left_only = "LEVAYA: VKL", both_arms = "OBE: VKL", left_off = "LEVAYA: VYKL", both_off = "OBE: VYKL", swing_speed = "Skorost", restore = "Sbros", size = "Razmer", save_pos = "SOHRANIT", reset_pos = "SBROSIT", close = "ZAKRYT", wall_climb = "LAZANIE?", web_wings = "KRYLYA?", wing_speed = "Skorost", emote_toggle = "EMOCIYA?" },
	["es"] = { config = "AJUSTES", lang_sec = "IDIOMA", btn_sec = "BOTONES", on = "ACTIVADO", off = "DESACTIVADO", drag = "Arrastrar", transparency = "Transparencia", crosshair = "Mira", drones = "Drones", r6 = "Modo R6", symbiote = "Simbionte", keep_orig = "Mantener Colores", xray_btn = "Xray", hud = "HUD", telemetry = "Telemetria", credit = "Credito", hide = "Ocultar", trails = "Estelas", web_arm = "BRAZO TELARANA", left_only = "IZQ: ON", both_arms = "AMBOS: ON", left_off = "IZQ: OFF", both_off = "AMBOS: OFF", swing_speed = "Velocidad", restore = "Restaurar", size = "Tamano", save_pos = "GUARDAR", reset_pos = "REINICIAR", close = "CERRAR", wall_climb = "BOTON ESCALADA?", web_wings = "ASAS?", wing_speed = "Velocidad", emote_toggle = "EMOTE?" },
	["fr"] = { config = "PARAMETRES", lang_sec = "LANGUE", btn_sec = "BOUTONS", on = "ACTIVE", off = "DESACTIVE", drag = "Glisser", transparency = "Transparence", crosshair = "Viseur", drones = "Drones", r6 = "Mode R6", symbiote = "Symbiote", keep_orig = "Garder Couleurs", xray_btn = "Xray", hud = "HUD", telemetry = "Telemetrie", credit = "Credit", hide = "Masquer", trails = "Trainees", web_arm = "BRAS", left_only = "GAUCHE: ON", both_arms = "DEUX: ON", left_off = "GAUCHE: OFF", both_off = "DEUX: OFF", swing_speed = "Vitesse", restore = "Restaurer", size = "Taille", save_pos = "SAUVEGARDER", reset_pos = "REINITIALISER", close = "FERMER", wall_climb = "ESCALADE?", web_wings = "AILES?", wing_speed = "Vitesse", emote_toggle = "EMOTE?" },
}

local ORIG_CYAN = Color3.fromRGB(80, 225, 255)
local ORIG_RED = Color3.fromRGB(225, 30, 45)
local ORIG_DARK = Color3.fromRGB(15, 18, 24)
local ORIG_FAINT = Color3.fromRGB(150, 220, 230)
local SYM_WHITE = Color3.fromRGB(245, 245, 245)
local SYM_BLACK = Color3.fromRGB(15, 15, 15)
local SYM_GRAY = Color3.fromRGB(160, 160, 160)
local SYM_BG = Color3.fromRGB(10, 10, 10)
local CYAN = ORIG_CYAN
local RED = ORIG_RED
local DARK = ORIG_DARK
local FAINT = ORIG_FAINT

local State = {
	IsSystemOnline = true, WebShootersEnabled = true, CanDoubleJump = false, JumpCharged = 0, IsCharging = false, TargetPos = nil, CurrentWeb = nil, SwingConstraint = nil, RopeAttachmentChar = nil, RopeAttachmentAnchor = nil, CurrentWeb2 = nil, IsSwinging = false, ShiftLockEnabled = false, ButtonScale = 1, EspEnabled = true, XrayEnabled = false, XrayButtonVisible = false, SymbioteEnabled = false, SymbioteKeepOrigButtons = false, TrailsEnabled = true, DraggableButtons = false, ButtonsTransparent = false, CrosshairEnabled = true, MenuVisible = true, HUDEnabled = true, TelemetryEnabled = true, CreditVisible = true, HideButtons = false, R6Mode = false, EmoteEnabled = false,
	SwingWebMode = "Right", SwingSpeed = 230, DefaultSwingSpeed = 230, MaxSwingSpeed = 3000,
	IsSlingshotting = false, SlingshotCharge = 0, SlingFolder1 = nil, SlingFolder2 = nil, SlingAnchor1 = nil, SlingAnchor2 = nil, SlingIKTarget1 = nil, SlingIKTarget2 = nil, SlingR6ForwardAtt = nil,
	RopeLength = 0, Parachuting = false, ParachuteFolder = nil, ParachuteAttachment = nil, ParachuteForce = nil,
	DronesEnabled = false, DroneActive = false, Language = "pt-br", WallClimbEnabled = false,
	WebWingsEnabled = false, IsGliding = false, WingSpeed = 55, DefaultWingSpeed = 55,
}

local function T(k) local tbl = I18N[State.Language] or I18N["en"] return tbl[k] or I18N["en"][k] or k end
local SAVE_FILE = "dark_spiderman_cfg.json"
local function SafeWrite(t) pcall(function() if writefile then writefile(SAVE_FILE, HttpService:JSONEncode(t)) end end) end
local function SafeRead() local d = nil pcall(function() if isfile and readfile and isfile(SAVE_FILE) then local ok, dec = pcall(function() return HttpService:JSONDecode(readfile(SAVE_FILE)) end) if ok then d = dec end end end) return d end
local SavedData = SafeRead()

if SavedData then
	for _, k in ipairs({"Language","ButtonScale","EspEnabled","XrayButtonVisible","DronesEnabled","SymbioteEnabled","SymbioteKeepOrigButtons","TrailsEnabled","DraggableButtons","ButtonsTransparent","CrosshairEnabled","HUDEnabled","TelemetryEnabled","CreditVisible","HideButtons","R6Mode","SwingWebMode","SwingSpeed","WallClimbEnabled", "WebWingsEnabled", "WingSpeed", "EmoteEnabled"}) do
		if SavedData[k] ~= nil then State[k] = SavedData[k] end
	end
end

local SPIDER_SWING_IMAGE_ID = "rbxthumb://type=Asset&id=82924521279083&w=420&h=420"
local SPIDER_ZIP_IMAGE_ID = "rbxthumb://type=Asset&id=87073413086176&w=420&h=420"
local SPIDER_SLING_IMAGE_ID = "rbxthumb://type=Asset&id=138776482480981&w=420&h=420"
local SPIDER_PARACHUTE_IMAGE_ID = "rbxthumb://type=Asset&id=77637615880451&w=420&h=420"
local SPIDER_LEAP_IMAGE_ID = "rbxthumb://type=Asset&id=102203592250663&w=420&h=420"
local SPIDER_ESP_IMAGE_ID = "rbxthumb://type=Asset&id=127129215341362&w=420&h=420"
local SPIDER_DRONE_IMAGE_ID = "rbxthumb://type=Asset&id=123245558177566&w=420&h=420"
local WALL_CLIMB_ICON = "rbxassetid://76038791676557"
local CLIMB_ANIM = "rbxassetid://507765644"
local WEB_WING_ICON = "rbxassetid://126070453599788"
local WEB_WING_SOUND = "rbxassetid://93035214379043"
local WEB_TEXTURE = "rbxassetid://15000399146"
local EMOTE_ICON = "rbxassetid://106605923962819"
local HANG_ANIM = "rbxassetid://125903067740797"

local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local SWING_SOUND = "rbxassetid://1284846268"
local ZIP_SOUND = "rbxassetid://9084017080"
local ESP_SOUND = "rbxassetid://3950015905"
local SWING_ANIM = "rbxassetid://507767968"

local ikList = {} local r6ArmAims = {} local swingTrack = nil local gripAtt = nil local espSoundInstance = nil
local climbing = false local climbEnabled = false local climbConn = nil local climbTrack = nil local climbVelocity = nil local climbAlign = nil local climbAttachment = nil local wallClimbBtnRef = nil local wallClimbStrokeRef = nil local wingBtnRef = nil local emoteBtnRef = nil
local wingObjects = {} local wingIK = {} local wingRightHip = nil local wingLeftHip = nil local wingRightHipOrig = nil local wingLeftHipOrig = nil local wingHeadLook = nil local wingSound = nil local wingAlign = nil local wingAttachment = nil local wingConn = nil
local hanging = false local hangObjects = {} local hangTrack = nil
local hangRenderConn = nil local hangWeb1, hangWeb2 local attCeiling, attArm, attLeg
local guiMain local ChargeFill local ChargeFillGradient local customCursor local telemetryLabel local topBarRef = nil local titleLabelRef, subLabelRef, meterLabelRef
local lensEdges = {} local cornerBrackets = {} local scanLines = {} local dialSpokes = {} local dialCoreRef, dialLabelRef local cursorTicks = {}
local ExecuteWebZip, PerformWebSwingBegin, PerformWebSwingEnd local PerformLeapBegin, PerformLeapEnd, PerformSlingshotToggle local ToggleShootersAction, ToggleShiftLockAction local OpenParachute, CloseParachute, ToggleParachute local ApplySymbioteVisuals local StartWebWings, StopWebWings local StartHang, StopHang
local mobileHolder, mobileScale, crosshairFrame local leapBarContainer, leapBarFill local allButtonsList = {} local swingSpeedFrame, swingSpeedBar, swingSpeedKnob, swingSpeedLabel, restoreSpeedBtn local wingSpeedFrame, wingSpeedBar, wingSpeedKnob, wingSpeedLabel, restoreWingSpeedBtn
local configPanelRef = nil local xrayBtnRef = nil local xrayOriginalData = {} local configBtnRef = nil local buttonRefs = {}
local XRAY_ICON = "XRAY" local GEAR_ICON = "CFG" local PLAY_ICON = ">"

local droneActive = false local flashlightActive = false local droneSpeed, droneFov, vigIntensity = 65, 75, 0.65 local droneCurrentVelocity = Vector3.new(0,0,0) local dronePos = Camera.CFrame.Position local camRot = Vector2.new(0, 0) local moveVec = Vector3.new(0, 0, 0) local isInteractingUI = false local tiltAngle = 0 local lastRot = Vector2.new(0,0) local activeButtons = {} local startTime = tick()
local DroneGui, DroneBlur, DroneOverlay, DroneControls, DroneMenu local DroneButton, DroneMenuButton local LightModel, CoreLight, RingLight, LightBtn local timeStatus, dateStamp, fCounter local vigGradients = {}

local function IsSym() return State.SymbioteEnabled end
local function GetWebColor() if IsSym() then return Color3.fromRGB(10,10,10) end return Color3.new(1,1,1) end
local function GetTrailColor() if IsSym() then return Color3.fromRGB(0,0,0) end return Color3.new(1,1,1) end

local function AddSymbioteSmoke(part)
	if not part or not IsSym() then return end
	if part:FindFirstChild("SymbioteSmoke") then return end
	local smoke = Instance.new("ParticleEmitter")
	smoke.Name = "SymbioteSmoke" smoke.Texture = "rbxasset://textures/particles/smoke_main.dds"
	smoke.Color = ColorSequence.new(Color3.fromRGB(5,5,5))
	smoke.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(0.3,0.55),NumberSequenceKeypoint.new(1,0)})
	smoke.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.15,0.3),NumberSequenceKeypoint.new(1,1)})
	smoke.Lifetime = NumberRange.new(0.35,0.7) smoke.Rate = 20; smoke.Speed = NumberRange.new(0.15,0.5)
	smoke.SpreadAngle = Vector2.new(180,180); smoke.LightEmission = 0
	smoke.LightInfluence = 1; smoke.Parent = part
end
local function RemoveSymbioteSmoke(part) if not part then return end local s = part:FindFirstChild("SymbioteSmoke") if s then s:Destroy() end end
local function UpdateTrailsColor() if not Character then return end local color = GetTrailColor() for _, d in ipairs(Character:GetDescendants()) do if d:IsA("Trail") and d.Name == "SpiderHandTrail" then d.Color = ColorSequence.new(color) end end end
local function UpdateAllWebs() for _, obj in ipairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and (obj.Name == "CylinderWebPart" or obj.Name == "ParachuteWeb" or obj.Name == "ParachuteCenter") then obj.Color = GetWebColor() if IsSym() then AddSymbioteSmoke(obj) else RemoveSymbioteSmoke(obj) end end end end

local function SaveAllPositions()
	if not SavedData then SavedData = {} end
	local positions = {}
	for key, btn in pairs(buttonRefs) do if btn and btn.Parent then local p = btn.Position positions[key] = {xs=p.X.Scale, xo=p.X.Offset, ys=p.Y.Scale, yo=p.Y.Offset} end end
	SavedData.positions = positions SavedData.Language = State.Language SavedData.ButtonScale = State.ButtonScale SavedData.EspEnabled = State.EspEnabled SavedData.XrayButtonVisible = State.XrayButtonVisible SavedData.DronesEnabled = State.DronesEnabled SavedData.SymbioteEnabled = State.SymbioteEnabled SavedData.SymbioteKeepOrigButtons = State.SymbioteKeepOrigButtons SavedData.TrailsEnabled = State.TrailsEnabled SavedData.DraggableButtons = State.DraggableButtons SavedData.ButtonsTransparent = State.ButtonsTransparent SavedData.CrosshairEnabled = State.CrosshairEnabled SavedData.HUDEnabled = State.HUDEnabled SavedData.TelemetryEnabled = State.TelemetryEnabled SavedData.CreditVisible = State.CreditVisible SavedData.HideButtons = State.HideButtons SavedData.R6Mode = State.R6Mode SavedData.SwingWebMode = State.SwingWebMode SavedData.SwingSpeed = State.SwingSpeed SavedData.WallClimbEnabled = State.WallClimbEnabled SavedData.WebWingsEnabled = State.WebWingsEnabled SavedData.WingSpeed = State.WingSpeed SavedData.EmoteEnabled = State.EmoteEnabled SafeWrite(SavedData)
end

local function ApplySavedPositions() if not SavedData or not SavedData.positions then return end for key, pos in pairs(SavedData.positions) do local btn = buttonRefs[key] if btn and btn.Parent then btn.Position = UDim2.new(pos.xs, pos.xo, pos.ys, pos.yo) end end end
local function ResetPositions() for key, btn in pairs(buttonRefs) do local init = btn:GetAttribute("InitialPos") if init then btn.Position = init end end if SavedData then SavedData.positions = nil; SafeWrite(SavedData) end end

local function IsValidHit(result) if not result or not result.Instance then return false end local part = result.Instance if not part:IsA("BasePart") then return true end if part.Transparency >= 0.99 then return false end if part.CanCollide == false and part.CanQuery == false then return false end if part.CanCollide == false then return false end return true end
local function SmartRaycast(origin, direction, rp, maxSteps) maxSteps = maxSteps or 30 local hit = workspace:Raycast(origin, direction, rp) local steps = 0 while hit and not IsValidHit(hit) and steps < maxSteps do steps += 1 origin = hit.Position + direction.Unit * 0.1 hit = workspace:Raycast(origin, direction, rp) end return hit end

local function getHand(char, side) if side == "Right" then return char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm") end return char:FindFirstChild("LeftHand") or char:FindFirstChild("Left Arm") end
local function getArmRoot(char, side) if side == "Right" then return char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") end return char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") end
local function findMotor(char, name) local motor = char:FindFirstChild(name, true) if motor and motor:IsA("Motor6D") then return motor end return nil end
local function setMotor(char, name, cf) local motor = findMotor(char, name) if motor then motor.Transform = cf end end
local function poseWingArms(char) setMotor(char, "RightShoulder", CFrame.Angles(math.rad(-10), math.rad(15), math.rad(78))) setMotor(char, "LeftShoulder", CFrame.Angles(math.rad(-10), math.rad(-15), math.rad(-78))) setMotor(char, "RightElbow", CFrame.Angles(math.rad(8), 0, 0)) setMotor(char, "LeftElbow", CFrame.Angles(math.rad(8), 0, 0)) end

local function clearIK() for _, ik in ipairs(ikList) do if ik and ik.Parent then ik:Destroy() end end ikList = {}; r6ArmAims = {} if Character then local torso = Character:FindFirstChild("Torso") if torso then local rSh = torso:FindFirstChild("Right Shoulder") local lSh = torso:FindFirstChild("Left Shoulder") if rSh then rSh.Transform = CFrame.new() end if lSh then lSh.Transform = CFrame.new() end end end end
local function playSound(parent, id, looped) local snd = Instance.new("Sound") snd.SoundId = id; snd.Volume = 2; snd.Looped = looped or false snd.Parent = parent or RootPart or workspace snd:Play() if not looped then Debris:AddItem(snd, 2.5) end return snd end

local function UpdateR6Arms() if not State.R6Mode or not Character then return end local torso = Character:FindFirstChild("Torso") if not torso then return end for _, side in ipairs({"Right","Left"}) do local motor = torso:FindFirstChild(side == "Right" and "Right Shoulder" or "Left Shoulder") if motor then local att = r6ArmAims[side] if att and att.Parent then local shoulderWorldPos = (torso.CFrame * motor.C0).Position local dir = att.WorldPosition - shoulderWorldPos if dir.Magnitude > 0.05 then local dirUnit = dir.Unit local upRef = Vector3.new(0,1,0) if math.abs(dirUnit:Dot(upRef)) > 0.99 then upRef = Vector3.new(0,0,1) end local desiredArmCF = CFrame.lookAt(shoulderWorldPos, shoulderWorldPos + dirUnit, upRef) * CFrame.Angles(math.pi/2,0,0) motor.Transform = (torso.CFrame * motor.C0):Inverse() * desiredArmCF * motor.C1 else motor.Transform = CFrame.new() end else motor.Transform = CFrame.new() end end end end
local function attachArm(char, hum, side, targetAtt) if State.R6Mode then if targetAtt then r6ArmAims[side] = targetAtt end return end local hand = getHand(char, side) local root = getArmRoot(char, side) if not hand or not root or not targetAtt then return end local ik = Instance.new("IKControl") ik.Name = "WebArmIK_" .. side ik.Type = Enum.IKControlType.Position ik.EndEffector = hand; ik.ChainRoot = root ik.Target = targetAtt; ik.Weight = 1; ik.SmoothTime = 0.15 ik.Parent = hum table.insert(ikList, ik) end
local function getAnimator(hum) local a = hum:FindFirstChildOfClass("Animator") if not a then a = Instance.new("Animator"); a.Parent = hum end return a end

local function PlayWebShootSound(parent) pcall(function() local s = Instance.new("Sound") s.SoundId = "rbxassetid://4919529864"; s.Volume = 1 s.Parent = parent or RootPart or workspace; s:Play() Debris:AddItem(s, 3) end) end
local function PlayWindSound(parent, duration) pcall(function() local s = Instance.new("Sound") s.SoundId = "rbxassetid://9114223173"; s.Volume = 0.7 s.Parent = parent or RootPart or workspace; s:Play() Debris:AddItem(s, duration or 2.5) end) end

local function CreateHandTrail(handPart) if not handPart then return end local a0 = Instance.new("Attachment", handPart); a0.Name = "TrailAtt0"; a0.Position = Vector3.new(0,-0.3,0) local a1 = Instance.new("Attachment", handPart); a1.Name = "TrailAtt1"; a1.Position = Vector3.new(0,0.3,0) local t = Instance.new("Trail", handPart) t.Name = "SpiderHandTrail"; t.Attachment0 = a0; t.Attachment1 = a1 t.Color = ColorSequence.new(GetTrailColor()) t.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(1,1)}) t.Lifetime = 0.5; t.MinLength = 0.01; t.Texture = "rbxassetid://607157881" end
local function SetupHandTrails(char) if not char then return end if not State.TrailsEnabled then return end local rH = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm") local lH = char:FindFirstChild("LeftHand") or char:FindFirstChild("Left Arm") if rH and not rH:FindFirstChild("SpiderHandTrail") then CreateHandTrail(rH) end if lH and not lH:FindFirstChild("SpiderHandTrail") then CreateHandTrail(lH) end end
local function RemoveAllHandTrails() if not Character then return end for _, d in ipairs(Character:GetDescendants()) do if d.Name == "SpiderHandTrail" or d.Name == "TrailAtt0" or d.Name == "TrailAtt1" then d:Destroy() end end end
local function ApplyTrailsState() if State.TrailsEnabled then SetupHandTrails(Character) else RemoveAllHandTrails() end end
local function GetPalmPosition(isRight) if not Character then return RootPart and RootPart.Position or Vector3.zero end local hN = isRight and "RightHand" or "LeftHand" local fN = isRight and "Right Arm" or "Left Arm" local h = Character:FindFirstChild(hN) or Character:FindFirstChild(fN) if h then return h.Position + (h.CFrame.LookVector * 0.4) end return RootPart and (RootPart.Position + Vector3.new(0,2,0)) or Vector3.zero end

local function createArmpitWeb(char, side)
	local arm = char:FindFirstChild(side .. "UpperArm") or char:FindFirstChild(side .. " Arm")
	local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
	local lowerTorso = char:FindFirstChild("LowerTorso") or torso
	if not arm or not torso then return end
	local armAtt = Instance.new("Attachment") armAtt.Name = "ArmpitWeb" .. side .. "ArmAtt" armAtt.Position = Vector3.new(0, -0.5, 0) armAtt.Parent = arm table.insert(wingObjects, armAtt)
	local torsoAtt1 = Instance.new("Attachment") torsoAtt1.Name = "ArmpitWeb" .. side .. "TorsoAtt1" local xOffset = (side == "Right") and 0.8 or -0.8 torsoAtt1.Position = Vector3.new(xOffset, 0.5, 0) torsoAtt1.Parent = torso table.insert(wingObjects, torsoAtt1)
	local torsoAtt2 = Instance.new("Attachment") torsoAtt2.Name = "ArmpitWeb" .. side .. "TorsoAtt2" torsoAtt2.Position = Vector3.new(xOffset, -0.5, 0) torsoAtt2.Parent = lowerTorso table.insert(wingObjects, torsoAtt2)
	local function makeWebBeam(att1, att2, parent)
		local beam = Instance.new("Beam") beam.Attachment0 = att1 beam.Attachment1 = att2 beam.Width0 = 1.2 beam.Width1 = 1.2 beam.Texture = WEB_TEXTURE beam.TextureMode = Enum.TextureMode.Stretch beam.Color = ColorSequence.new(GetWebColor()) beam.LightEmission = 1 beam.FaceCamera = true beam.Parent = parent table.insert(wingObjects, beam)
	end
	makeWebBeam(armAtt, torsoAtt1, arm) makeWebBeam(armAtt, torsoAtt2, arm) makeWebBeam(torsoAtt1, torsoAtt2, torso)
endStopWebWings = function()
	if not State.IsGliding then return end State.IsGliding = false
	if wingSound then wingSound:Stop() wingSound:Destroy() wingSound = nil end
	if wingConn then wingConn:Disconnect(); wingConn = nil end
	for _, ik in ipairs(wingIK) do if ik and ik.Parent then ik:Destroy() end end wingIK = {}
	for _, obj in ipairs(wingObjects) do if obj and obj.Parent then obj:Destroy() end end wingObjects = {}
	if wingAlign then wingAlign:Destroy(); wingAlign = nil end if wingAttachment then wingAttachment:Destroy(); wingAttachment = nil end
	if wingRightHip and wingRightHip.Parent then wingRightHip.Transform = wingRightHipOrig or CFrame.identity end if wingLeftHip and wingLeftHip.Parent then wingLeftHip.Transform = wingLeftHipOrig or CFrame.identity end
	wingRightHip = nil wingLeftHip = nil wingRightHipOrig = nil wingLeftHipOrig = nil wingHeadLook = nil
	if Humanoid then Humanoid.PlatformStand = false Humanoid.AutoRotate = true end
	if Character then local names = {"RightShoulder", "LeftShoulder", "RightElbow", "LeftElbow", "RightWrist", "LeftWrist", "Waist", "Neck", "RightHip", "LeftHip", "RightKnee", "LeftKnee", "RightAnkle", "LeftAnkle"} for _, name in ipairs(names) do setMotor(Character, name, CFrame.identity) end end
end

StartWebWings = function()
	if State.IsGliding or not Character or not Humanoid or not RootPart then return end State.IsGliding = true
	pcall(function() wingSound = Instance.new("Sound") wingSound.Name = "WebWingSound" wingSound.SoundId = WEB_WING_SOUND wingSound.Volume = 2 wingSound.Looped = true wingSound.Parent = RootPart wingSound:Play() end)
	Humanoid.AutoRotate = false Humanoid.PlatformStand = true
	local rightArmTarget = Instance.new("Attachment") rightArmTarget.Name = "WebWingRightArmTarget" rightArmTarget.Position = Vector3.new(2.45, 0.35, 0.05) rightArmTarget.Parent = RootPart table.insert(wingObjects, rightArmTarget)
	local leftArmTarget = Instance.new("Attachment") leftArmTarget.Name = "WebWingLeftArmTarget" leftArmTarget.Position = Vector3.new(-2.45, 0.35, 0.05) leftArmTarget.Parent = RootPart table.insert(wingObjects, leftArmTarget)
	local rightUpperLeg = Character:FindFirstChild("RightUpperLeg") local leftUpperLeg = Character:FindFirstChild("LeftUpperLeg")
	if rightUpperLeg then local hip = rightUpperLeg:FindFirstChild("RightHip") if hip and hip:IsA("Motor6D") then wingRightHip = hip; wingRightHipOrig = hip.Transform end end
	if leftUpperLeg then local hip = leftUpperLeg:FindFirstChild("LeftHip") if hip and hip:IsA("Motor6D") then wingLeftHip = hip; wingLeftHipOrig = hip.Transform end end
	local rightHand = getHand(Character, "Right") local rightArmRoot = getArmRoot(Character, "Right")
	if rightHand and rightArmRoot then local ik = Instance.new("IKControl") ik.Name = "WebWingRightArmIK" ik.Type = Enum.IKControlType.Position ik.EndEffector = rightHand ik.ChainRoot = rightArmRoot ik.Target = rightArmTarget ik.Weight = 1 ik.SmoothTime = 0.08 ik.Parent = Humanoid table.insert(wingIK, ik) end
	local leftHand = getHand(Character, "Left") local leftArmRoot = getArmRoot(Character, "Left")
	if leftHand and leftArmRoot then local ik = Instance.new("IKControl") ik.Name = "WebWingLeftArmIK" ik.Type = Enum.IKControlType.Position ik.EndEffector = leftHand ik.ChainRoot = leftArmRoot ik.Target = leftArmTarget ik.Weight = 1 ik.SmoothTime = 0.08 ik.Parent = Humanoid table.insert(wingIK, ik) end
	local function createWebWingBeam(target, hand)
		if not target or not hand then return end
		local handAttachment = Instance.new("Attachment") handAttachment.Name = "WebWingHandAttachment" handAttachment.Parent = hand
		local beam = Instance.new("Beam") beam.Attachment0 = target beam.Attachment1 = handAttachment beam.Width0 = 0.92 beam.Width1 = 0.72 beam.Texture = WEB_TEXTURE beam.TextureMode = Enum.TextureMode.Wrap beam.TextureLength = 1 beam.Color = ColorSequence.new(GetWebColor()) beam.LightEmission = 1 beam.FaceCamera = true beam.Parent = hand
		table.insert(wingObjects, handAttachment) table.insert(wingObjects, beam)
	end
	createWebWingBeam(rightArmTarget, rightHand) createWebWingBeam(leftArmTarget, leftHand)
	createArmpitWeb(Character, "Right") createArmpitWeb(Character, "Left")
	wingAttachment = Instance.new("Attachment") wingAttachment.Name = "WebWingOrientation" wingAttachment.Parent = RootPart
	wingAlign = Instance.new("AlignOrientation") wingAlign.Name = "WebWingAlign" wingAlign.Mode = Enum.OrientationAlignmentMode.OneAttachment wingAlign.Attachment0 = wingAttachment wingAlign.MaxTorque = math.huge wingAlign.Responsiveness = 20 wingAlign.RigidityEnabled = false wingAlign.Parent = RootPart
	local head = Character:FindFirstChild("Head") local upper = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso")
	wingHeadLook = Instance.new("Attachment") wingHeadLook.Name = "WebWingHeadLook" wingHeadLook.Parent = RootPart table.insert(wingObjects, wingHeadLook)
	if head and upper then local ik = Instance.new("IKControl") ik.Name = "WebWingHeadIK" ik.Type = Enum.IKControlType.LookAt ik.EndEffector = head ik.ChainRoot = upper ik.Target = wingHeadLook ik.Weight = 1 ik.SmoothTime = 0.08 ik.Parent = Humanoid table.insert(wingIK, ik) end
	wingConn = RunService.RenderStepped:Connect(function()
		if not State.IsGliding then return end
		if not RootPart or not RootPart.Parent then StopWebWings(); return end
		local camera = workspace.CurrentCamera if not camera then return end
		local cameraLook = camera.CFrame.LookVector local forward = Vector3.new(cameraLook.X, 0, cameraLook.Z)
		if forward.Magnitude < 0.01 then return end forward = forward.Unit
		local maxSpd = IsSym() and 500 or 200
		local currentSpd = math.min(State.WingSpeed, maxSpd)
		RootPart.AssemblyLinearVelocity = forward * currentSpd + Vector3.new(0, -4, 0)
		wingAlign.CFrame = CFrame.lookAt(Vector3.zero, Vector3.new(0, -1, 0), forward)
		poseWingArms(Character)
		if wingRightHip and wingRightHip.Parent then wingRightHip.Transform = CFrame.Angles(math.rad(-18), math.rad(8), math.rad(8)) end
		if wingLeftHip and wingLeftHip.Parent then wingLeftHip.Transform = CFrame.Angles(math.rad(-18), math.rad(-8), math.rad(-8)) end
		if wingHeadLook and wingHeadLook.Parent and head then wingHeadLook.WorldPosition = head.Position + forward * 10 + Vector3.new(0, 2, 0) end
	end)
end

local function updateCylinder(part, pos1, pos2)
    if not part or not part.Parent then return end
    local dist = math.max((pos2 - pos1).Magnitude, 0.1)
    part.Size = Vector3.new(dist, 0.15, 0.15)
    part.CFrame = CFrame.lookAt((pos1 + pos2) / 2, pos2) * CFrame.Angles(0, math.pi / 2, 0)
end

StopHang = function()
	if not hanging then return end hanging = false
	if hangRenderConn then hangRenderConn:Disconnect() hangRenderConn = nil end
	if hangTrack and hangTrack.IsPlaying then hangTrack:Stop(0.15) hangTrack = nil end
	for _, obj in ipairs(hangObjects) do if obj and obj.Parent then obj:Destroy() end end hangObjects = {}
	if Humanoid then Humanoid.PlatformStand = false Humanoid.AutoRotate = true end
	if RootPart then RootPart.AssemblyLinearVelocity = Vector3.new(0, -5, 0) end
end

StartHang = function()
	if hanging then StopHang() return end
	if not Character or not Humanoid or not RootPart then return end
	local rightArm = Character:FindFirstChild("RightHand") or Character:FindFirstChild("Right Arm")
	local rightLeg = Character:FindFirstChild("RightFoot") or Character:FindFirstChild("Right Leg")
	if not rightArm or not rightLeg then return end
	hanging = true Humanoid.PlatformStand = true Humanoid.AutoRotate = false
	local animator = getAnimator(Humanoid) local anim = Instance.new("Animation") anim.AnimationId = HANG_ANIM
	hangTrack = animator:LoadAnimation(anim) hangTrack.Priority = Enum.AnimationPriority.Action4 hangTrack.Looped = true hangTrack:Play(0.1)
	local params = RaycastParams.new() params.FilterType = Enum.RaycastFilterType.Exclude params.FilterDescendantsInstances = { Character } params.IgnoreWater = true
	local hit = workspace:Raycast(RootPart.Position, Vector3.new(0, 45, 0), params)
	local anchorPos = hit and (hit.Position - Vector3.new(0, 0.15, 0)) or (RootPart.Position + Vector3.new(0, 22, 0))
	local anchor = Instance.new("Part") anchor.Name = "HangAnchor" anchor.Anchored = true anchor.CanCollide = false anchor.Transparency = 1 anchor.Size = Vector3.new(0.2, 0.2, 0.2) anchor.Position = anchorPos anchor.Parent = workspace table.insert(hangObjects, anchor)
	attCeiling = Instance.new("Attachment", anchor)
	attArm = Instance.new("Attachment", rightArm) table.insert(hangObjects, attArm)
	attLeg = Instance.new("Attachment", rightLeg) table.insert(hangObjects, attLeg)
	hangWeb1 = Instance.new("Part") hangWeb1.Name = "CylinderWeb1" hangWeb1.Anchored = true hangWeb1.CanCollide = false hangWeb1.Material = Enum.Material.SmoothPlastic hangWeb1.Color = GetWebColor() hangWeb1.Parent = workspace table.insert(hangObjects, hangWeb1)
	hangWeb2 = Instance.new("Part") hangWeb2.Name = "CylinderWeb2" hangWeb2.Anchored = true hangWeb2.CanCollide = false hangWeb2.Material = Enum.Material.SmoothPlastic hangWeb2.Color = GetWebColor() hangWeb2.Parent = workspace table.insert(hangObjects, hangWeb2)
	local att = Instance.new("Attachment") att.Parent = RootPart table.insert(hangObjects, att)
	local alignPos = Instance.new("AlignPosition") alignPos.Mode = Enum.PositionAlignmentMode.OneAttachment alignPos.Attachment0 = att alignPos.MaxForce = math.huge alignPos.Responsiveness = 25 alignPos.Position = anchorPos - Vector3.new(0, 18, 0) alignPos.Parent = RootPart table.insert(hangObjects, alignPos)
	local alignOri = Instance.new("AlignOrientation") alignOri.Mode = Enum.OrientationAlignmentMode.OneAttachment alignOri.Attachment0 = att alignOri.MaxTorque = math.huge alignOri.Responsiveness = 25 alignOri.CFrame = RootPart.CFrame alignOri.Parent = RootPart table.insert(hangObjects, alignOri)
	hangRenderConn = RunService.RenderStepped:Connect(function()
		if not hanging or not Character.Parent then return end
		updateCylinder(hangWeb1, attCeiling.WorldPosition, attArm.WorldPosition)
		updateCylinder(hangWeb2, attArm.WorldPosition, attLeg.WorldPosition)
	end)
end

local function getClimbSurface()
	if not Character or not RootPart then return nil, nil end
	local params = RaycastParams.new() params.FilterType = Enum.RaycastFilterType.Exclude params.FilterDescendantsInstances = { Character } params.IgnoreWater = true
	local up = workspace:Raycast(RootPart.Position, Vector3.new(0, 4.8, 0), params) if up and up.Normal.Y < -0.45 then return up, "ceiling" end
	local flatLook = Vector3.new(RootPart.CFrame.LookVector.X, 0, RootPart.CFrame.LookVector.Z) if flatLook.Magnitude > 0.01 then local lip = workspace:Raycast(RootPart.Position + Vector3.new(0, 1.4, 0), flatLook.Unit * 2.4 + Vector3.new(0, 3.2, 0), params) if lip and lip.Normal.Y < -0.4 then return lip, "ceiling" end end
	local directions = { RootPart.CFrame.LookVector, -RootPart.CFrame.LookVector, RootPart.CFrame.RightVector, -RootPart.CFrame.RightVector }
	local closestResult = nil local closestDistance = math.huge
	for _, direction in ipairs(directions) do local result = workspace:Raycast(RootPart.Position, direction * 3.6, params) if result and math.abs(result.Normal.Y) < 0.55 then local distance = (result.Position - RootPart.Position).Magnitude if distance < closestDistance then closestDistance = distance closestResult = result end end end
	if closestResult then return closestResult, "wall" end return nil, nil
end

local function stopClimb()
	if not climbing then return end climbing = false
	if climbConn then climbConn:Disconnect(); climbConn = nil end
	if climbTrack then if climbTrack.IsPlaying then climbTrack:Stop(0.15) end climbTrack = nil end
	if climbVelocity then climbVelocity:Destroy(); climbVelocity = nil end if climbAlign then climbAlign:Destroy(); climbAlign = nil end if climbAttachment then climbAttachment:Destroy(); climbAttachment = nil end
	if Humanoid then Humanoid.AutoRotate = true Humanoid.PlatformStand = false end if RootPart then RootPart.AssemblyLinearVelocity = Vector3.zero end
end

local function startClimb()
	if climbing or not climbEnabled then return end if not Character or not Humanoid or not RootPart then return end
	local wall = getClimbSurface() if not wall then return end
	climbing = true Humanoid.AutoRotate = false Humanoid.PlatformStand = false
	local animator = getAnimator(Humanoid) local anim = Instance.new("Animation") anim.AnimationId = CLIMB_ANIM
	climbTrack = animator:LoadAnimation(anim) climbTrack.Priority = Enum.AnimationPriority.Action4 climbTrack.Looped = true climbTrack:Play(0.1) pcall(function() Humanoid:ChangeState(Enum.HumanoidStateType.Climbing) end)
	climbAttachment = Instance.new("Attachment") climbAttachment.Name = "SpiderClimbAttachment" climbAttachment.Parent = RootPart
	climbVelocity = Instance.new("LinearVelocity") climbVelocity.Name = "SpiderClimbVelocity" climbVelocity.MaxForce = math.huge climbVelocity.RelativeTo = Enum.ActuatorRelativeTo.World climbVelocity.VectorVelocity = Vector3.zero climbVelocity.Attachment0 = climbAttachment climbVelocity.Parent = RootPart
	climbAlign = Instance.new("AlignOrientation") climbAlign.Name = "SpiderClimbOrientation" climbAlign.Mode = Enum.OrientationAlignmentMode.OneAttachment climbAlign.MaxTorque = math.huge climbAlign.Responsiveness = 30 climbAlign.RigidityEnabled = false climbAlign.Attachment0 = climbAttachment climbAlign.Parent = RootPart
	climbConn = RunService.RenderStepped:Connect(function()
		if not climbing then return end if not RootPart or not RootPart.Parent then stopClimb(); return end if not Humanoid or not Character then stopClimb(); return end
		local surface, kind = getClimbSurface() if not surface then stopClimb(); return end
		local normal = surface.Normal local cam = workspace.CurrentCamera if not cam then return end
		local cameraForward = cam.CFrame.LookVector local cameraRight = cam.CFrame.RightVector local move = Humanoid.MoveDirection
		if kind == "ceiling" then
			Humanoid.PlatformStand = true local planar = Vector3.new(move.X, 0, move.Z) local speed = 0
			if planar.Magnitude > 0.08 then planar = planar.Unit speed = 12
			else planar = Vector3.new(cameraForward.X, 0, cameraForward.Z) if planar.Magnitude > 0.01 then planar = planar.Unit else planar = Vector3.new(0, 0, -1) end end
			climbVelocity.VectorVelocity = planar * speed + Vector3.new(0, 7, 0) climbAlign.CFrame = CFrame.lookAt(Vector3.zero, Vector3.new(0, 1, 0), planar)
		else
			Humanoid.PlatformStand = false local horizontal = Vector3.new(move.X, 0, move.Z) local vertical = 0
			if horizontal.Magnitude > 0.05 then vertical = horizontal:Dot(cameraForward) end
			local upv = Vector3.new(0, 1, 0) local wallRight = cameraRight - normal * cameraRight:Dot(normal) if wallRight.Magnitude > 0.01 then wallRight = wallRight.Unit end
			climbVelocity.VectorVelocity = upv * vertical * 9 + wallRight * move:Dot(wallRight) * 8 - normal * 4
			local facing = -normal local look = Vector3.new(facing.X, 0, facing.Z) if look.Magnitude > 0.01 then climbAlign.CFrame = CFrame.lookAt(Vector3.zero, look.Unit) end
		end
		if Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing then pcall(function() Humanoid:ChangeState(Enum.HumanoidStateType.Climbing) end) end
	end)
end

local function CreateParachuteLine(folder, startPos, endPos, thickness)
	local distance = math.max((endPos - startPos).Magnitude, 0.1)
	local line = Instance.new("Part") line.Name = "ParachuteWeb"; line.Anchored = true line.CanCollide = false; line.CanTouch = false; line.CanQuery = false
	line.Material = Enum.Material.SmoothPlastic; line.Color = GetWebColor() line.Size = Vector3.new(thickness or 0.12, thickness or 0.12, distance) line.CFrame = CFrame.lookAt((startPos+endPos)/2, endPos) line.Parent = folder
	if IsSym() then AddSymbioteSmoke(line) end return line
end

local function RebuildParachuteVisual()
	if not State.ParachuteFolder or not RootPart then return end
	for _, obj in ipairs(State.ParachuteFolder:GetChildren()) do obj:Destroy() end
	local canopyCenter = RootPart.Position + Vector3.new(0,13,0)
	local cp = Instance.new("Part"); cp.Name = "ParachuteCenter" cp.Shape = Enum.PartType.Ball; cp.Size = Vector3.new(0.7,0.7,0.7) cp.Position = canopyCenter; cp.Anchored = true cp.CanCollide = false; cp.CanTouch = false; cp.CanQuery = false cp.Material = Enum.Material.SmoothPlastic; cp.Color = GetWebColor() cp.Parent = State.ParachuteFolder
	if IsSym() then AddSymbioteSmoke(cp) end
	local segments, radius = 14, 8
	for i = 1, segments do local angle = (math.pi*2)*((i-1)/segments) local edge = canopyCenter + Vector3.new(math.cos(angle)*radius, -1.5, math.sin(angle)*radius) CreateParachuteLine(State.ParachuteFolder, canopyCenter, edge, 0.16) end
	for i = 1, segments do local a1 = (math.pi*2)*((i-1)/segments); local a2 = (math.pi*2)*(i/segments) local p1 = canopyCenter + Vector3.new(math.cos(a1)*radius, -1.5, math.sin(a1)*radius) local p2 = canopyCenter + Vector3.new(math.cos(a2)*radius, -1.5, math.sin(a2)*radius) CreateParachuteLine(State.ParachuteFolder, p1, p2, 0.13) end
	for i = 1, 7 do local angle = (math.pi*2)*((i-1)/7) local edge = canopyCenter + Vector3.new(math.cos(angle)*radius, -1.5, math.sin(angle)*radius) local body = RootPart.Position + Vector3.new(math.cos(angle)*1.5, 0, math.sin(angle)*1.5) CreateParachuteLine(State.ParachuteFolder, edge, body, 0.1) end
end

OpenParachute = function()
	if not Character or not Humanoid or not RootPart or not State.IsSystemOnline then return end if State.Parachuting or Humanoid.Health <= 0 then return end
	local cs = Humanoid:GetState() if cs == Enum.HumanoidStateType.Seated or cs == Enum.HumanoidStateType.Dead then return end
	State.Parachuting = true PlayWebShootSound(RootPart); PlayWindSound(RootPart, 2)
	local folder = Instance.new("Folder", workspace); folder.Name = "SpiderWebParachute" State.ParachuteFolder = folder
	local att = Instance.new("Attachment", RootPart) att.Name = "SpiderParachuteAttachment"; att.Position = Vector3.new(0,1.5,0) State.ParachuteAttachment = att
	local force = Instance.new("VectorForce") force.Name = "SpiderParachuteForce"; force.Attachment0 = att force.RelativeTo = Enum.ActuatorRelativeTo.World; force.ApplyAtCenterOfMass = true force.Force = Vector3.new(0, RootPart.AssemblyMass * workspace.Gravity * 0.75, 0) force.Parent = RootPart; State.ParachuteForce = force
	RootPart.AssemblyLinearVelocity = Vector3.new(RootPart.AssemblyLinearVelocity.X, -18, RootPart.AssemblyLinearVelocity.Z) RebuildParachuteVisual()
end

CloseParachute = function()
	if not State.Parachuting then return end State.Parachuting = false
	if State.ParachuteForce then State.ParachuteForce:Destroy() State.ParachuteForce = nil end if State.ParachuteAttachment then State.ParachuteAttachment:Destroy() State.ParachuteAttachment = nil end
	if State.ParachuteFolder then local folder = State.ParachuteFolder; State.ParachuteFolder = nil task.spawn(function() local elapsed, duration = 0, 0.25 while elapsed < duration and folder and folder.Parent do local dt = RunService.RenderStepped:Wait(); elapsed += dt local alpha = math.clamp(elapsed/duration, 0, 1) for _, obj in ipairs(folder:GetChildren()) do if obj:IsA("BasePart") then obj.Transparency = alpha end end end if folder and folder.Parent then folder:Destroy() end end) end
end

ToggleParachute = function() if State.Parachuting then CloseParachute() else OpenParachute() end end

local function MakeDraggable(gui)
	local dragging, dragInput, dragStart, startPos
	gui.InputBegan:Connect(function(input) if not State.DraggableButtons then return end if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; dragStart = input.Position; startPos = gui.Position input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end) end end)
	gui.InputChanged:Connect(function(input) if not State.DraggableButtons then return end if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
	UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging and State.DraggableButtons then local delta = input.Position - dragStart gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
end

local function CreateCrosshair(parent)
	if crosshairFrame then crosshairFrame:Destroy() end
	crosshairFrame = Instance.new("Frame", parent) crosshairFrame.Name = "SpiderCrosshair" crosshairFrame.Size = UDim2.new(0,20,0,20) crosshairFrame.Position = UDim2.new(0.5,0,0.5,45) crosshairFrame.AnchorPoint = Vector2.new(0.5,0.5) crosshairFrame.BackgroundTransparency = 1 crosshairFrame.ZIndex = 10 crosshairFrame.Visible = State.CrosshairEnabled
	local chColor = IsSym() and Color3.fromRGB(20,20,20) or CYAN local chAlpha = IsSym() and 0.35 or 0
	local v = Instance.new("Frame", crosshairFrame) v.Name = "CrossV"; v.Size = UDim2.new(0,2,1,0); v.Position = UDim2.new(0.5,-1,0,0) v.BackgroundColor3 = chColor; v.BackgroundTransparency = chAlpha; v.BorderSizePixel = 0
	local h = Instance.new("Frame", crosshairFrame) h.Name = "CrossH"; h.Size = UDim2.new(1,0,0,2); h.Position = UDim2.new(0,0,0.5,-1) h.BackgroundColor3 = chColor; h.BackgroundTransparency = chAlpha; h.BorderSizePixel = 0
end

local function CreateLeapBar(parent)
	if leapBarContainer then leapBarContainer:Destroy() end
	leapBarContainer = Instance.new("Frame", parent) leapBarContainer.Name = "LeapBarContainer" leapBarContainer.Size = UDim2.new(0,200,0,16) leapBarContainer.Position = UDim2.new(0.5,-100,0.82,0) leapBarContainer.BackgroundColor3 = DARK leapBarContainer.BackgroundTransparency = 0.3 leapBarContainer.BorderSizePixel = 0 leapBarContainer.Visible = false leapBarContainer.ZIndex = 15
	Instance.new("UICorner", leapBarContainer).CornerRadius = UDim.new(0,8)
	local stroke = Instance.new("UIStroke", leapBarContainer) stroke.Color = CYAN; stroke.Thickness = 1.5
	leapBarFill = Instance.new("Frame", leapBarContainer) leapBarFill.Name = "LeapBarFill" leapBarFill.Size = UDim2.new(0,0,1,0) leapBarFill.BackgroundColor3 = CYAN leapBarFill.BorderSizePixel = 0 Instance.new("UICorner", leapBarFill).CornerRadius = UDim.new(0,8)
end

local function CreateGlassButton(holder, size, position, anchor, text, imageId, key)
	local hasImage = (imageId and imageId ~= "")
	local btn = Instance.new("TextButton", holder) btn.Size = size; btn.Position = position; btn.AnchorPoint = anchor btn.BackgroundColor3 = DARK
	if hasImage then btn.BackgroundTransparency = State.ButtonsTransparent and 0.85 or 0.25 else btn.BackgroundTransparency = State.ButtonsTransparent and 0.55 or 0.25 end
	btn.BorderSizePixel = 0; btn.AutoButtonColor = false btn.Text = ""; btn.ClipsDescendants = true; btn.ZIndex = 5 btn:SetAttribute("InitialPos", position) Instance.new("UICorner", btn).CornerRadius = UDim.new(0.3,0)
	local stroke = Instance.new("UIStroke", btn) stroke.Color = CYAN
	if hasImage then stroke.Transparency = State.ButtonsTransparent and 0.5 or 0.2 else stroke.Transparency = State.ButtonsTransparent and 0.3 or 0.2 end
	stroke.Thickness = 1.5
	local imgLabel, label
	if hasImage then imgLabel = Instance.new("ImageLabel", btn) imgLabel.Name = "ButtonIcon" imgLabel.Size = UDim2.new(1,0,1,0) imgLabel.Position = UDim2.new(0.5,0,0.5,0) imgLabel.AnchorPoint = Vector2.new(0.5,0.5) imgLabel.BackgroundTransparency = 1; imgLabel.Image = imageId imgLabel.ScaleType = Enum.ScaleType.Crop imgLabel.ImageTransparency = State.ButtonsTransparent and 0.45 or 0 imgLabel.ZIndex = 6 Instance.new("UICorner", imgLabel).CornerRadius = UDim.new(0.3,0) end
	if text and text ~= "" then label = Instance.new("TextLabel", btn) label.Size = UDim2.new(1,0,1,0) label.BackgroundTransparency = 1 label.Font = Enum.Font.GothamBold label.TextColor3 = CYAN; label.TextScaled = true; label.Text = text label.TextTransparency = State.ButtonsTransparent and 0.35 or 0 label.ZIndex = 7 end
	table.insert(allButtonsList, {btn=btn, stroke=stroke, img=imgLabel, txt=label, hasImage=hasImage}) if key then buttonRefs[key] = btn end MakeDraggable(btn) return btn, stroke
end

local function RefreshButtonsTransparency()
	for _, item in ipairs(allButtonsList) do if item.btn and item.btn.Parent then if item.hasImage then item.btn.BackgroundTransparency = State.ButtonsTransparent and 0.85 or 0.25 if item.stroke then item.stroke.Transparency = State.ButtonsTransparent and 0.5 or 0.2 end if item.img then item.img.ImageTransparency = State.ButtonsTransparent and 0.45 or 0 end else item.btn.BackgroundTransparency = State.ButtonsTransparent and 0.55 or 0.25 if item.stroke then item.stroke.Transparency = State.ButtonsTransparent and 0.3 or 0.2 end if item.txt then item.txt.TextTransparency = State.ButtonsTransparent and 0.35 or 0 end end end end
end

local function ApplyHideButtons()
	for _, item in ipairs(allButtonsList) do if item.btn and item.btn.Parent then if item.btn == configBtnRef then item.btn.Visible = true elseif item.btn == xrayBtnRef then item.btn.Visible = State.XrayButtonVisible and not State.HideButtons elseif item.btn == DroneButton then item.btn.Visible = State.DronesEnabled and not State.HideButtons elseif item.btn == wallClimbBtnRef then item.btn.Visible = State.WallClimbEnabled and not State.HideButtons elseif item.btn == wingBtnRef then item.btn.Visible = State.WebWingsEnabled and not State.HideButtons elseif item.btn == emoteBtnRef then item.btn.Visible = State.EmoteEnabled and not State.HideButtons else item.btn.Visible = not State.HideButtons end end end
end

ApplySymbioteVisuals = function()
	local useSym = IsSym() local keepOrigButtons = State.SymbioteKeepOrigButtons
	local btnPrimary = (useSym and not keepOrigButtons) and SYM_WHITE or ORIG_CYAN local btnAccent = (useSym and not keepOrigButtons) and SYM_BLACK or ORIG_RED local btnDark = (useSym and not keepOrigButtons) and SYM_BG or ORIG_DARK
	local hudPrimary = useSym and SYM_WHITE or ORIG_CYAN local hudAccent = useSym and SYM_BLACK or ORIG_RED local hudDark = useSym and SYM_BG or ORIG_DARK local hudFaint = useSym and SYM_GRAY or ORIG_FAINT
	CYAN = btnPrimary; RED = btnAccent; DARK = btnDark
	for _, item in ipairs(allButtonsList) do if item.btn and item.btn.Parent then item.btn.BackgroundColor3 = btnDark if item.stroke then item.stroke.Color = btnPrimary end if item.img then item.img.ImageColor3 = Color3.new(1,1,1) end if item.txt then item.txt.TextColor3 = btnPrimary end end end
	if guiMain then
		local hc = guiMain:FindFirstChild("HudContainer")
		if hc then for _, d in ipairs(hc:GetDescendants()) do if d:IsA("TextLabel") then if d == titleLabelRef or d == meterLabelRef then d.TextColor3 = hudPrimary elseif d == subLabelRef or d == dialLabelRef then d.TextColor3 = hudFaint elseif d == telemetryLabel then d.TextColor3 = hudPrimary else d.TextColor3 = hudPrimary end elseif d:IsA("Frame") then if d == ChargeFill then d.BackgroundColor3 = hudPrimary elseif d.Name:match("^LensEdge") then if d:GetAttribute("EdgeKind") == "accent" then d.BackgroundColor3 = hudAccent else d.BackgroundColor3 = hudPrimary end elseif d.Name == "AccentBar" then d.BackgroundColor3 = hudAccent elseif d.Name == "CornerH" or d.Name == "CornerV" then d.BackgroundColor3 = hudPrimary elseif d.Name:match("^ScanLine") then d.BackgroundColor3 = hudPrimary elseif d.Name == "DialSpoke" then local isAccent = d:GetAttribute("IsAccent") == true d.BackgroundColor3 = isAccent and hudAccent or hudPrimary elseif d == dialCoreRef then d.BackgroundColor3 = hudPrimary elseif d.Name == "Tick" then d.BackgroundColor3 = hudAccent end elseif d:IsA("UIStroke") then if d.Parent and d.Parent.Name == "TopBar" then d.Color = hudPrimary elseif d.Parent and d.Parent.Name == "MeterBG" then d.Color = hudPrimary elseif d.Parent == customCursor then d.Color = hudPrimary end end end end
		if topBarRef then topBarRef.BackgroundColor3 = hudDark end if meterLabelRef then meterLabelRef.TextColor3 = hudPrimary end
		if ChargeFillGradient then if useSym then ChargeFillGradient.Color = ColorSequence.new(Color3.fromRGB(255,255,255)) else ChargeFillGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(0.15, ORIG_CYAN),ColorSequenceKeypoint.new(1, ORIG_CYAN)}) end end
		if customCursor then local dot = customCursor:FindFirstChildWhichIsA("Frame") if dot then dot.BackgroundColor3 = useSym and Color3.fromRGB(20,20,20) or ORIG_CYAN end local stroke = customCursor:FindFirstChildOfClass("UIStroke") if stroke then stroke.Color = useSym and Color3.fromRGB(20,20,20) or ORIG_CYAN end for _, t in ipairs(customCursor:GetChildren()) do if t:IsA("Frame") and t ~= dot then t.BackgroundColor3 = useSym and Color3.fromRGB(15,15,15) or ORIG_RED end end end
		if crosshairFrame then local v = crosshairFrame:FindFirstChild("CrossV") local h = crosshairFrame:FindFirstChild("CrossH") local col = useSym and Color3.fromRGB(20,20,20) or ORIG_CYAN local alp = useSym and 0.35 or 0 if v then v.BackgroundColor3 = col v.BackgroundTransparency = alp end if h then h.BackgroundColor3 = col h.BackgroundTransparency = alp end end
		if leapBarContainer then leapBarContainer.BackgroundColor3 = hudDark local st = leapBarContainer:FindFirstChildOfClass("UIStroke") if st then st.Color = hudPrimary end if leapBarFill then leapBarFill.BackgroundColor3 = hudPrimary end end
	end
	CYAN = ORIG_CYAN; RED = ORIG_RED; DARK = ORIG_DARK; FAINT = ORIG_FAINT
	UpdateTrailsColor(); UpdateAllWebs()
	if State.IsGliding then for _, obj in ipairs(wingObjects) do if obj:IsA("Beam") then obj.Color = ColorSequence.new(GetWebColor()) end end end
	if hanging then if hangWeb1 then hangWeb1.Color = GetWebColor() end if hangWeb2 then hangWeb2.Color = GetWebColor() end end
	if wingSpeedLabel and wingSpeedBar and wingSpeedKnob then local currentMax = IsSym() and 500 or 200 if State.WingSpeed > currentMax then State.WingSpeed = currentMax end local percent = math.clamp((State.WingSpeed - State.DefaultWingSpeed) / (currentMax - State.DefaultWingSpeed), 0, 1) wingSpeedBar.Size = UDim2.new(percent, 0, 1, 0) wingSpeedKnob.Position = UDim2.new(percent, -9, 0.5, -9) wingSpeedLabel.Text = T("wing_speed") .. ": " .. math.floor(State.WingSpeed) .. " / " .. currentMax end
end

local function EnableXray()
	xrayOriginalData = {}
	for _, obj in ipairs(workspace:GetDescendants()) do if obj:IsA("BasePart") then local skip = false if Character and obj:IsDescendantOf(Character) then skip = true end if obj.Transparency >= 0.95 then skip = true end if not skip then xrayOriginalData[obj] = {Transparency = obj.Transparency, CastShadow = obj.CastShadow} obj.Transparency = 0.7; obj.CastShadow = false end end end
end

local function DisableXray() for obj, data in pairs(xrayOriginalData) do if obj and obj.Parent then obj.Transparency = data.Transparency; obj.CastShadow = data.CastShadow end end xrayOriginalData = {} end
local function SetXray(enabled) State.XrayEnabled = enabled pcall(enabled and EnableXray or DisableXray) end

local function CloseDrone()
	droneActive = false; State.DroneActive = false if Camera then Camera.CameraType = Enum.CameraType.Custom end moveVec = Vector3.new(0,0,0) if DroneBlur then DroneBlur.Size = 0 end if DroneOverlay then DroneOverlay.Visible = false end if DroneControls then DroneControls.Visible = false end if DroneMenu then DroneMenu.Visible = false end if DroneMenuButton then DroneMenuButton.Visible = false end if CoreLight then CoreLight.Enabled = false end if RingLight then RingLight.Enabled = false end flashlightActive = false if LightBtn then LightBtn.Text = "LIGHT: OFF" end
end

local function OpenDrone()
	if not State.DronesEnabled or not DroneGui then return end droneActive = true; State.DroneActive = true dronePos = Camera.CFrame.Position camRot = Vector2.new(0,0); moveVec = Vector3.new(0,0,0) Camera.CameraType = Enum.CameraType.Scriptable if DroneOverlay then DroneOverlay.Visible = true end if DroneControls then DroneControls.Visible = true end if DroneMenuButton then DroneMenuButton.Visible = true end
end

local function ToggleDrone()
	if not State.DronesEnabled then return end if droneActive then CloseDrone(); ApplyHideButtons() if crosshairFrame and State.CrosshairEnabled then crosshairFrame.Visible = true end else OpenDrone() for _, item in ipairs(allButtonsList) do if item.btn and item.btn.Parent then if item.btn ~= DroneButton then item.btn.Visible = false end end end if configPanelRef then configPanelRef.Visible = false end if crosshairFrame then crosshairFrame.Visible = false end end
end

local function SetDroneEnabled(enabled) State.DronesEnabled = enabled if not enabled then CloseDrone(); if DroneButton then DroneButton.Visible = false end; return end if DroneButton then DroneButton.Visible = true end end

local function CreateDroneSystem()
	for _, v in pairs(LocalPlayer.PlayerGui:GetChildren()) do if v.Name == "OUROBOROS_V35" then v:Destroy() end end if Camera:FindFirstChild("DroneBlur") then Camera.DroneBlur:Destroy() end if Camera:FindFirstChild("FlashlightModel") then Camera.FlashlightModel:Destroy() end
	DroneGui = Instance.new("ScreenGui") DroneGui.Name = "OUROBOROS_V35" DroneGui.IgnoreGuiInset = true DroneGui.ResetOnSpawn = false DroneGui.Parent = LocalPlayer.PlayerGui
	DroneBlur = Instance.new("BlurEffect", Camera) DroneBlur.Name = "DroneBlur"; DroneBlur.Size = 0
	DroneOverlay = Instance.new("Frame", DroneGui) DroneOverlay.Size = UDim2.new(1,0,1,0); DroneOverlay.BackgroundTransparency = 1 DroneOverlay.Visible = false; DroneOverlay.ZIndex = 80
	local function drawLine(pos, size, parent) local l = Instance.new("Frame", parent) l.Position = pos; l.Size = size; l.BackgroundColor3 = Color3.new(1,1,1) l.BorderSizePixel = 0; l.ZIndex = 85 end
	local bS, bT = 60, 2
	drawLine(UDim2.new(0,30,0,30), UDim2.new(0,bS,0,bT), DroneOverlay) drawLine(UDim2.new(0,30,0,30), UDim2.new(0,bT,0,bS), DroneOverlay) drawLine(UDim2.new(1,-30-bS,0,30), UDim2.new(0,bS,0,bT), DroneOverlay) drawLine(UDim2.new(1,-32,0,30), UDim2.new(0,bT,0,bS), DroneOverlay) drawLine(UDim2.new(0,30,1,-32), UDim2.new(0,bS,0,bT), DroneOverlay) drawLine(UDim2.new(0,30,1,-30-bS), UDim2.new(0,bT,0,bS), DroneOverlay) drawLine(UDim2.new(1,-30-bS,1,-32), UDim2.new(0,bS,0,bT), DroneOverlay) drawLine(UDim2.new(1,-32,1,-30-bS), UDim2.new(0,bT,0,bS), DroneOverlay)
	local Crosshair = Instance.new("Frame", DroneOverlay) Crosshair.Size = UDim2.new(0,32,0,32); Crosshair.Position = UDim2.new(0.5,-16,0.5,-16) Crosshair.BackgroundTransparency = 1; Crosshair.ZIndex = 85
	local cS, cT = 8, 1
	drawLine(UDim2.new(0,0,0,0), UDim2.new(0,cS,0,cT), Crosshair); drawLine(UDim2.new(0,0,0,0), UDim2.new(0,cT,0,cS), Crosshair) drawLine(UDim2.new(1,-cS,0,0), UDim2.new(0,cS,0,cT), Crosshair); drawLine(UDim2.new(1,-cT,0,0), UDim2.new(0,cT,0,cS), Crosshair) drawLine(UDim2.new(0,0,1,-cT), UDim2.new(0,cS,0,cT), Crosshair); drawLine(UDim2.new(0,0,1,-cS), UDim2.new(0,cT,0,cS), Crosshair) drawLine(UDim2.new(1,-cS,1,-cT), UDim2.new(0,cS,0,cT), Crosshair); drawLine(UDim2.new(1,-cT,1,-cS), UDim2.new(0,cT,0,cS), Crosshair)
	local function vhsLabel(txt, pos, align, size) local l = Instance.new("TextLabel", DroneOverlay) l.Size = UDim2.new(0,250,0,50); l.Position = pos l.BackgroundTransparency = 1; l.TextColor3 = Color3.new(1,1,1) l.Text = txt; l.Font = Enum.Font.Code; l.TextSize = size or 25 l.TextXAlignment = align; l.ZIndex = 86 return l end
	vhsLabel("PLAY " .. PLAY_ICON, UDim2.new(0,60,0,50), Enum.TextXAlignment.Left, 28) timeStatus = vhsLabel("-- : --", UDim2.new(1,-310,0,50), Enum.TextXAlignment.Right) dateStamp = vhsLabel("", UDim2.new(0,60,1,-110), Enum.TextXAlignment.Left, 22) fCounter = vhsLabel("00:00:00:00", UDim2.new(1,-310,1,-110), Enum.TextXAlignment.Right)
	vigGradients = {} local function makeVig(size, pos, rot) local f = Instance.new("Frame", DroneOverlay) f.Size = size; f.Position = pos; f.BorderSizePixel = 0 f.BackgroundColor3 = Color3.new(0,0,0); f.ZIndex = 81 local g = Instance.new("UIGradient", f); g.Rotation = rot table.insert(vigGradients, g) end
	makeVig(UDim2.new(1,0,0,180), UDim2.new(0,0,0,0), 90) makeVig(UDim2.new(1,0,0,180), UDim2.new(0,0,1,-180), -90) makeVig(UDim2.new(0,180,1,0), UDim2.new(0,0,0,0), 0) makeVig(UDim2.new(0,180,1,0), UDim2.new(1,-180,0,0), 180)
	local function updateVig(p) vigIntensity = p for _, g in pairs(vigGradients) do g.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1 - vigIntensity),NumberSequenceKeypoint.new(1, 1)}) end end
	DroneControls = Instance.new("Frame", DroneGui) DroneControls.Size = UDim2.new(1,0,1,0) DroneControls.BackgroundTransparency = 1; DroneControls.Visible = false DroneControls.ZIndex = 90
	DroneMenu = Instance.new("Frame", DroneGui) DroneMenu.Size = UDim2.new(0,160,0,260) DroneMenu.Position = UDim2.new(1,-190,0,80) DroneMenu.BackgroundColor3 = Color3.new(0,0,0) DroneMenu.BackgroundTransparency = 0.3 DroneMenu.Visible = false; DroneMenu.ZIndex = 95 Instance.new("UICorner", DroneMenu)
	local function slider(y, label, start, cb) local l = Instance.new("TextLabel", DroneMenu) l.Size = UDim2.new(1,0,0,15); l.Position = UDim2.new(0,0,0,y) l.Text = label; l.TextColor3 = Color3.new(1,1,1) l.BackgroundTransparency = 1; l.TextSize = 11; l.Font = Enum.Font.Code; l.ZIndex = 96 local bar = Instance.new("Frame", DroneMenu) bar.Size = UDim2.new(0.8,0,0,2); bar.Position = UDim2.new(0.1,0,0,y+20) bar.BackgroundColor3 = Color3.new(0.3,0.3,0.3); bar.ZIndex = 96 local k = Instance.new("TextButton", bar) k.Size = UDim2.new(0,24,0,24); k.Position = UDim2.new(start,-12,0.5,-12) k.Text = ""; k.ZIndex = 97 Instance.new("UICorner", k).CornerRadius = UDim.new(1,0) local drag = false k.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true; isInteractingUI = true end end) UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false; isInteractingUI = false end end) RunService.RenderStepped:Connect(function() if drag then local p = math.clamp((UserInputService:GetMouseLocation().X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1) k.Position = UDim2.new(p, -12, 0.5, -12); cb(p) end end) end
	slider(15, "FLY SPEED", 0.3, function(p) droneSpeed = 1 + (200 * p) end) slider(65, "FOV ZOOM", 0.5, function(p) droneFov = 20 + (100 * p) end) slider(115, "VIGNETTE", 0.65, updateVig); updateVig(0.65)
	LightModel = Instance.new("Part") LightModel.Name = "FlashlightModel" LightModel.Transparency = 1; LightModel.Anchored = true LightModel.CanCollide = false; LightModel.Parent = Camera
	CoreLight = Instance.new("SpotLight", LightModel) CoreLight.Brightness = 12; CoreLight.Range = 95 CoreLight.Angle = 20; CoreLight.Enabled = false RingLight = Instance.new("SpotLight", LightModel) RingLight.Brightness = 3; RingLight.Range = 95 RingLight.Angle = 55; RingLight.Enabled = false
	LightBtn = Instance.new("TextButton", DroneMenu) LightBtn.Size = UDim2.new(0.8,0,0,35) LightBtn.Position = UDim2.new(0.1,0,0,170) LightBtn.Text = "LIGHT: OFF"; LightBtn.Font = Enum.Font.Code LightBtn.ZIndex = 98 Instance.new("UICorner", LightBtn)
	LightBtn.Activated:Connect(function() flashlightActive = not flashlightActive CoreLight.Enabled, RingLight.Enabled = flashlightActive, flashlightActive LightBtn.Text = flashlightActive and "LIGHT: ON" or "LIGHT: OFF" end)
	DroneMenuButton = Instance.new("TextButton", DroneGui) DroneMenuButton.Size = UDim2.new(0,45,0,45) DroneMenuButton.Position = UDim2.new(1,-120,0,25) DroneMenuButton.BackgroundColor3 = Color3.new(0,0,0) DroneMenuButton.BackgroundTransparency = 0.25 DroneMenuButton.Text = GEAR_ICON; DroneMenuButton.TextScaled = true DroneMenuButton.ZIndex = 100; DroneMenuButton.Visible = false Instance.new("UICorner", DroneMenuButton).CornerRadius = UDim.new(1,0)
	DroneMenuButton.Activated:Connect(function() if not droneActive then return end DroneMenu.Visible = not DroneMenu.Visible end)
	local function padBtn(pos, txt, vec) local b = Instance.new("TextButton", DroneControls) b.Size = UDim2.new(0,70,0,70); b.Position = pos b.BackgroundColor3 = Color3.new(0,0,0); b.BackgroundTransparency = 0.5 b.TextColor3 = Color3.new(1,1,1); b.Text = txt b.Font = Enum.Font.GothamBold; b.TextScaled = true; b.ZIndex = 91 Instance.new("UICorner", b).CornerRadius = UDim.new(1,0) b.InputBegan:Connect(function(io) if io.UserInputType == Enum.UserInputType.Touch or io.UserInputType == Enum.UserInputType.MouseButton1 then if not activeButtons[txt] then activeButtons[txt] = true; moveVec = moveVec + vec end end end) b.InputEnded:Connect(function() if activeButtons[txt] then activeButtons[txt] = nil; moveVec = moveVec - vec end end) end
	padBtn(UDim2.new(0,90,1,-220), "^", Vector3.new(0,0,-1)) padBtn(UDim2.new(0,90,1,-80), "v", Vector3.new(0,0,1)) padBtn(UDim2.new(0,20,1,-150), "<", Vector3.new(-1,0,0)) padBtn(UDim2.new(0,160,1,-150), ">", Vector3.new(1,0,0))
end

UserInputService.InputChanged:Connect(function(i) if droneActive and i.UserInputType == Enum.UserInputType.Touch and not isInteractingUI then camRot = camRot - Vector2.new(i.Delta.X * 0.4, i.Delta.Y * 0.4) end end)

local function BuildSpideyHUD(skipBoot)
	if guiMain then guiMain:Destroy() end
	lensEdges = {}; cornerBrackets = {}; scanLines = {}; dialSpokes = {}; cursorTicks = {}
	guiMain = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")) guiMain.Name = "SpiderLensHUD" guiMain.ResetOnSpawn = false guiMain.IgnoreGuiInset = true guiMain.Enabled = State.HUDEnabled guiMain.DisplayOrder = 1
	local hudContainer = Instance.new("Frame", guiMain) hudContainer.Name = "HudContainer" hudContainer.Size = UDim2.new(1,0,1,0) hudContainer.BackgroundTransparency = 1 hudContainer.Visible = true hudContainer.Position = UDim2.new(0,0,0,0) hudContainer.ZIndex = 1
	local function createLensEdge(name, position, rotation, color, width, kind) local edge = Instance.new("Frame", hudContainer) edge.Name = name edge:SetAttribute("EdgeKind", kind or "primary") edge.Size = UDim2.new(width,0,1.6,0) edge.Position = position edge.AnchorPoint = Vector2.new(0.5,0.5) edge.Rotation = rotation edge.BackgroundColor3 = color edge.BackgroundTransparency = 0.45 edge.BorderSizePixel = 0; edge.ZIndex = 1 local g = Instance.new("UIGradient", edge) g.Rotation = 90 g.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.5,0),NumberSequenceKeypoint.new(1,1)}) table.insert(lensEdges, edge) return edge end
	createLensEdge("LensEdge1", UDim2.new(-0.04,0,0.5,0), 15, RED, 0.18, "accent") createLensEdge("LensEdge2", UDim2.new(0.04,0,0.5,0), 10, CYAN, 0.12, "primary") createLensEdge("LensEdge3", UDim2.new(1.04,0,0.5,0), -15, RED, 0.18, "accent") createLensEdge("LensEdge4", UDim2.new(0.96,0,0.5,0), -10, CYAN, 0.12, "primary")
	local scanHolder = Instance.new("Frame", hudContainer) scanHolder.Size = UDim2.new(1,0,1,0) scanHolder.BackgroundTransparency = 1; scanHolder.ZIndex = 1 scanHolder.ClipsDescendants = true
	for i = 1, 60 do local line = Instance.new("Frame", scanHolder) line.Name = "ScanLine" .. i line.Size = UDim2.new(1,0,0,1) line.Position = UDim2.new(0,0,0,(i-1)*12) line.BackgroundColor3 = CYAN line.BackgroundTransparency = 0.96 line.BorderSizePixel = 0 table.insert(scanLines, line) end
	local function createCornerBracket(cornerPos, anchor, rot) local holder = Instance.new("Frame", hudContainer) holder.Size = UDim2.new(0,46,0,46) holder.Position = cornerPos holder.AnchorPoint = anchor holder.BackgroundTransparency = 1 holder.Rotation = rot; holder.ZIndex = 3 local h = Instance.new("Frame", holder) h.Name = "CornerH"; h.Size = UDim2.new(0,32,0,3) h.BackgroundColor3 = CYAN; h.BorderSizePixel = 0 local v = Instance.new("Frame", holder) v.Name = "CornerV"; v.Size = UDim2.new(0,3,0,32) v.BackgroundColor3 = CYAN; v.BorderSizePixel = 0 local accent = Instance.new("Frame", holder) accent.Name = "AccentBar" accent.Size = UDim2.new(0,12,0,3) accent.Position = UDim2.new(0,36,0,0) accent.BackgroundColor3 = RED; accent.BorderSizePixel = 0 table.insert(cornerBrackets, holder) return holder end
	createCornerBracket(UDim2.new(0,16,0,16), Vector2.new(0,0), 0) createCornerBracket(UDim2.new(1,-16,0,16), Vector2.new(1,0), 90) createCornerBracket(UDim2.new(1,-16,1,-16), Vector2.new(1,1), 180) createCornerBracket(UDim2.new(0,16,1,-16), Vector2.new(0,1), 270)
	local topBar = Instance.new("Frame", hudContainer) topBar.Name = "TopBar" topBar.Size = UDim2.new(0,480,0,44) topBar.Position = UDim2.new(0.5,0,0.025,0) topBar.AnchorPoint = Vector2.new(0.5,0) topBar.BackgroundColor3 = DARK topBar.BackgroundTransparency = 0.35 topBar.BorderSizePixel = 0; topBar.ZIndex = 3 topBar.Visible = State.CreditVisible Instance.new("UICorner", topBar).CornerRadius = UDim.new(0,6)
	local topStroke = Instance.new("UIStroke", topBar) topStroke.Color = CYAN; topStroke.Transparency = 0.35; topStroke.Thickness = 1 topBarRef = topBar
	local titleLabel = Instance.new("TextLabel", topBar) titleLabel.Size = UDim2.new(1,0,0,22) titleLabel.Position = UDim2.new(0,0,0,2) titleLabel.BackgroundTransparency = 1 titleLabel.Font = Enum.Font.SciFi titleLabel.TextSize = 20; titleLabel.TextColor3 = CYAN titleLabel.Text = "D A R K - S P I D E R M A N" titleLabel.TextStrokeTransparency = 0.55; titleLabel.ZIndex = 3 titleLabelRef = titleLabel
	local subLabel = Instance.new("TextLabel", topBar) subLabel.Size = UDim2.new(1,0,0,16) subLabel.Position = UDim2.new(0,0,0,25) subLabel.BackgroundTransparency = 1 subLabel.Font = Enum.Font.Code subLabel.TextSize = 12; subLabel.TextColor3 = FAINT subLabel.Text = "// SUIT-OS ONLINE // WEB-SHOOTERS ARMED" subLabel.TextTransparency = 0.15; subLabel.ZIndex = 3 subLabelRef = subLabel
	local dialHolder = Instance.new("Frame", hudContainer) dialHolder.Size = UDim2.new(0,110,0,110) dialHolder.Position = UDim2.new(1,-90,0,90) dialHolder.AnchorPoint = Vector2.new(0.5,0.5) dialHolder.BackgroundTransparency = 1; dialHolder.ZIndex = 2
	local dialRing = Instance.new("Frame", dialHolder) dialRing.Size = UDim2.new(1,0,1,0) dialRing.BackgroundTransparency = 1
	local spokeCount = 16
	for i = 1, spokeCount do local angle = (i / spokeCount) * 360 local pivot = Instance.new("Frame", dialRing) pivot.Size = UDim2.new(0,0,0,0) pivot.Position = UDim2.new(0.5,0,0.5,0) pivot.BackgroundTransparency = 1 pivot.Rotation = angle local spoke = Instance.new("Frame", pivot) spoke.Name = "DialSpoke" spoke:SetAttribute("IsAccent", i % 4 == 0) spoke.Size = UDim2.new(0,2,0,14) spoke.AnchorPoint = Vector2.new(0.5,0) spoke.Position = UDim2.new(0,0,0,34) spoke.BackgroundColor3 = (i % 4 == 0) and RED or CYAN spoke.BackgroundTransparency = (i % 4 == 0) and 0.15 or 0.45 spoke.BorderSizePixel = 0 local fade = Instance.new("UIGradient", spoke) fade.Rotation = 90 fade.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)}) table.insert(dialSpokes, spoke) end
	local dialCore = Instance.new("Frame", dialHolder) dialCore.Size = UDim2.new(0,10,0,10) dialCore.AnchorPoint = Vector2.new(0.5,0.5) dialCore.Position = UDim2.new(0.5,0,0.5,0) dialCore.BackgroundColor3 = CYAN Instance.new("UICorner", dialCore).CornerRadius = UDim.new(1,0) dialCoreRef = dialCore
	local dialLabel = Instance.new("TextLabel", dialHolder) dialLabel.Size = UDim2.new(0,90,0,14) dialLabel.AnchorPoint = Vector2.new(0.5,0) dialLabel.Position = UDim2.new(0.5,0,1,2) dialLabel.BackgroundTransparency = 1 dialLabel.Font = Enum.Font.Code dialLabel.TextSize = 11; dialLabel.TextColor3 = FAINT dialLabel.Text = "SCAN"; dialLabelRef = dialLabel
	task.spawn(function() while dialRing and dialRing.Parent do dialRing.Rotation = dialRing.Rotation + 18 * task.wait() end end)
	telemetryLabel = Instance.new("TextLabel", hudContainer) telemetryLabel.Name = "TelemetryLabel" telemetryLabel.Size = UDim2.new(0,220,0,16) telemetryLabel.Position = UDim2.new(1,-148,0,82) telemetryLabel.AnchorPoint = Vector2.new(1,0) telemetryLabel.BackgroundTransparency = 1 telemetryLabel.Font = Enum.Font.Code telemetryLabel.TextSize = 12; telemetryLabel.TextColor3 = CYAN telemetryLabel.TextTransparency = 0.1 telemetryLabel.TextXAlignment = Enum.TextXAlignment.Right telemetryLabel.Text = "VEL 000.0 // ALT 0000" telemetryLabel.ZIndex = 2 telemetryLabel.Visible = State.TelemetryEnabled
	local meterBG = Instance.new("Frame", hudContainer) meterBG.Name = "MeterBG" meterBG.Size = UDim2.new(0,220,0,10) meterBG.Position = UDim2.new(0.5,-110,0.87,0) meterBG.BackgroundColor3 = Color3.fromRGB(8,10,12) meterBG.BorderSizePixel = 0; meterBG.ZIndex = 2 Instance.new("UICorner", meterBG).CornerRadius = UDim.new(0,4)
	local meterStroke = Instance.new("UIStroke", meterBG) meterStroke.Color = CYAN; meterStroke.Transparency = 0.2; meterStroke.Thickness = 1
	ChargeFill = Instance.new("Frame", meterBG) ChargeFill.Size = UDim2.new(0,0,1,0) ChargeFill.BackgroundColor3 = CYAN ChargeFill.BorderSizePixel = 0; ChargeFill.ZIndex = 2 Instance.new("UICorner", ChargeFill).CornerRadius = UDim.new(0,4)
	ChargeFillGradient = Instance.new("UIGradient", ChargeFill) ChargeFillGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(0.15, CYAN),ColorSequenceKeypoint.new(1, CYAN)})
	for i = 1, 10 do local tick = Instance.new("Frame", meterBG) tick.Name = "Tick"; tick.Size = UDim2.new(0,1,1,0) tick.Position = UDim2.new(i/10,0,0,0) tick.BackgroundColor3 = Color3.new(0,0,0) tick.BackgroundTransparency = 0.6 tick.BorderSizePixel = 0; tick.ZIndex = 3 end
	local meterLabel = Instance.new("TextLabel", meterBG) meterLabel.Size = UDim2.new(1,0,0,16) meterLabel.Position = UDim2.new(0,0,0,-18) meterLabel.BackgroundTransparency = 1 meterLabel.Text = "CHARGE LEAP" meterLabel.TextColor3 = CYAN meterLabel.Font = Enum.Font.Code meterLabel.TextSize = 13 meterLabel.TextStrokeTransparency = 0.5 meterLabel.ZIndex = 2 meterLabelRef = meterLabel
	customCursor = Instance.new("Frame", hudContainer) customCursor.Size = UDim2.new(0,28,0,28) customCursor.AnchorPoint = Vector2.new(0.5,0.5) customCursor.BackgroundTransparency = 1 customCursor.ZIndex = 4
	local cursorDot = Instance.new("Frame", customCursor) cursorDot.Size = UDim2.new(0,4,0,4) cursorDot.Position = UDim2.new(0.5,-2,0.5,-2) cursorDot.BackgroundColor3 = CYAN cursorDot.ZIndex = 4 Instance.new("UICorner", cursorDot).CornerRadius = UDim.new(1,0)
	local cRing = Instance.new("UIStroke", customCursor) cRing.Color = CYAN; cRing.Transparency = 0.25; cRing.Thickness = 1.5 Instance.new("UICorner", customCursor).CornerRadius = UDim.new(1,0)
	local tickPositions = {{UDim2.new(0.5,-1,0,0), UDim2.new(0,2,0,6)},{UDim2.new(0.5,-1,1,-6), UDim2.new(0,2,0,6)},{UDim2.new(0,0,0.5,-1), UDim2.new(0,6,0,2)},{UDim2.new(1,-6,0.5,-1), UDim2.new(0,6,0,2)}}
	for _, t in ipairs(tickPositions) do local tick = Instance.new("Frame", customCursor) tick.Position = t[1]; tick.Size = t[2] tick.BackgroundColor3 = RED tick.BorderSizePixel = 0; tick.ZIndex = 4 table.insert(cursorTicks, tick) end
	if skipBoot then return end
	local bootGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")) bootGui.Name = "DarkSpiderBoot" bootGui.ResetOnSpawn = false bootGui.IgnoreGuiInset = true bootGui.DisplayOrder = 999
	local bootScreen = Instance.new("Frame", bootGui) bootScreen.Size = UDim2.new(1,0,1,0) bootScreen.BackgroundColor3 = DARK bootScreen.BorderSizePixel = 0
	local netText = Instance.new("TextLabel", bootScreen) netText.Size = UDim2.new(0,500,0,24) netText.AnchorPoint = Vector2.new(0.5,0.5) netText.Position = UDim2.new(0.5,0,0.42,0) netText.BackgroundTransparency = 1 netText.Font = Enum.Font.Code netText.TextSize = 15; netText.TextColor3 = FAINT netText.Text = "CONNECTING TO GLOBAL NETWORK" netText.TextTransparency = 1
	local progressBG = Instance.new("Frame", bootScreen) progressBG.Size = UDim2.new(0,400,0,4) progressBG.AnchorPoint = Vector2.new(0.5,0.5) progressBG.Position = UDim2.new(0.5,0,0.47,0) progressBG.BackgroundColor3 = Color3.fromRGB(20,20,24) progressBG.BorderSizePixel = 0 progressBG.BackgroundTransparency = 1
	local progressFill = Instance.new("Frame", progressBG) progressFill.Size = UDim2.new(0,0,1,0) progressFill.BackgroundColor3 = CYAN progressFill.BorderSizePixel = 0
	local titleStamp = Instance.new("TextLabel", bootScreen) titleStamp.Size = UDim2.new(0,800,0,60) titleStamp.AnchorPoint = Vector2.new(0.5,0.5) titleStamp.Position = UDim2.new(0.5,0,0.55,0) titleStamp.BackgroundTransparency = 1 titleStamp.Font = Enum.Font.SciFi titleStamp.TextSize = 42; titleStamp.TextColor3 = CYAN titleStamp.Text = "DARK-SPIDERMAN" titleStamp.TextTransparency = 1 titleStamp.TextStrokeTransparency = 0.4
	local creditLabel = Instance.new("TextLabel", bootScreen) creditLabel.Size = UDim2.new(0,600,0,18) creditLabel.AnchorPoint = Vector2.new(0.5,0.5) creditLabel.Position = UDim2.new(0.5,0,0.55,40) creditLabel.BackgroundTransparency = 1 creditLabel.Font = Enum.Font.Code creditLabel.TextSize = 14; creditLabel.TextColor3 = FAINT creditLabel.Text = "Made By Sp1derman_947" creditLabel.TextTransparency = 1
	task.spawn(function()
		pcall(function() local bootSound = Instance.new("Sound") bootSound.SoundId = "rbxassetid://108203940019122" bootSound.Volume = 1.0 bootSound.Parent = bootScreen bootSound:Play() Debris:AddItem(bootSound, 6) end)
		TweenService:Create(netText, TweenInfo.new(0.5), {TextTransparency = 0}):Play() progressBG.BackgroundTransparency = 0.5 TweenService:Create(progressFill, TweenInfo.new(0.9, Enum.EasingStyle.Quad), {Size = UDim2.new(1,0,1,0)}):Play() task.wait(1.0)
		TweenService:Create(titleStamp, TweenInfo.new(0.4), {TextTransparency = 0}):Play() TweenService:Create(creditLabel, TweenInfo.new(0.4), {TextTransparency = 0.1}):Play() task.wait(0.6)
		TweenService:Create(netText, TweenInfo.new(0.4), {TextTransparency = 1}):Play() TweenService:Create(progressBG, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play() TweenService:Create(progressFill, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play() task.wait(0.5)
		TweenService:Create(titleStamp, TweenInfo.new(0.5), {TextTransparency = 1}):Play() TweenService:Create(creditLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play() task.wait(0.3)
		TweenService:Create(bootScreen, TweenInfo.new(0.7), {BackgroundTransparency = 1}):Play() task.wait(0.7) bootGui:Destroy()
	end)
end

local function showToast(msg, isOn)
	if not mobileHolder then return end
	local toast = Instance.new("TextLabel", mobileHolder) toast.Size = UDim2.new(0, 280, 0, 34) toast.Position = UDim2.new(0.5, 0, 0, 75) toast.AnchorPoint = Vector2.new(0.5, 0) toast.BackgroundColor3 = Color3.fromRGB(15, 22, 32) toast.BackgroundTransparency = 1 toast.BorderSizePixel = 0 toast.Font = Enum.Font.GothamBold toast.TextSize = 13 toast.TextColor3 = isOn and Color3.fromRGB(60, 255, 100) or Color3.fromRGB(255, 80, 80) toast.Text = msg toast.TextTransparency = 1 toast.ZIndex = 100 Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 8)
	local stroke = Instance.new("UIStroke", toast) stroke.Color = isOn and Color3.fromRGB(60, 255, 100) or Color3.fromRGB(255, 80, 80) stroke.Thickness = 1.5 stroke.Transparency = 1
	TweenService:Create(toast, TweenInfo.new(0.2), {TextTransparency = 0, BackgroundTransparency = 0.1}):Play() TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0.2}):Play()
	task.delay(1.4, function() if toast and toast.Parent then TweenService:Create(toast, TweenInfo.new(0.3), {TextTransparency = 1, BackgroundTransparency = 1}):Play() TweenService:Create(stroke, TweenInfo.new(0.3), {Transparency = 1}):Play() task.wait(0.35) if toast and toast.Parent then toast:Destroy() end end end)
end

local function BuildMobileControls(parent)
	if mobileHolder then mobileHolder:Destroy() end
	allButtonsList = {} buttonRefs = {} wallClimbBtnRef = nil wallClimbStrokeRef = nil wingBtnRef = nil emoteBtnRef = nil
	mobileHolder = Instance.new("Frame", parent) mobileHolder.Name = "MobileControls" mobileHolder.Size = UDim2.new(1,0,1,0) mobileHolder.BackgroundTransparency = 1 mobileHolder.Visible = State.MenuVisible mobileHolder.ZIndex = 5
	mobileScale = Instance.new("UIScale", mobileHolder) mobileScale.Scale = State.ButtonScale
	CreateCrosshair(parent) CreateLeapBar(parent)
	local swingBtn = CreateGlassButton(mobileHolder, UDim2.new(0,70,0,70), UDim2.new(1,-20,1,-120), Vector2.new(1,1), "", SPIDER_SWING_IMAGE_ID, "swing")
	swingBtn.InputBegan:Connect(function(input) if State.DraggableButtons then return end if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then PerformWebSwingBegin() end end)
	swingBtn.InputEnded:Connect(function(input) if State.DraggableButtons then return end if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then PerformWebSwingEnd() end end)
	local zipBtn = CreateGlassButton(mobileHolder, UDim2.new(0,70,0,70), UDim2.new(1,-125,1,-20), Vector2.new(1,1), "", SPIDER_ZIP_IMAGE_ID, "zip")
	zipBtn.MouseButton1Down:Connect(function() if State.DraggableButtons then return end ExecuteWebZip() end)
	local leapBtn = CreateGlassButton(mobileHolder, UDim2.new(0,70,0,70), UDim2.new(1,-20,1,-205), Vector2.new(1,1), "", SPIDER_LEAP_IMAGE_ID, "leap")
	leapBtn.InputBegan:Connect(function(input) if State.DraggableButtons then return end if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then PerformLeapBegin() end end)
	leapBtn.InputEnded:Connect(function(input) if State.DraggableButtons then return end if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then PerformLeapEnd() end end)
	local slingBtn = CreateGlassButton(mobileHolder, UDim2.new(0,70,0,70), UDim2.new(1,-125,1,-100), Vector2.new(1,1), "", SPIDER_SLING_IMAGE_ID, "sling")
	slingBtn.MouseButton1Click:Connect(function() if State.DraggableButtons then return end PerformSlingshotToggle() end)
	local parachuteBtn, parachuteStroke = CreateGlassButton(mobileHolder, UDim2.new(0,70,0,70), UDim2.new(1,-205,1,-20), Vector2.new(1,1), "", SPIDER_PARACHUTE_IMAGE_ID, "parachute")
	local function RefreshParachuteButton() parachuteStroke.Color = State.Parachuting and CYAN or FAINT end
	RefreshParachuteButton() parachuteBtn.MouseButton1Click:Connect(function() if State.DraggableButtons then return end ToggleParachute() RefreshParachuteButton() end)
	DroneButton = CreateGlassButton(mobileHolder, UDim2.new(0,60,0,60), UDim2.new(1,-205,1,-100), Vector2.new(1,1), "", SPIDER_DRONE_IMAGE_ID, "drone")
	DroneButton.Visible = State.DronesEnabled DroneButton.MouseButton1Click:Connect(function() if State.DraggableButtons then return end ToggleDrone() end)
	local shootBtn, shootStroke = CreateGlassButton(mobileHolder, UDim2.new(0,55,0,55), UDim2.new(0,20,1,-20), Vector2.new(0,1), "WEB", nil, "shoot")
	local function refreshShootBtn() shootStroke.Color = State.WebShootersEnabled and CYAN or RED end
	refreshShootBtn() shootBtn.MouseButton1Click:Connect(function() if State.DraggableButtons then return end ToggleShootersAction() refreshShootBtn() end)
	local lockBtn, lockStroke = CreateGlassButton(mobileHolder, UDim2.new(0,55,0,55), UDim2.new(0,20,1,-85), Vector2.new(0,1), "LOCK", nil, "lock")
	local function refreshLockBtn() lockStroke.Color = State.ShiftLockEnabled and CYAN or RED end
	refreshLockBtn() lockBtn.MouseButton1Click:Connect(function() if State.DraggableButtons then return end ToggleShiftLockAction() refreshLockBtn() end)
	local espBtn, espStroke = CreateGlassButton(mobileHolder, UDim2.new(0,55,0,55), UDim2.new(0,20,1,-150), Vector2.new(0,1), "", SPIDER_ESP_IMAGE_ID, "esp")
	local function refreshEspBtn() espStroke.Color = State.EspEnabled and CYAN or RED end
	refreshEspBtn() espBtn.MouseButton1Click:Connect(function() if State.DraggableButtons then return end State.EspEnabled = not State.EspEnabled if State.EspEnabled then if espSoundInstance then espSoundInstance:Stop() espSoundInstance:Destroy() espSoundInstance = nil end espSoundInstance = Instance.new("Sound") espSoundInstance.Name = "SpiderEspSound" espSoundInstance.SoundId = ESP_SOUND espSoundInstance.Volume = 2 espSoundInstance.Looped = false espSoundInstance.Parent = RootPart or workspace espSoundInstance:Play() else if espSoundInstance then espSoundInstance:Stop() espSoundInstance:Destroy() espSoundInstance = nil end end refreshEspBtn() end)
	local xrayBtn, xrayStroke = CreateGlassButton(mobileHolder, UDim2.new(0,55,0,55), UDim2.new(0,20,1,-215), Vector2.new(0,1), XRAY_ICON, nil, "xray")
	xrayBtnRef = xrayBtn xrayBtn.Visible = State.XrayButtonVisible
	local function refreshXrayBtn() xrayStroke.Color = State.XrayEnabled and CYAN or RED end
	refreshXrayBtn() xrayBtn.MouseButton1Click:Connect(function() if State.DraggableButtons then return end SetXray(not State.XrayEnabled) refreshXrayBtn() end)
	local wallClimbBtn, wallClimbStroke = CreateGlassButton(mobileHolder, UDim2.new(0,55,0,55), UDim2.new(0,20,1,-280), Vector2.new(0,1), "", WALL_CLIMB_ICON, "wallclimb")
	wallClimbBtnRef = wallClimbBtn wallClimbStrokeRef = wallClimbStroke wallClimbBtn.Visible = State.WallClimbEnabled
	local function refreshWallClimbBtn() if climbEnabled then wallClimbStroke.Color = Color3.fromRGB(60, 255, 100) else wallClimbStroke.Color = RED end end
	refreshWallClimbBtn() wallClimbBtn.MouseButton1Click:Connect(function() if State.DraggableButtons then return end climbEnabled = not climbEnabled refreshWallClimbBtn() if climbEnabled then if getClimbSurface() then startClimb() end showToast("WALL CLIMB: " .. T("on"), true) else stopClimb() showToast("WALL CLIMB: " .. T("off"), false) end end)
	local emoteBtn = CreateGlassButton(mobileHolder, UDim2.new(0,55,0,55), UDim2.new(0,20,1,-345), Vector2.new(0,1), "", EMOTE_ICON, "emote")
	emoteBtnRef = emoteBtn emoteBtn.Visible = State.EmoteEnabled
	emoteBtn.MouseButton1Click:Connect(function() if State.DraggableButtons then return end StartHang() end)
	local wingBtn = CreateGlassButton(mobileHolder, UDim2.new(0,55,0,55), UDim2.new(0, 20, 0.5, 35), Vector2.new(0, 0.5), "", WEB_WING_ICON, "wing")
	wingBtnRef = wingBtn wingBtn.Visible = State.WebWingsEnabled
	wingBtn.MouseButton1Click:Connect(function() if State.DraggableButtons then return end if State.IsGliding then StopWebWings() showToast("WEB WINGS: OFF", false) else if Humanoid and (Humanoid:GetState() == Enum.HumanoidStateType.Freefall or Humanoid:GetState() == Enum.HumanoidStateType.Jumping) then StartWebWings() showToast("WEB WINGS: ON", true) else showToast("PULE PRIMEIRO!", false) end end end)
	local configBtn = CreateGlassButton(mobileHolder, UDim2.new(0,45,0,45), UDim2.new(0.5,0,0,15), Vector2.new(0.5,0), GEAR_ICON, nil, "config")
	configBtnRef = configBtn
	local configPanel = Instance.new("ScrollingFrame", mobileHolder) configPanel.Size = UDim2.new(0, 230, 0, 420) configPanel.Position = UDim2.new(0.5, 0, 0, 70) configPanel.AnchorPoint = Vector2.new(0.5, 0) configPanel.BackgroundColor3 = DARK configPanel.BackgroundTransparency = 0.15 configPanel.BorderSizePixel = 0 configPanel.Visible = false configPanel.ZIndex = 10 configPanel.CanvasSize = UDim2.new(0, 0, 0, 1500) configPanel.ScrollingDirection = Enum.ScrollingDirection.Y configPanel.ScrollBarThickness = 5 configPanel.ScrollBarImageColor3 = CYAN configPanel.Active = true configPanel.ClipsDescendants = true Instance.new("UICorner", configPanel).CornerRadius = UDim.new(0, 10) configPanelRef = configPanel
	local cfgStroke = Instance.new("UIStroke", configPanel) cfgStroke.Color = CYAN cfgStroke.Thickness = 1.5
	local cfgTitle = Instance.new("TextLabel", configPanel) cfgTitle.Size = UDim2.new(1, 0, 0, 30) cfgTitle.BackgroundTransparency = 1 cfgTitle.Font = Enum.Font.GothamBold cfgTitle.TextSize = 14 cfgTitle.TextColor3 = CYAN cfgTitle.Text = T("config") cfgTitle.ZIndex = 11
	local configUpdaters = {}
	local langTitle = Instance.new("TextLabel", configPanel) langTitle.Size = UDim2.new(1, 0, 0, 16) langTitle.Position = UDim2.new(0, 0, 0, 33) langTitle.BackgroundTransparency = 1 langTitle.Font = Enum.Font.GothamBold langTitle.TextSize = 10 langTitle.TextColor3 = FAINT langTitle.Text = "▎ " .. T("lang_sec") langTitle.TextXAlignment = Enum.TextXAlignment.Left langTitle.ZIndex = 11
	local langRow = Instance.new("Frame", configPanel) langRow.Size = UDim2.new(0.9, 0, 0, 26) langRow.Position = UDim2.new(0.05, 0, 0, 52) langRow.BackgroundTransparency = 1 langRow.ZIndex = 11
	local langLayout = Instance.new("UIListLayout", langRow) langLayout.FillDirection = Enum.FillDirection.Horizontal langLayout.Padding = UDim.new(0, 4) langLayout.SortOrder = Enum.SortOrder.LayoutOrder
	local flagBtns = {}
	local function refreshFlags() for _, e in ipairs(flagBtns) do e.btn.BackgroundColor3 = (State.Language == e.code) and Color3.fromRGB(40, 55, 75) or Color3.fromRGB(25, 30, 40) e.btn.TextColor3 = (State.Language == e.code) and CYAN or FAINT end end
	local applyLanguage
	for _, lang in ipairs(LANGUAGES) do local b = Instance.new("TextButton", langRow) b.Size = UDim2.new(0, 32, 1, 0) b.BackgroundColor3 = Color3.fromRGB(25, 30, 40) b.Font = Enum.Font.GothamBold b.TextSize = 16 b.TextColor3 = FAINT b.Text = lang.flag b.LayoutOrder = #flagBtns b.ZIndex = 12 Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5) table.insert(flagBtns, {btn = b, code = lang.code}) b.MouseButton1Click:Connect(function() State.Language = lang.code refreshFlags() applyLanguage() end) end
	refreshFlags()
	local function createToggleCfg(textKey, posY, defaultVal, onClick) local btn = Instance.new("TextButton", configPanel) btn.Size = UDim2.new(0.9, 0, 0, 30) btn.Position = UDim2.new(0.05, 0, 0, posY) btn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) btn.Font = Enum.Font.Gotham btn.TextSize = 11 btn.ZIndex = 11 Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6) local active = defaultVal local function update() btn.Text = T(textKey) .. ": " .. (active and T("on") or T("off")) btn.TextColor3 = active and CYAN or RED end update() table.insert(configUpdaters, update) btn.MouseButton1Click:Connect(function() active = not active update() onClick(active) end) return btn end
	createToggleCfg("drag", 88, State.DraggableButtons, function(v) State.DraggableButtons = v end)
	createToggleCfg("transparency", 123, State.ButtonsTransparent, function(v) State.ButtonsTransparent = v RefreshButtonsTransparency() end)
	createToggleCfg("crosshair", 158, State.CrosshairEnabled, function(v) State.CrosshairEnabled = v if crosshairFrame then crosshairFrame.Visible = v end end)
	createToggleCfg("drones", 193, State.DronesEnabled, function(v) SetDroneEnabled(v) ApplyHideButtons() end)
	local r6ToggleBtn = Instance.new("TextButton", configPanel) r6ToggleBtn.Size = UDim2.new(0.9, 0, 0, 30) r6ToggleBtn.Position = UDim2.new(0.05, 0, 0, 228) r6ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) r6ToggleBtn.Font = Enum.Font.GothamBold r6ToggleBtn.TextSize = 11 r6ToggleBtn.ZIndex = 11 Instance.new("UICorner", r6ToggleBtn).CornerRadius = UDim.new(0, 6)
	local function updateR6ToggleBtn() r6ToggleBtn.Text = T("r6") .. ": " .. (State.R6Mode and T("on") or T("off")) r6ToggleBtn.TextColor3 = State.R6Mode and CYAN or RED end
	updateR6ToggleBtn() table.insert(configUpdaters, updateR6ToggleBtn) r6ToggleBtn.MouseButton1Click:Connect(function() State.R6Mode = not State.R6Mode clearIK() updateR6ToggleBtn() end)
	local symbioteBtn = Instance.new("TextButton", configPanel) symbioteBtn.Size = UDim2.new(0.9, 0, 0, 30) symbioteBtn.Position = UDim2.new(0.05, 0, 0, 263) symbioteBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) symbioteBtn.Font = Enum.Font.GothamBold symbioteBtn.TextSize = 11 symbioteBtn.ZIndex = 11 Instance.new("UICorner", symbioteBtn).CornerRadius = UDim.new(0, 6)
	local function updateSymbioteBtn() symbioteBtn.Text = T("symbiote") .. ": " .. (State.SymbioteEnabled and T("on") or T("off")) symbioteBtn.TextColor3 = State.SymbioteEnabled and CYAN or RED end
	updateSymbioteBtn() table.insert(configUpdaters, updateSymbioteBtn) symbioteBtn.MouseButton1Click:Connect(function() State.SymbioteEnabled = not State.SymbioteEnabled updateSymbioteBtn() task.spawn(function() ApplySymbioteVisuals() end) end)
	local keepOrigBtn = Instance.new("TextButton", configPanel) keepOrigBtn.Size = UDim2.new(0.9, 0, 0, 30) keepOrigBtn.Position = UDim2.new(0.05, 0, 0, 298) keepOrigBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) keepOrigBtn.Font = Enum.Font.GothamBold keepOrigBtn.TextSize = 11 keepOrigBtn.ZIndex = 11 Instance.new("UICorner", keepOrigBtn).CornerRadius = UDim.new(0, 6)
	local function updateKeepOrigBtn() keepOrigBtn.Text = T("keep_orig") .. ": " .. (State.SymbioteKeepOrigButtons and T("on") or T("off")) keepOrigBtn.TextColor3 = State.SymbioteKeepOrigButtons and CYAN or RED end
	updateKeepOrigBtn() table.insert(configUpdaters, updateKeepOrigBtn) keepOrigBtn.MouseButton1Click:Connect(function() State.SymbioteKeepOrigButtons = not State.SymbioteKeepOrigButtons updateKeepOrigBtn() task.spawn(function() ApplySymbioteVisuals() end) end)
	local xrayToggleBtn = Instance.new("TextButton", configPanel) xrayToggleBtn.Size = UDim2.new(0.9, 0, 0, 30) xrayToggleBtn.Position = UDim2.new(0.05, 0, 0, 333) xrayToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) xrayToggleBtn.Font = Enum.Font.GothamBold xrayToggleBtn.TextSize = 11 xrayToggleBtn.ZIndex = 11 Instance.new("UICorner", xrayToggleBtn).CornerRadius = UDim.new(0, 6)
	local function updateXrayToggleBtn() xrayToggleBtn.Text = T("xray_btn") .. ": " .. (State.XrayButtonVisible and T("on") or T("off")) xrayToggleBtn.TextColor3 = State.XrayButtonVisible and CYAN or RED end
	updateXrayToggleBtn() table.insert(configUpdaters, updateXrayToggleBtn) xrayToggleBtn.MouseButton1Click:Connect(function() State.XrayButtonVisible = not State.XrayButtonVisible ApplyHideButtons() updateXrayToggleBtn() end)
	local hudBtn = Instance.new("TextButton", configPanel) hudBtn.Size = UDim2.new(0.9, 0, 0, 30) hudBtn.Position = UDim2.new(0.05, 0, 0, 368) hudBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) hudBtn.Font = Enum.Font.GothamBold hudBtn.TextSize = 11 hudBtn.ZIndex = 11 Instance.new("UICorner", hudBtn).CornerRadius = UDim.new(0, 6)
	local function updateHudBtn() hudBtn.Text = T("hud") .. ": " .. (State.HUDEnabled and T("on") or T("off")) hudBtn.TextColor3 = State.HUDEnabled and CYAN or RED end
	updateHudBtn() table.insert(configUpdaters, updateHudBtn) hudBtn.MouseButton1Click:Connect(function() State.HUDEnabled = not State.HUDEnabled if guiMain then guiMain.Enabled = State.HUDEnabled end if leapBarContainer then if State.HUDEnabled then leapBarContainer.Visible = false else leapBarContainer.Visible = State.IsCharging or State.IsSlingshotting end end updateHudBtn() end)
	local teleBtn = Instance.new("TextButton", configPanel) teleBtn.Size = UDim2.new(0.9, 0, 0, 30) teleBtn.Position = UDim2.new(0.05, 0, 0, 403) teleBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) teleBtn.Font = Enum.Font.GothamBold teleBtn.TextSize = 11 teleBtn.ZIndex = 11 Instance.new("UICorner", teleBtn).CornerRadius = UDim.new(0, 6)
	local function updateTeleBtn() teleBtn.Text = T("telemetry") .. ": " .. (State.TelemetryEnabled and T("on") or T("off")) teleBtn.TextColor3 = State.TelemetryEnabled and CYAN or RED end
	updateTeleBtn() table.insert(configUpdaters, updateTeleBtn) teleBtn.MouseButton1Click:Connect(function() State.TelemetryEnabled = not State.TelemetryEnabled if telemetryLabel then telemetryLabel.Visible = State.TelemetryEnabled end updateTeleBtn() end)
	local creditBtn = Instance.new("TextButton", configPanel) creditBtn.Size = UDim2.new(0.9, 0, 0, 30) creditBtn.Position = UDim2.new(0.05, 0, 0, 438) creditBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) creditBtn.Font = Enum.Font.GothamBold creditBtn.TextSize = 11 creditBtn.ZIndex = 11 Instance.new("UICorner", creditBtn).CornerRadius = UDim.new(0, 6)
	local function updateCreditBtn() creditBtn.Text = T("credit") .. ": " .. (State.CreditVisible and T("on") or T("off")) creditBtn.TextColor3 = State.CreditVisible and CYAN or RED end
	updateCreditBtn() table.insert(configUpdaters, updateCreditBtn) creditBtn.MouseButton1Click:Connect(function() State.CreditVisible = not State.CreditVisible if topBarRef then topBarRef.Visible = State.CreditVisible end updateCreditBtn() end)
	local hideBtn = Instance.new("TextButton", configPanel) hideBtn.Size = UDim2.new(0.9, 0, 0, 30) hideBtn.Position = UDim2.new(0.05, 0, 0, 473) hideBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) hideBtn.Font = Enum.Font.GothamBold hideBtn.TextSize = 11 hideBtn.ZIndex = 11 Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0, 6)
	local function updateHideBtn() hideBtn.Text = T("hide") .. ": " .. (State.HideButtons and T("on") or T("off")) hideBtn.TextColor3 = State.HideButtons and CYAN or RED end
	updateHideBtn() table.insert(configUpdaters, updateHideBtn) hideBtn.MouseButton1Click:Connect(function() State.HideButtons = not State.HideButtons updateHideBtn() ApplyHideButtons() end)
	local trailsBtn = Instance.new("TextButton", configPanel) trailsBtn.Size = UDim2.new(0.9, 0, 0, 30) trailsBtn.Position = UDim2.new(0.05, 0, 0, 508) trailsBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) trailsBtn.Font = Enum.Font.GothamBold trailsBtn.TextSize = 11 trailsBtn.ZIndex = 11 Instance.new("UICorner", trailsBtn).CornerRadius = UDim.new(0, 6)
	local function updateTrailsBtn() trailsBtn.Text = T("trails") .. ": " .. (State.TrailsEnabled and T("on") or T("off")) trailsBtn.TextColor3 = State.TrailsEnabled and CYAN or RED end
	updateTrailsBtn() table.insert(configUpdaters, updateTrailsBtn) trailsBtn.MouseButton1Click:Connect(function() State.TrailsEnabled = not State.TrailsEnabled updateTrailsBtn() ApplyTrailsState() end)
	local wallClimbToggleBtn = Instance.new("TextButton", configPanel) wallClimbToggleBtn.Size = UDim2.new(0.9, 0, 0, 30) wallClimbToggleBtn.Position = UDim2.new(0.05, 0, 0, 543) wallClimbToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) wallClimbToggleBtn.Font = Enum.Font.GothamBold wallClimbToggleBtn.TextSize = 11 wallClimbToggleBtn.ZIndex = 11 Instance.new("UICorner", wallClimbToggleBtn).CornerRadius = UDim.new(0, 6)
	local function updateWallClimbToggle() wallClimbToggleBtn.Text = T("wall_climb") .. ": " .. (State.WallClimbEnabled and T("on") or T("off")) wallClimbToggleBtn.TextColor3 = State.WallClimbEnabled and CYAN or RED end
	updateWallClimbToggle() table.insert(configUpdaters, updateWallClimbToggle) wallClimbToggleBtn.MouseButton1Click:Connect(function() State.WallClimbEnabled = not State.WallClimbEnabled updateWallClimbToggle() if wallClimbBtnRef then wallClimbBtnRef.Visible = State.WallClimbEnabled and not State.HideButtons end if not State.WallClimbEnabled then climbEnabled = false stopClimb() if wallClimbStrokeRef then wallClimbStrokeRef.Color = RED end end ApplyHideButtons() end)
	createToggleCfg("web_wings", 578, State.WebWingsEnabled, function(v) State.WebWingsEnabled = v if wingBtnRef then wingBtnRef.Visible = v and not State.HideButtons end if not v and State.IsGliding then StopWebWings() end if wingSpeedFrame then wingSpeedFrame.Visible = v end end)
	
	local emoteToggleBtn = Instance.new("TextButton", configPanel) emoteToggleBtn.Size = UDim2.new(0.9, 0, 0, 30) emoteToggleBtn.Position = UDim2.new(0.05, 0, 0, 613) emoteToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) emoteToggleBtn.Font = Enum.Font.GothamBold emoteToggleBtn.TextSize = 11 emoteToggleBtn.ZIndex = 11 Instance.new("UICorner", emoteToggleBtn).CornerRadius = UDim.new(0, 6)
	local function updateEmoteToggle() emoteToggleBtn.Text = T("emote_toggle") .. ": " .. (State.EmoteEnabled and T("on") or T("off")) emoteToggleBtn.TextColor3 = State.EmoteEnabled and CYAN or RED end
	updateEmoteToggle() table.insert(configUpdaters, updateEmoteToggle) emoteToggleBtn.MouseButton1Click:Connect(function() State.EmoteEnabled = not State.EmoteEnabled updateEmoteToggle() if emoteBtnRef then emoteBtnRef.Visible = State.EmoteEnabled and not State.HideButtons end ApplyHideButtons() end)

	local sizeLabel = Instance.new("TextLabel", configPanel) sizeLabel.Size = UDim2.new(1, 0, 0, 20) sizeLabel.Position = UDim2.new(0, 0, 0, 648) sizeLabel.BackgroundTransparency = 1 sizeLabel.Font = Enum.Font.Gotham sizeLabel.TextSize = 11 sizeLabel.TextColor3 = FAINT sizeLabel.Text = T("size") .. ": " .. math.floor(State.ButtonScale * 100) .. "%" sizeLabel.ZIndex = 11
	local function updateSizeLabel() sizeLabel.Text = T("size") .. ": " .. math.floor(State.ButtonScale * 100) .. "%" end
	table.insert(configUpdaters, updateSizeLabel)
	local minusBtn = Instance.new("TextButton", configPanel) minusBtn.Size = UDim2.new(0, 40, 0, 22) minusBtn.Position = UDim2.new(0.2, 0, 0, 673) minusBtn.Text = "-" minusBtn.Font = Enum.Font.GothamBold minusBtn.TextColor3 = CYAN minusBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) minusBtn.ZIndex = 11 Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 4)
	local plusBtn = Instance.new("TextButton", configPanel) plusBtn.Size = UDim2.new(0, 40, 0, 22) plusBtn.Position = UDim2.new(0.6, 0, 0, 673) plusBtn.Text = "+" plusBtn.Font = Enum.Font.GothamBold plusBtn.TextColor3 = CYAN plusBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) plusBtn.ZIndex = 11 Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 4)
	local function applyScale(delta) State.ButtonScale = math.clamp(State.ButtonScale + delta, 0.7, 1.3) mobileScale.Scale = State.ButtonScale updateSizeLabel() end
	minusBtn.MouseButton1Click:Connect(function() applyScale(-0.1) end) plusBtn.MouseButton1Click:Connect(function() applyScale(0.1) end)
	local webModeTitle = Instance.new("TextLabel", configPanel) webModeTitle.Size = UDim2.new(1, 0, 0, 20) webModeTitle.Position = UDim2.new(0, 0, 0, 708) webModeTitle.BackgroundTransparency = 1 webModeTitle.Font = Enum.Font.GothamBold webModeTitle.TextSize = 11 webModeTitle.TextColor3 = FAINT webModeTitle.Text = T("web_arm") webModeTitle.ZIndex = 11 table.insert(configUpdaters, function() webModeTitle.Text = T("web_arm") end)
	local leftBtn = Instance.new("TextButton", configPanel) leftBtn.Size = UDim2.new(0.9, 0, 0, 30) leftBtn.Position = UDim2.new(0.05, 0, 0, 733) leftBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) leftBtn.Font = Enum.Font.Gotham leftBtn.TextSize = 11 leftBtn.ZIndex = 11 Instance.new("UICorner", leftBtn).CornerRadius = UDim.new(0, 6)
	local bothBtn = Instance.new("TextButton", configPanel) bothBtn.Size = UDim2.new(0.9, 0, 0, 30) bothBtn.Position = UDim2.new(0.05, 0, 0, 768) bothBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 40) bothBtn.Font = Enum.Font.Gotham bothBtn.TextSize = 11 bothBtn.ZIndex = 11 Instance.new("UICorner", bothBtn).CornerRadius = UDim.new(0, 6)
	swingSpeedFrame = Instance.new("Frame", configPanel) swingSpeedFrame.Size = UDim2.new(0.9, 0, 0, 70) swingSpeedFrame.Position = UDim2.new(0.05, 0, 0, 808) swingSpeedFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 40) swingSpeedFrame.Visible = false swingSpeedFrame.ZIndex = 11 Instance.new("UICorner", swingSpeedFrame).CornerRadius = UDim.new(0, 6)
	swingSpeedLabel = Instance.new("TextLabel", swingSpeedFrame) swingSpeedLabel.Size = UDim2.new(1, 0, 0, 18) swingSpeedLabel.Position = UDim2.new(0, 0, 0, 4) swingSpeedLabel.BackgroundTransparency = 1 swingSpeedLabel.Font = Enum.Font.Gotham swingSpeedLabel.TextSize = 11 swingSpeedLabel.TextColor3 = CYAN swingSpeedLabel.Text = T("swing_speed") .. ": " .. math.floor(State.SwingSpeed) swingSpeedLabel.ZIndex = 12
	local barBg = Instance.new("Frame", swingSpeedFrame) barBg.Size = UDim2.new(0.85, 0, 0, 6) barBg.Position = UDim2.new(0.075, 0, 0, 28) barBg.BackgroundColor3 = Color3.fromRGB(50, 55, 65) barBg.BorderSizePixel = 0 barBg.ZIndex = 12 Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)
	swingSpeedBar = Instance.new("Frame", barBg) swingSpeedBar.Size = UDim2.new(0, 0, 1, 0) swingSpeedBar.BackgroundColor3 = CYAN swingSpeedBar.BorderSizePixel = 0 swingSpeedBar.ZIndex = 13 Instance.new("UICorner", swingSpeedBar).CornerRadius = UDim.new(1, 0)
	swingSpeedKnob = Instance.new("TextButton", barBg) swingSpeedKnob.Size = UDim2.new(0, 18, 0, 18) swingSpeedKnob.Position = UDim2.new(0, -9, 0.5, -9) swingSpeedKnob.BackgroundColor3 = CYAN swingSpeedKnob.Text = "" swingSpeedKnob.ZIndex = 14 swingSpeedKnob.AutoButtonColor = false Instance.new("UICorner", swingSpeedKnob).CornerRadius = UDim.new(1, 0)
	restoreSpeedBtn = Instance.new("TextButton", swingSpeedFrame) restoreSpeedBtn.Size = UDim2.new(0.85, 0, 0, 22) restoreSpeedBtn.Position = UDim2.new(0.075, 0, 0, 42) restoreSpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 55) restoreSpeedBtn.Font = Enum.Font.Gotham restoreSpeedBtn.TextSize = 11 restoreSpeedBtn.TextColor3 = FAINT restoreSpeedBtn.Text = T("restore") restoreSpeedBtn.ZIndex = 12 Instance.new("UICorner", restoreSpeedBtn).CornerRadius = UDim.new(0, 4) table.insert(configUpdaters, function() restoreSpeedBtn.Text = T("restore") end)
	local isDraggingSpeed = false
	local function UpdateSwingSpeedVisual() local percent = math.clamp((State.SwingSpeed - State.DefaultSwingSpeed) / (State.MaxSwingSpeed - State.DefaultSwingSpeed), 0, 1) swingSpeedBar.Size = UDim2.new(percent, 0, 1, 0) swingSpeedKnob.Position = UDim2.new(percent, -9, 0.5, -9) swingSpeedLabel.Text = T("swing_speed") .. ": " .. math.floor(State.SwingSpeed) end
	UpdateSwingSpeedVisual()
	sw ingSpeedKnob.Input0Began:Connect(function(input) if wing State.SwingWebMode ~= "Both" then return endBar if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDraBgggingSpeed = true end end)
	UserInputService.Input.ZEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDraggingSpeed = false end end)
	UserInputService.InputChanged:Connect(function(input) if not isDraggingSpeed or State.SwingWebMode ~= "Both" then return end if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then local percent = math.clamp((input.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1) State.SwingSpeed = State.DefaultSwingSpeed + percent * (State.MaxSwingSpeed - State.DefaultSwingSpeed) UpdateSwingSpeedVisual() end end)
	restoreSpeedBtn.MouseButton1Click:Connect(function() if State.SwingWebMode ~= "Both" then return end State.SwingSpeed = State.DefaultSwingSpeed UpdateSwingSpeedVisual() end)

	wingSpeedFrame = Instance.new("Frame", configPanel) wingSpeedFrame.Size = UDim2.new(0.9, 0, 0, 70) wingSpeedFrame.Position = UDim2.new(0.05, 0, 0, 888) wingSpeedFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 40) wingSpeedFrame.Visible = State.WebWingsEnabled wingSpeedFrame.ZIndex = 11 Instance.new("UICorner", wingSpeedFrame).CornerRadius = UDim.new(0, 6)
	wingSpeedLabel = Instance.new("TextLabel", wingSpeedFrame) wingSpeedLabel.Size = UDim2.new(1, 0, 0, 18) wingSpeedLabel.Position = UDim2.new(0, 0, 0, 4) wingSpeedLabel.BackgroundTransparency = 1 wingSpeedLabel.Font = Enum.Font.Gotham wingSpeedLabel.TextSize = 11 wingSpeedLabel.TextColor3 = CYAN wingSpeedLabel.Text = T("wing_speed") .. ": " .. math.floor(State.WingSpeed) .. " / " .. (IsSym() and 500 or 200) wingSpeedLabel.ZIndex = 12
	local wingBarBg = Instance.new("Frame", wingSpeedFrame) wingBarBg.Size = UDim2.new(0.85, 0, 0, 6) wingBarBg.Position = UDim2.new(0.075, 0, 0, 28) wingBarBg.BackgroundColor3 = Color3.fromRGB(50, 55, 65) wingBarBg.BorderSizePixel =Index = 12 Instance.new("UICorner", wingBarBg).CornerRadius = UDim.new(1, 0)
	wingSpeedBar = Instance.new("Frame", wingBarBg) wingSpeedBar.Size = UDim2.new(0, 0, 1, 0) wingSpeedBar.BackgroundColor3 = CYAN wingSpeedBar.BorderSizePixel = 0 wingSpeedBar.ZIndex = 13 Instance.new("UICorner", wingSpeedBar).CornerRadius = UDim.new(1, 0)
	wingSpeedKnob = Instance.new("TextButton", wingBarBg) wingSpeedKnob.Size = UDim2.new(0, 18, 0, 18) wingSpeedKnob.Position = UDim2.new(0, -9, 0.5, -9) wingSpeedKnob.BackgroundColor3 = CYAN wingSpeedKnob.Text = "" wingSpeedKnob.ZIndex = 14 wingSpeedKnob.AutoButtonColor = false Instance.new("UICorner", wingSpeedKnob).CornerRadius = UDim.new(1, 0)
	restoreWingSpeedBtn = Instance.new("TextButton", wingSpeedFrame) restoreWingSpeedBtn.Size = UDim2.new(0.85, 0, 0, 22) restoreWingSpeedBtn.Position = UDim2.new(0.075, 0, 0, 42) restoreWingSpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 55) restoreWingSpeedBtn.Font = Enum.Font.Gotham restoreWingSpeedBtn.TextSize = 11 restoreWingSpeedBtn.TextColor3 = FAINT restoreWingSpeedBtn.Text = T("restore") restoreWingSpeedBtn.ZIndex = 12 Instance.new("UICorner", restoreWingSpeedBtn).CornerRadius = UDim.new(0, 4) table.insert(configUpdaters, function() restoreWingSpeedBtn.Text = T("restore") end)
	local isDraggingWingSpeed = false
	local function UpdateWingSpeedVisual() local currentMax = IsSym() and 500 or 200 if State.WingSpeed > currentMax then State.WingSpeed = currentMax end local percent = math.clamp((State.WingSpeed - State.DefaultWingSpeed) / (currentMax - State.DefaultWingSpeed), 0, 1) wingSpeedBar.Size = UDim2.new(percent, 0, 1, 0) wingSpeedKnob.Position = UDim2.new(percent, -9, 0.5, -9) wingSpeedLabel.Text = T("wing_speed") .. ": " .. math.floor(State.WingSpeed) .. " / " .. currentMax end
	UpdateWingSpeedVisual()
	wingSpeedKnob.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDraggingWingSpeed = true end end)
	UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDraggingWingSpeed = false end end)
	UserInputService.InputChanged:Connect(function(input) if not isDraggingWingSpeed then return end if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then local currentMax = IsSym() and 500 or 200 local percent = math.clamp((input.Position.X - wingBarBg.AbsolutePosition.X) / wingBarBg.AbsoluteSize.X, 0, 1) State.WingSpeed = State.DefaultWingSpeed + percent * (currentMax - State.DefaultWingSpeed) UpdateWingSpeedVisual() end end)
	restoreWingSpeedBtn.MouseButton1Click:Connect(function() State.WingSpeed = State.DefaultWingSpeed UpdateWingSpeedVisual() end)
	local RefreshWingSpeedVisibility = function() wingSpeedFrame.Visible = State.WebWingsEnabled if wingSpeedFrame.Visible then UpdateWingSpeedVisual() end end
	RefreshWingSpeedVisibility() table.insert(configUpdaters, RefreshWingSpeedVisibility)

	local function SwitchWebArm(newMode) if State.IsSwinging then clearIK() if State.CurrentWeb then for _, obj in ipairs(State.CurrentWeb:GetChildren()) do if obj:IsA("BasePart") then TweenService:Create(obj, TweenInfo.new(0.15), {Transparency = 1}):Play() end end end end State.SwingWebMode = newMode end
	local function RefreshWebModeButtons() if State.SwingWebMode == "Left" then leftBtn.Text = T("left_only") leftBtn.TextColor3 = CYAN bothBtn.Text = T("both_off") bothBtn.TextColor3 = RED swingSpeedFrame.Visible = false elseif State.SwingWebMode == "Both" then leftBtn.Text = T("left_off") leftBtn.TextColor3 = RED bothBtn.Text = T("both_arms") bothBtn.TextColor3 = CYAN swingSpeedFrame.Visible = true UpdateSwingSpeedVisual() else leftBtn.Text = T("left_off") leftBtn.TextColor3 = RED bothBtn.Text = T("both_off") bothBtn.TextColor3 = RED swingSpeedFrame.Visible = false end end
	RefreshWebModeButtons() table.insert(configUpdaters, RefreshWebModeButtons)
	leftBtn.MouseButton1Click:Connect(function() if State.DraggableButtons or State.SwingWebMode == "Both" then return end local newMode = State.SwingWebMode == "Left" and "Right" or "Left" SwitchWebArm(newMode) RefreshWebModeButtons() end)
	bothBtn.MouseButton1Click:Connect(function() if State.DraggableButtons or State.SwingWebMode == "Left" then return end local newMode = State.SwingWebMode == "Both" and "Right" or "Both" SwitchWebArm(newMode) RefreshWebModeButtons() end)
	local btnTitle = Instance.new("TextLabel", configPanel) btnTitle.Size = UDim2.new(1, 0, 0, 16) btnTitle.Position = UDim2.new(0, 0, 0, 968) btnTitle.BackgroundTransparency = 1 btnTitle.Font = Enum.Font.GothamBold btnTitle.TextSize = 10 btnTitle.TextColor3 = FAINT btnTitle.Text = "▎ " .. T("btn_sec") btnTitle.TextXAlignment = Enum.TextXAlignment.Left btnTitle.ZIndex = 11
	local savePosBtn = Instance.new("TextButton", configPanel) savePosBtn.Size = UDim2.new(0.9, 0, 0, 30) savePosBtn.Position = UDim2.new(0.05, 0, 0, 987) savePosBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 50) savePosBtn.Font = Enum.Font.GothamBold savePosBtn.TextSize = 11 savePosBtn.TextColor3 = Color3.fromRGB(200, 255, 200) savePosBtn.Text = "SALVAR " .. T("save_pos") savePosBtn.ZIndex = 11 Instance.new("UICorner", savePosBtn).CornerRadius = UDim.new(0, 6)
	local resetPosBtn = Instance.new("TextButton", configPanel) resetPosBtn.Size = UDim2.new(0.9, 0, 0, 30) resetPosBtn.Position = UDim2.new(0.05, 0, 0, 1022) resetPosBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 40) resetPosBtn.Font = Enum.Font.GothamBold resetPosBtn.TextSize = 11 resetPosBtn.TextColor3 = Color3.fromRGB(255, 200, 200) resetPosBtn.Text = "RESET " .. T("reset_pos") resetPosBtn.ZIndex = 11 Instance.new("UICorner", resetPosBtn).CornerRadius = UDim.new(0, 6)
	savePosBtn.MouseButton1Click:Connect(function() SaveAllPositions() savePosBtn.Text = "OK" task.delay(1.2, function() if savePosBtn and savePosBtn.Parent then savePosBtn.Text = "SALVAR " .. T("save_pos") end end) end)
	resetPosBtn.MouseButton1Click:Connect(function() ResetPositions() resetPosBtn.Text = "OK" task.delay(1.2, function() if resetPosBtn and resetPosBtn.Parent then resetPosBtn.Text = "RESET " .. T("reset_pos") end end) end)
	local closeHubBtn = Instance.new("TextButton", configPanel) closeHubBtn.Size = UDim2.new(0.9, 0, 0, 30) closeHubBtn.Position = UDim2.new(0.05, 0, 0, 1062) closeHubBtn.BackgroundColor3 = RED closeHubBtn.Font = Enum.Font.GothamBold closeHubBtn.TextSize = 12 closeHubBtn.TextColor3 = Color3.new(1, 1, 1) closeHubBtn.Text = T("close") closeHubBtn.ZIndex = 11 Instance.new("UICorner", closeHubBtn).CornerRadius = UDim.new(0, 6)
	closeHubBtn.MouseButton1Click:Connect(function() CloseParachute() CloseDrone() stopClimb() StopWebWings() StopHang() State.MenuVisible = false mobileHolder.Visible = false if crosshairFrame then crosshairFrame.Visible = false end configPanel.Visible = false end)
	applyLanguage = function() cfgTitle.Text = T("config") langTitle.Text = "▎ " .. T("lang_sec") btnTitle.Text = "▎ " .. T("btn_sec") savePosBtn.Text = "SALVAR " .. T("save_pos") resetPosBtn.Text = "RESET " .. T("reset_pos") closeHubBtn.Text = T("close") for _, u in ipairs(configUpdaters) do pcall(u) end end
	configBtn.MouseButton1Click:Connect(function() configPanel.Visible = not configPanel.Visible end)
	ApplySavedPositions() ApplyHideButtons()
end

local function BuildCleanHUD()
	local pGui = LocalPlayer:WaitForChild("PlayerGui", 10) if not pGui then return end
	local old = pGui:FindFirstChild("SpiderCleanHUD") if old then old:Destroy() end
	local gui = Instance.new("ScreenGui", pGui) gui.Name = "SpiderCleanHUD" gui.ResetOnSpawn = false gui.IgnoreGuiInset = true gui.DisplayOrder = 10 BuildMobileControls(gui)
end

local function ManageESP()
	for _, player in ipairs(Players:GetPlayers()) do if player ~= LocalPlayer and player.Character then local hl = player.Character:FindFirstChild("SpiderThermal") if State.EspEnabled and State.IsSystemOnline then if not hl then hl = Instance.new("Highlight") hl.Name = "SpiderThermal" hl.FillColor = Color3.fromRGB(255, 80, 50) hl.OutlineColor = Color3.fromRGB(255, 200, 0) hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop hl.FillTransparency = 0.5 hl.OutlineTransparency = 0.2 hl.Parent = player.Character end elseif hl then hl:Destroy() end end end
end

local function ClearGripAtt() if not gripAtt then return end if type(gripAtt) == "table" then if gripAtt.Right and gripAtt.Right.Parent then gripAtt.Right:Destroy() end if gripAtt.Left and gripAtt.Left.Parent then gripAtt.Left:Destroy() end elseif gripAtt.Parent then gripAtt:Destroy() end gripAtt = nil end
local function SetupCharacter(newCharacter)
	if not newCharacter then return end
	CloseParachute() CloseDrone() clearIK() ClearGripAtt() StopHang() climbEnabled = false stopClimb() StopWebWings()
	if wallClimbStrokeRef then wallClimbStrokeRef.Color = RED end
	Character = newCharacter Humanoid = Character:WaitForChild("Humanoid", 5) RootPart = Character:WaitForChild("HumanoidRootPart", 5) SetupHandTrails(Character)
	if Humanoid then Humanoid.StateChanged:Connect(function(_, newState) if newState == Enum.HumanoidStateType.Landed then State.CanDoubleJump = true CloseParachute() StopWebWings() elseif newState == Enum.HumanoidStateType.Seated or newState == Enum.HumanoidStateType.Dead then CloseParachute() StopWebWings() end end) end
end
LocalPlayer.CharacterAdded:Connect(SetupCharacter) if LocalPlayer.Character then SetupCharacter(LocalPlayer.Character) end

local function FadeAndDestroyWeb(folder)
	if not folder then return end
	task.spawn(function() local elapsed, duration = 0, 0.45 while elapsed < duration do local dt = RunService.RenderStepped:Wait() elapsed += dt local alpha = math.clamp(elapsed / duration, 0, 1) for _, obj in ipairs(folder:GetChildren()) do if obj:IsA("Part") then obj.Transparency = alpha end end end if folder then folder:Destroy() end end)
end

local function CreateCylinderWeb(startPos, endPos, isPersistent)
	local folder = Instance.new("Folder", workspace) folder.Name = "ActiveCylinderWeb"
	local distance = math.max((endPos - startPos).Magnitude, 0.1)
	local cylinder = Instance.new("Part") cylinder.Name = "CylinderWebPart" cylinder.Shape = Enum.PartType.Cylinder cylinder.Anchored = true cylinder.CanCollide = false cylinder.Material = Enum.Material.SmoothPlastic cylinder.Color = GetWebColor() cylinder.Size = Vector3.new(distance, 0.2, 0.2) cylinder.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -distance / 2) * CFrame.Angles(0, math.pi / 2, 0) cylinder.Parent = folder
	if IsSym() then AddSymbioteSmoke(cylinder) end
	local anchorPart = Instance.new("Part") anchorPart.Name = "SwingAnchor" anchorPart.Size = Vector3.new(0.2, 0.2, 0.2) anchorPart.Position = endPos anchorPart.Anchored = true anchorPart.Transparency = 1 anchorPart.CanCollide = false anchorPart.Parent = folder
	if isPersistent then if State.CurrentWeb then FadeAndDestroyWeb(State.CurrentWeb) end State.CurrentWeb = folder State.SwingConstraint = anchorPart else task.spawn(function() task.wait(0.7) if folder then FadeAndDestroyWeb(folder) end end) end
	return folder, anchorPart
end

local function CreateStaticSlingWeb(startPos, endPos)
	local folder = Instance.new("Folder", workspace) folder.Name = "SlingCylinderWeb"
	local distance = math.max((endPos - startPos).Magnitude, 0.1)
	local cylinder = Instance.new("Part") cylinder.Name = "CylinderWebPart" cylinder.Shape = Enum.PartType.Cylinder cylinder.Anchored = true cylinder.CanCollide = false cylinder.Material = Enum.Material.SmoothPlastic cylinder.Color = GetWebColor() cylinder.Size = Vector3.new(distance, 0.2, 0.2) cylinder.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -distance / 2) * CFrame.Angles(0, math.pi / 2, 0) cylinder.Parent = folder
	if IsSym() then AddSymbioteSmoke(cylinder) end
	return folder
end

local function UpdateCylinderFromTo(folder, startPos, endPos)
	if not folder then return end
	local cyl = folder:FindFirstChild("CylinderWebPart") if not cyl then return end
	local distance = math.max((endPos - startPos).Magnitude, 0.1)
	cyl.Size = Vector3.new(distance, 0.2, 0.2) cyl.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -distance / 2) * CFrame.Angles(0, math.pi / 2, 0)
end

ExecuteWebZip = function()
	if not State.IsSystemOnline or not Character or not State.WebShootersEnabled then return end
	local aimPoint = IsMobile and Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) or UserInputService:GetMouseLocation()
	local ray = Camera:ScreenPointToRay(aimPoint.X, aimPoint.Y)
	local rp = RaycastParams.new() rp.FilterDescendantsInstances = {Character} rp.FilterType = Enum.RaycastFilterType.Exclude rp.IgnoreWater = true rp.RespectCanCollide = false
	local hit = SmartRaycast(ray.Origin, ray.Direction * 1000000, rp, 30) if not hit then return end
	State.TargetPos = hit.Position if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end State.CanDoubleJump = true playSound(RootPart, ZIP_SOUND, false)
	CreateCylinderWeb(GetPalmPosition(true), State.TargetPos, false) CreateCylinderWeb(GetPalmPosition(false), State.TargetPos, false)
	clearIK()
	local tip = Instance.new("Part") tip.Anchored = true tip.CanCollide = false tip.Transparency = 1 tip.Size = Vector3.new(0.2, 0.2, 0.2) tip.Position = State.TargetPos tip.Parent = workspace
	local tipAtt = Instance.new("Attachment", tip)
	if State.SwingWebMode == "Both" then attachArm(Character, Humanoid, "Right", tipAtt) attachArm(Character, Humanoid, "Left", tipAtt) elseif State.SwingWebMode == "Left" then attachArm(Character, Humanoid, "Left", tipAtt) else attachArm(Character, Humanoid, "Right", tipAtt) end
	RootPart.Velocity = Vector3.new(RootPart.Velocity.X, 45, RootPart.Velocity.Z)
	task.spawn(function() task.wait(0.1) if RootPart and State.TargetPos then TweenService:Create(RootPart, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {CFrame = CFrame.new(State.TargetPos + Vector3.new(0, 2, 0))}):Play() end end)
	Debris:AddItem(tip, 0.35) task.delay(0.35, function() clearIK() end)
end

PerformSlingshotToggle = function()
	if not State.IsSystemOnline or not RootPart or not State.WebShootersEnabled then return end
	if not State.IsSlingshotting then
		State.IsSlingshotting = true State.SlingshotCharge = tick() PlayWebShootSound(RootPart)
		local rightPalm = GetPalmPosition(true) local leftPalm = GetPalmPosition(false)
		State.SlingAnchor1 = rightPalm + (RootPart.CFrame.RightVector * 14) + (RootPart.CFrame.LookVector * 45) + Vector3.new(0, 6, 0)
		State.SlingAnchor2 = leftPalm + (-RootPart.CFrame.RightVector * 14) + (RootPart.CFrame.LookVector * 45) + Vector3.new(0, 6, 0)
		State.SlingFolder1 = CreateStaticSlingWeb(rightPalm, State.SlingAnchor1) State.SlingFolder2 = CreateStaticSlingWeb(leftPalm, State.SlingAnchor2)
		clearIK()
		local tip1 = Instance.new("Part") tip1.Name = "SlingTip1" tip1.Anchored = true tip1.CanCollide = false tip1.Transparency = 1 tip1.Size = Vector3.new(0.2, 0.2, 0.2) tip1.Position = State.SlingAnchor1 tip1.Parent = workspace local att1 = Instance.new("Attachment", tip1)
		local tip2 = Instance.new("Part") tip2.Name = "SlingTip2" tip2.Anchored = true tip2.CanCollide = false tip2.Transparency = 1 tip2.Size = Vector3.new(0.2, 0.2, 0.2) tip2.Position = State.SlingAnchor2 tip2.Parent = workspace local att2 = Instance.new("Attachment", tip2)
		State.SlingIKTarget1 = tip1 State.SlingIKTarget2 = tip2
		if State.R6Mode then local fwdAtt = Instance.new("Attachment") fwdAtt.Name = "SlingR6ForwardAim" fwdAtt.Parent = RootPart fwdAtt.Position = Vector3.new(0, 1.6, -3.5) State.SlingR6ForwardAtt = fwdAtt attachArm(Character, Humanoid, "Right", fwdAtt) attachArm(Character, Humanoid, "Left", fwdAtt) else attachArm(Character, Humanoid, "Right", att1) attachArm(Character, Humanoid, "Left", att2) end
		if leapBarContainer and not State.HUDEnabled then leapBarContainer.Visible = true end
	else
		State.IsSlingshotting = false if leapBarContainer then leapBarContainer.Visible = false end
		if State.SlingFolder1 then FadeAndDestroyWeb(State.SlingFolder1) end if State.SlingFolder2 then FadeAndDestroyWeb(State.SlingFolder2) end State.SlingFolder1, State.SlingFolder2 = nil, nil
		clearIK()
		if State.SlingIKTarget1 and State.SlingIKTarget1.Parent then State.SlingIKTarget1:Destroy() end if State.SlingIKTarget2 and State.SlingIKTarget2.Parent then State.SlingIKTarget2:Destroy() end State.SlingIKTarget1 = nil State.SlingIKTarget2 = nil
		if State.SlingR6ForwardAtt and State.SlingR6ForwardAtt.Parent then State.SlingR6ForwardAtt:Destroy() end State.SlingR6ForwardAtt = nil
		local chargeTime = math.clamp(tick() - State.SlingshotCharge, 0.3, 2) local force = 130 + (chargeTime * 95) if IsSym() then force = force * 1.55 end
		PlayWindSound(RootPart, 3) if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end RootPart.Velocity = (Camera.CFrame.LookVector * force) + Vector3.new(0, force * 0.45, 0)
	end
end

PerformWebSwingBegin = function()
	if not State.IsSystemOnline or not RootPart or not State.WebShootersEnabled or State.IsSwinging then return end
	if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end State.CanDoubleJump = true
	local rp = RaycastParams.new() rp.FilterDescendantsInstances = {Character} rp.FilterType = Enum.RaycastFilterType.Exclude rp.IgnoreWater = true rp.RespectCanCollide = false
	local rayOrigin = RootPart.Position local rayDirection = (Camera.CFrame.LookVector * 70) + Vector3.new(0, 250, 0)
	local hit = SmartRaycast(rayOrigin, rayDirection, rp, 30) local attachPoint = hit and hit.Position or (rayOrigin + Camera.CFrame.LookVector * 60 + Vector3.new(0, 220, 0))
	playSound(RootPart, SWING_SOUND, false)
	task.spawn(function()
		task.wait(0.05) if not RootPart or not Character or not Humanoid then return end
		State.IsSwinging = true State.RopeLength = (attachPoint - RootPart.Position).Magnitude Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		local startPos if State.SwingWebMode == "Both" then startPos = (GetPalmPosition(true) + GetPalmPosition(false)) * 0.5 elseif State.SwingWebMode == "Left" then startPos = GetPalmPosition(false) else startPos = GetPalmPosition(true) end
		CreateCylinderWeb(startPos, attachPoint, true) if State.CurrentWeb2 then FadeAndDestroyWeb(State.CurrentWeb2) State.CurrentWeb2 = nil end
		local attChar = Instance.new("Attachment", RootPart) attChar.Name = "SpiderRopeAttChar" local attAnchor = Instance.new("Attachment", State.SwingConstraint) attAnchor.Name = "SpiderRopeAttAnchor" local rope = Instance.new("RopeConstraint") rope.Name = "SpiderRopeConstraint" rope.Attachment0 = attChar rope.Attachment1 = attAnchor rope.Length = State.RopeLength rope.Visible = false rope.Parent = RootPart
		State.RopeAttachmentChar = attChar State.RopeAttachmentAnchor = attAnchor clearIK() ClearGripAtt()
		if State.SwingWebMode == "Both" then
			if State.R6Mode then local gripRight = Instance.new("Attachment") gripRight.Name = "WebGripRight" gripRight.Parent = RootPart local gripLeft = Instance.new("Attachment") gripLeft.Name = "WebGripLeft" gripLeft.Parent = RootPart gripAtt = {Right = gripRight, Left = gripLeft} local basePos = RootPart.Position + Camera.CFrame.LookVector * 2.5 + Vector3.new(0, 1.4, 0) gripRight.WorldPosition = basePos + Camera.CFrame.RightVector * 0.9 gripLeft.WorldPosition = basePos - Camera.CFrame.RightVector * 0.9 attachArm(Character, Humanoid, "Right", gripRight) attachArm(Character, Humanoid, "Left", gripLeft) else gripAtt = Instance.new("Attachment") gripAtt.Name = "WebGrip" gripAtt.Parent = RootPart local toWeb = attachPoint - RootPart.Position if toWeb.Magnitude > 0.1 then gripAtt.WorldPosition = RootPart.Position + toWeb.Unit * 1.8 + Vector3.new(0, 0.9, 0) end attachArm(Character, Humanoid, "Right", gripAtt) attachArm(Character, Humanoid, "Left", gripAtt) end
			local animator = getAnimator(Humanoid) if not swingTrack then local anim = Instance.new("Animation") anim.AnimationId = SWING_ANIM swingTrack = animator:LoadAnimation(anim) swingTrack.Priority = Enum.AnimationPriority.Action swingTrack.Looped = true end swingTrack:Play(0.15)
		elseif State.SwingWebMode == "Left" then attachArm(Character, Humanoid, "Left", attAnchor) else attachArm(Character, Humanoid, "Right", attAnchor) end
		local initialBoost = IsSym() and 130 or 80 RootPart.Velocity = Vector3.new(RootPart.Velocity.X, 15, RootPart.Velocity.Z) + Camera.CFrame.LookVector * initialBoost
	end)
end

PerformWebSwingEnd = function()
	if not State.IsSwinging then return end State.IsSwinging = false
	if swingTrack and swingTrack.IsPlaying then swingTrack:Stop(0.2) end
	clearIK() ClearGripAtt()
	if State.CurrentWeb then FadeAndDestroyWeb(State.CurrentWeb) State.CurrentWeb = nil State.SwingConstraint = nil end if State.CurrentWeb2 then FadeAndDestroyWeb(State.CurrentWeb2) State.CurrentWeb2 = nil end
	if State.RopeAttachmentChar then State.RopeAttachmentChar:Destroy() State.RopeAttachmentChar = nil end if State.RopeAttachmentAnchor then State.RopeAttachmentAnchor:Destroy() State.RopeAttachmentAnchor = nil end
	PlayWindSound(RootPart, 2.5) if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Freefall) end
	if RootPart then local extra = IsSym() and 45 or 20 RootPart.Velocity = RootPart.Velocity + Camera.CFrame.LookVector * extra + Vector3.new(0, 15, 0) end
end

PerformLeapBegin = function()
	if not Humanoid or not RootPart or not State.IsSystemOnline then return end
	State.IsCharging = true State.JumpCharged = tick()
	if leapBarContainer and not State.HUDEnabled then leapBarContainer.Visible = true end
end

PerformLeapEnd = function()
	if not State.IsCharging then return end State.IsCharging = false
	if Humanoid then Humanoid.WalkSpeed = IsSym() and 38 or 29 end
	if leapBarContainer then leapBarContainer.Visible = false end
	local chargeTime = math.clamp(tick() - State.JumpCharged, 0.2, 1.5) local jumpForce = 55 + (chargeTime * 65)
	if IsSym() then jumpForce = jumpForce * 1.75 end
	if Humanoid then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
	local camLook = Camera.CFrame.LookVector local flat = Vector3.new(camLook.X, 0, camLook.Z) if flat.Magnitude > 0 then flat = flat.Unit else flat = RootPart.CFrame.LookVector end
	RootPart.Velocity = flat * (jumpForce * 1.3) + Vector3.new(0, jumpForce * 1.1, 0)
end

ToggleShootersAction = function() State.WebShootersEnabled = not State.WebShootersEnabled end
ToggleShiftLockAction = function()
	State.ShiftLockEnabled = not State.ShiftLockEnabled
	if State.ShiftLockEnabled then UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter else UserInputService.MouseBehavior = Enum.MouseBehavior.Default if Humanoid then Humanoid.AutoRotate = true end end
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.E then ExecuteWebZip() elseif input.KeyCode == Enum.KeyCode.Q then PerformWebSwingBegin() elseif input.KeyCode == Enum.KeyCode.R then PerformLeapBegin() elseif input.KeyCode == Enum.KeyCode.F then PerformSlingshotToggle() elseif input.KeyCode == Enum.KeyCode.T then ToggleShootersAction() elseif input.KeyCode == Enum.KeyCode.LeftShift then ToggleShiftLockAction() elseif input.KeyCode == Enum.KeyCode.Space then if State.IsSwinging then PerformWebSwingEnd() elseif State.IsSlingshotting then PerformSlingshotToggle() end end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Q then PerformWebSwingEnd() elseif input.KeyCode == Enum.KeyCode.R then PerformLeapEnd() end
end)

UserInputService.JumpRequest:Connect(function()
	if State.IsSwinging then PerformWebSwingEnd() return end if State.IsSlingshotting then PerformSlingshotToggle() return end
	if not Humanoid or not RootPart or not State.IsSystemOnline then return end
	if Humanoid:GetState() == Enum.HumanoidStateType.Freefall and State.CanDoubleJump then State.CanDoubleJump = false local dbl = IsSym() and 95 or 65 RootPart.Velocity = Vector3.new(RootPart.Velocity.X, dbl, RootPart.Velocity.Z) + Camera.CFrame.LookVector * 25 end
end)

local parachuteVisualTimer = 0
RunService.RenderStepped:Connect(function(dt)
	ManageESP() UpdateR6Arms()
	if droneActive then
		local now = os.date("*t")
		if timeStatus then timeStatus.Text = string.format("%02d : %02d", now.hour, now.min) end
		if dateStamp then dateStamp.Text = string.format("PM %02d:%02d\n%s %02d.%d", now.hour > 12 and now.hour-12 or now.hour, now.min, os.date("%b"), now.day, now.year) end
		local elapsed = tick() - startTime local mins = math.floor(elapsed / 60) local secs = math.floor(elapsed % 60) local mills = math.floor((elapsed * 100) % 100)
		if fCounter then fCounter.Text = string.format("00:%02d:%02d:%02d", mins, secs, mills) end
		local rot = CFrame.Angles(0, math.rad(camRot.X), 0) * CFrame.Angles(math.rad(camRot.Y), 0, 0) local targetDir = (rot.LookVector * -moveVec.Z) + (rot.RightVector * moveVec.X)
		local lerpFactor = (targetDir.Magnitude > 0) and 0.08 or 0.04 droneCurrentVelocity = droneCurrentVelocity:Lerp(targetDir * droneSpeed, lerpFactor)
		local rotDelta = (camRot - lastRot).Magnitude if DroneBlur then DroneBlur.Size = math.clamp((droneCurrentVelocity.Magnitude/10) + (rotDelta*2), 0, 18) end lastRot = camRot
		tiltAngle = tiltAngle + (-moveVec.X * 15 - tiltAngle) * 0.05 dronePos = dronePos + (droneCurrentVelocity * dt) Camera.FieldOfView = droneFov Camera.CFrame = CFrame.new(dronePos) * rot * CFrame.Angles(0, 0, math.rad(tiltAngle))
		if LightModel then LightModel.CFrame = Camera.CFrame end
	end
	if guiMain and guiMain.Enabled then
		if customCursor and not IsMobile then local mousePos = UserInputService:GetMouseLocation() customCursor.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y) end
		if telemetryLabel and RootPart and State.TelemetryEnabled then local vel = RootPart.Velocity.Magnitude local alt = math.floor(RootPart.Position.Y) telemetryLabel.Text = string.format("VEL %06.1f // ALT %05d", vel, alt) end
		if ChargeFill then
			if State.IsCharging then
				local chargeTime = math.clamp(tick() - State.JumpCharged, 0, 1.5) local fillPercentage = chargeTime / 1.5 ChargeFill.Size = UDim2.new(fillPercentage, 0, 1, 0)
				if fillPercentage >= 0.95 then ChargeFill.BackgroundColor3 = Color3.fromRGB(255, 40, 40) if ChargeFillGradient then ChargeFillGradient.Color = ColorSequence.new(Color3.fromRGB(255, 40, 40)) end elseif IsSym() then ChargeFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255) if ChargeFillGradient then ChargeFillGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)) end else ChargeFill.BackgroundColor3 = ORIG_CYAN if ChargeFillGradient then ChargeFillGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.15, ORIG_CYAN),ColorSequenceKeypoint.new(1, ORIG_CYAN)}) end end
			else
				ChargeFill.Size = UDim2.new(0, 0, 1, 0) ChargeFill.BackgroundColor3 = IsSym() and Color3.fromRGB(255, 255, 255) or ORIG_CYAN
				if ChargeFillGradient then if IsSym() then ChargeFillGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)) else ChargeFillGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(0.15, ORIG_CYAN),ColorSequenceKeypoint.new(1, ORIG_CYAN)}) end end
			end
		end
	end
	if not State.IsSystemOnline or not RootPart or not Humanoid then return end
	if State.Parachuting then
		local currentState = Humanoid:GetState() local grounded = Humanoid.FloorMaterial ~= Enum.Material.Air
		if currentState == Enum.HumanoidStateType.Dead or currentState == Enum.HumanoidStateType.Seated or grounded then CloseParachute() elseif State.ParachuteForce and State.ParachuteForce.Parent then
			local mass = RootPart.AssemblyMass local velocity = RootPart.AssemblyLinearVelocity local horizontalDamping = Vector3.new(-velocity.X * mass * 1.6, 0, -velocity.Z * mass * 1.6) local upwardForce = Vector3.new(0, mass * workspace.Gravity * 0.75, 0) local verticalDamping = Vector3.new(0, -velocity.Y * mass * 2.8, 0) State.ParachuteForce.Force = horizontalDamping + upwardForce + verticalDamping
			if velocity.Y < -22 then RootPart.AssemblyLinearVelocity = Vector3.new(velocity.X, -22, velocity.Z) end if velocity.Y > 0 then RootPart.AssemblyLinearVelocity = Vector3.new(velocity.X, -8, velocity.Z) end
		end
		parachuteVisualTimer += dt if parachuteVisualTimer >= 0.08 then parachuteVisualTimer = 0 RebuildParachuteVisual() end
	end
	if State.IsSlingshotting then
		if State.SlingFolder1 and State.SlingAnchor1 then UpdateCylinderFromTo(State.SlingFolder1, GetPalmPosition(true), State.SlingAnchor1) end
		if State.SlingFolder2 and State.SlingAnchor2 then UpdateCylinderFromTo(State.SlingFolder2, GetPalmPosition(false), State.SlingAnchor2) end
	end
	if State.IsCharging and Humanoid and RootPart then
		local moveDirection = Humanoid.MoveDirection if moveDirection.Magnitude > 0.1 then Humanoid.WalkSpeed = IsSym() and 95 or 78 else Humanoid.WalkSpeed = IsSym() and 38 or 29 end
	end
	if leapBarFill and leapBarContainer and leapBarContainer.Visible then
		if State.IsCharging then
			local progress = math.clamp((tick() - State.JumpCharged) / 1.3, 0, 1) leapBarFill.Size = UDim2.new(progress, 0, 1, 0)
			if progress >= 0.95 then leapBarFill.BackgroundColor3 = Color3.fromRGB(255, 40, 40) elseif IsSym() then leapBarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255) else leapBarFill.BackgroundColor3 = ORIG_CYAN end
		elseif State.IsSlingshotting then
			local progress = math.clamp((tick() - State.SlingshotCharge) / 2, 0, 1) leapBarFill.Size = UDim2.new(progress, 0, 1, 0)
			if progress >= 0.95 then leapBarFill.BackgroundColor3 = Color3.fromRGB(255, 40, 40) elseif IsSym() then leapBarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255) else leapBarFill.BackgroundColor3 = ORIG_CYAN end
		end
	end
	if State.ShiftLockEnabled then
		RootPart.CFrame = CFrame.new(RootPart.Position, Vector3.new(Camera.CFrame.LookVector.X * 10000 + RootPart.Position.X, RootPart.Position.Y, Camera.CFrame.LookVector.Z * 10000 + RootPart.Position.Z)) Humanoid.AutoRotate = false
	else
		if not climbing and not State.IsGliding and not hanging then Humanoid.AutoRotate = true end
	end
	if not State.IsCharging and not climbing and not State.IsGliding and not hanging then Humanoid.WalkSpeed = IsSym() and 38 or 29 end
	if State.IsSwinging and State.CurrentWeb and State.SwingConstraint then
		local cylinderPart = State.CurrentWeb:FindFirstChild("CylinderWebPart") local anchorPos = State.SwingConstraint.Position
		local startPos if State.SwingWebMode == "Both" then startPos = (GetPalmPosition(true) + GetPalmPosition(false)) * 0.5 elseif State.SwingWebMode == "Left" then startPos = GetPalmPosition(false) else startPos = GetPalmPosition(true) end
		if cylinderPart then local distance = math.max((anchorPos - startPos).Magnitude, 0.1) cylinderPart.Size = Vector3.new(distance, 0.2, 0.2) cylinderPart.CFrame = CFrame.new(startPos, anchorPos) * CFrame.new(0, 0, -distance / 2) * CFrame.Angles(0, math.pi / 2, 0) end
		if State.SwingWebMode == "Both" then
			if State.R6Mode then
				if gripAtt and type(gripAtt) == "table" then local basePos = RootPart.Position + Camera.CFrame.LookVector * 2.5 + Vector3.new(0, 1.4, 0) if gripAtt.Right and gripAtt.Right.Parent then gripAtt.Right.WorldPosition = basePos + Camera.CFrame.RightVector * 0.9 end if gripAtt.Left and gripAtt.Left.Parent then gripAtt.Left.WorldPosition = basePos - Camera.CFrame.RightVector * 0.9 end end
			else
				if gripAtt and gripAtt.Parent then local toWeb = anchorPos - RootPart.Position if toWeb.Magnitude > 0.1 then gripAtt.WorldPosition = RootPart.Position + toWeb.Unit * 1.8 + Vector3.new(0, 0.9, 0) end end
			end
		end
		local camDir = Camera.CFrame.LookVector local boost, maxSpeed = 4.0, 230
		if State.SwingWebMode == "Both" then maxSpeed = State.SwingSpeed boost = 4.0 + (State.SwingSpeed / 500) end
		if IsSym() then boost = boost * 1.35 maxSpeed = maxSpeed * 1.25 end
		RootPart.Velocity = RootPart.Velocity + camDir * boost
		if RootPart.Velocity.Magnitude > maxSpeed then RootPart.Velocity = RootPart.Velocity.Unit * maxSpeed end
	end
end)

task.spawn(function()
	BuildCleanHUD() CreateDroneSystem()
	if DroneButton then DroneButton.Visible = false end if DroneMenuButton then DroneMenuButton.Visible = false end
	BuildSpideyHUD(false)
	if State.XrayEnabled then SetXray(true) end if State.SymbioteEnabled then ApplySymbioteVisuals() end
	RefreshButtonsTransparency()
	if guiMain then guiMain.Enabled = State.HUDEnabled end if topBarRef then topBarRef.Visible = State.CreditVisible end
	ApplyHideButtons()
end)
