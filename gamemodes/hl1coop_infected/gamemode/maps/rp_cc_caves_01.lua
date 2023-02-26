MAP.MapAuthor = "disseminate"

-- default is 100
FUEL_MAX = 150 -- one player can handle

function MAP:SpecialDT(ply)
	ply:NetworkVar("Int", 10, "Fuel")
end

local randomgeneratorspot = math.random(1,6)
if randomgeneratorspot == 2 then
	generatorPos = Vector(-6888,2385,-697)
elseif randomgeneratorspot == 3 then
	generatorPos = Vector(-6990,6048,-5706)
elseif randomgeneratorspot == 4 then
	generatorPos = Vector(-12490,4442,-6092)
elseif randomgeneratorspot == 5 then
	generatorPos = Vector(-9732,4810,-7959)
elseif randomgeneratorspot == 6 then
	generatorPos = Vector(-6189,5500,-8362)
else
	generatorPos = Vector(-6846,5726,-885)
end

local musictable = {
    ["PizzaTower.PizzaTime"] = {file = "pizza/It's_Pizza_Time.mp3", dur = 232},
    ["PizzaTower.Mondays"] = {file = "pizza/Mondays.mp3", dur = 157},
    ["PizzaTower.Tombstone"] = {file = "pizza/Tombstone_Arizona.mp3", dur = 221},
    ["PizzaTower.TrashZone"] = {file = "pizza/Tubular_Trash_Zone.mp3", dur = 139},
    ["PizzaTower.Shimbers"] = {file = "pizza/Tunnely_Shimbers.mp3", dur = 240},
    ["PizzaTower.Unearthly"] = {file = "pizza/Unearthly_Blues.mp3", dur = 218},
    ["PizzaTower.Crust"] = {file = "pizza/Bite_The_Crust.mp3", dur = 120},
    ["PizzaTower.ByeBye"] = {file = "pizza/Bye_Bye_There!.mp3", dur = 338},
    ["PizzaTower.Calzone"] = {file = "pizza/Calzonification.mp3", dur = 161},
    ["PizzaTower.Preheat"] = {file = "pizza/Don't_Preheat_Your_Oven_Because_If_You_Do_The_Song_Won't_Play.mp3", dur = 170},
    ["PizzaTower.ColdSp"] = {file = "pizza/Cold_Spaghetti.mp3", dur = 169},
    ["PizzaTower.GoodEat"] = {file = "pizza/Good_Eatin'.mp3", dur = 208},
    ["PizzaTower.HotSp"] = {file = "pizza/Hot_Spaghetti.mp3", dur = 130},
    ["PizzaTower.OregUFO"] = {file = "pizza/Oregano_UFO.mp3", dur = 222},
    ["PizzaTower.SauceMach"] = {file = "pizza/Peppino's_Sauce_Machine.mp3", dur = 125},
    ["PizzaTower.Engineer"] = {file = "pizza/Pizza_Engineer.mp3", dur = 144},
    ["PizzaTower.NeverEnd"] = {file = "pizza/Pizza_Time_Never_Ends.mp3", dur = 317},
    ["PizzaTower.Deservioli"] = {file = "pizza/The_Death_That_I_Deservioli.mp3", dur = 176},
    ["PizzaTower.Bone"] = {file = "pizza/There's_A_Bone_In_My_Spaghetti.mp3", dur = 185},
    ["PizzaTower.Theat"] = {file = "pizza/Theatrical_Shenanigans.mp3", dur = 116},
    ["PizzaTower.Show"] = {file = "pizza/Put_On_A_Show.mp3", dur = 171},
    ["PizzaTower.Freak"] = {file = "pizza/Dungeon_Freakshow.mp3", dur = 212},
    ["PizzaTower.Wud"] = {file = "pizza/Wudpecker.mp3", dur = 209},
    ["PizzaTower.Thousand"] = {file = "pizza/Thousand_March.mp3", dur = 268},
    ["PizzaTower.UnexPart1"] = {file = "pizza/Unexpectancy_Part1.mp3", dur = 158},
    ["PizzaTower.UnexPart2"] = {file = "pizza/Unexpectancy_Part2.mp3", dur = 177},
    ["PizzaTower.Overcooked"] = {file = "pizza/Overcooked_Meat_Lover.mp3", dur = 128},
    ["PizzaTower.Nightmare"] = {file = "pizza/Leaning_Nightmare.mp3", dur = 139},
    ["PizzaTower.Spooky"] = {file = "pizza/Spooky_Apartment_Escape.mp3", dur = 167},
    ["PizzaTower.UnexPart3"] = {file = "pizza/Unexpectancy_Part3.mp3", dur = 237},
    ["PizzaTower.FatAss"] = {file = "pizza/Your_Fat_Ass_Slows_You_Down.mp3", dur = 5},
    ["PizzaTower.Campers"] = {file = "pizza/Okay_Campers,_Rise_And_Shine!.mp3", dur = 53},
    ["PizzaTower.Munch"] = {file = "pizza/Hard_Drive_To_Munch_You.mp3", dur = 39},
    ["PizzaTower.Meatophobia"] = {file = "pizza/Meatophobia.mp3", dur = 51},
    ["PizzaTower.Smackdown"] = {file = "pizza/Time_For_A_Smackdown.mp3", dur = 60},
    ["PizzaTower.Hairline"] = {file = "pizza/Receding_Hairline_Celebration_Party.mp3", dur = 179},
    ["PizzaTower.Pieing"] = {file = "pizza/Pizza_Pie-Ing.mp3", dur = 130},
    ["PizzaTower.Deluxe"] = {file = "pizza/Pizza_Deluxe.mp3", dur = 134},
    ["PizzaTower.Italian"] = {file = "pizza/Hip_To_Be_Italian.mp3", dur = 72},
    ["PizzaTower.Toppings"] = {file = "pizza/Choosing_The_Toppings.mp3", dur = 128},
}
 
for k,v in pairs(musictable) do
    sound.Add({
        name = k,
        channel = CHAN_STATIC,
        volume = 1,
        level = 0,
        pitch = 100,
        sound = "*#music/hl1coop_inf/"..v.file
    })
 
    if CLIENT then
        MUSIC_TRACK_DURATION[k] = v.dur
    end
end

if CLIENT then

	function SB_PlayerLineExtra(panel)
		panel.Fuel = panel:Add( "DLabel" )
		panel.Fuel:Dock( RIGHT )
		panel.Fuel:SetWidth( 80 )
		panel.Fuel:SetFont( "HL1Coop_ScoreboardDefault" )
		panel.Fuel:SetTextColor( Color( 93, 93, 93 ) )
		panel.Fuel:SetContentAlignment( 5 )
	end

	function SB_PlayerLineExtra_Think(panel, ply)
		if ( panel.NumFuel == nil || panel.NumFuel != ply:GetFuel() ) then
			panel.NumFuel = ply:GetFuel()
			panel.Fuel:SetText( panel.NumFuel )
		end
	end

	function SB_TitleExtra(panel)
		panel.TitleFuel = panel:Add( "DLabel" )
		panel.TitleFuel:SetFont( "HL1Coop_ScoreboardDefaultTitle" )
		panel.TitleFuel:SetText( "Fuel" )
		panel.TitleFuel:SetTextColor( Color( 255, 240, 0, 255 ) )
		panel.TitleFuel:Dock(TOP)
		panel.TitleFuel:DockMargin( 0, 0, 385, -32 )
		panel.TitleFuel:SetHeight( 32 )
		panel.TitleFuel:SetContentAlignment( 6 )
		panel.TitleFuel:SetExpensiveShadow( 2, Color( 0, 0, 0, 180 ) )
	end

	local icon_barrel = Material("hl1coop_inf/barrel.png")
	local fuel_number = 0

	function MAP:DrawOnScreen()
		local ply = LocalPlayer()
		if GAMEMODE:GetRoundState() == ROUND_PREPARE and ply:Alive() and !ply:IsSuitEquipped() then
			local alpha = math.sin(RealTime() * 10) * 30 + 220
			kewlText(lang.hud_findhev, "HL1Coop_text", ScrW() / 2, ScrH() / 5, Color(255,210,50,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end

		-- fuel
		if GAMEMODE:GetObjective() == 0 and ply:Alive() then
			local taskfont = "HL1Coop_task"
			surface.SetFont(taskfont)
			fuel_number = Lerp(FrameTime() * 5, fuel_number, ply:GetFuel())
			local fuel_text = lang.hud_fuel..": "..math.Round(fuel_number).."/"..FUEL_MAX
			local fuel_text_w, fuel_text_h = surface.GetTextSize(fuel_text)
			local fuel_col = Color(255, 210, 50, 220)
			
			local rectG = 20

			local icon_size = fuel_text_h * 2.2

			local frame_w, frame_h = fuel_text_w + icon_size / 2, fuel_text_h
			local frame_x, frame_y = 20, ScrH() / 4

			local icon_x, icon_y = 0, frame_y - frame_h / 2 - 2
			
			if GSRCHUD and GSRCHUD.isEnabled() then
				local themeCol = GSRCHUD.getCurrentColour()
				fuel_col.r, fuel_col.g, fuel_col.b = themeCol.r, themeCol.g + 30, themeCol.b
			end

			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawRect(frame_x - rectG / 2, frame_y - rectG / 2, frame_w + rectG, frame_h + rectG)
			draw.OutlinedBox(frame_x - rectG / 2, frame_y - rectG / 2, frame_w + rectG, frame_h + rectG, 3, HintFrameColor())

			surface.SetDrawColor(255,255,255,255)
			surface.SetMaterial(icon_barrel)
			surface.DrawTexturedRect(icon_x, icon_y, icon_size, icon_size)

			kewlText(fuel_text, taskfont, frame_x + icon_size / 2, frame_y, fuel_col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end

		--gen
		if ShowPlayerDist and ShowPlayerDist > RealTime() then
			local alpha = math.Clamp((ShowPlayerDist - RealTime()) * 100, 0, 255)
			GAMEMODE:HUDDrawDistance(generatorPos, lang.hud_generator, Color(255, 180, 50, alpha))
		end
	end

else

resource.AddWorkshop("242386747") -- map

MAP.StartingWeapons = {"weapon_crowbar", "weapon_glock"}

MAP.WaveStartTime = 60
MAP.WaveDuration = 240
MAP.EvacuationTime = 150
MAP.PortalPrepareTime = 180

MAP.ZombieSet = 1
	-- 1 = LNR: HL2 - HL2 Zombies
	-- 2 = LNR: HL2 - Rebels
	-- 3 = HLA Antlions
if GetConVar("BBoHLCIMCEC_Enemies"):GetInt() == 1 then
	-- 2 = LNR: HL2 - Rebels
	MAP.ZombieSet = 2
elseif GetConVar("BBoHLCIMCEC_Enemies"):GetInt() == 2 then
	-- 3 = HLA Antlions
	MAP.ZombieSet = 3
	MAP.MAX_SPAWNED_NPCS = 8
elseif GetConVar("BBoHLCIMCEC_Enemies"):GetInt() == 3 then
	MAP.ZombieSet = 4
else
	-- 1 = LNR: HL2 - HL2 Zombies
	MAP.ZombieSet = 1
end

MAP.MapStartMusic = "PizzaTower.Mondays"
MAP.WaveMusic = {
	"PizzaTower.Tombstone",
	"PizzaTower.TrashZone",
	"PizzaTower.Shimbers",
	"PizzaTower.Crust",
	"PizzaTower.Preheat",
	"PizzaTower.ColdSp",
	"PizzaTower.GoodEat",
	"PizzaTower.HotSp",
	"PizzaTower.OregUFO",
	"PizzaTower.Engineer",
	"PizzaTower.Bone",
	"PizzaTower.Theat",
	"PizzaTower.Show",
	"PizzaTower.Freak",
	"PizzaTower.Wud",
	"PizzaTower.Unearthly",
	"PizzaTower.SauceMach"
}
MAP.EvacMusic = {
	"PizzaTower.PizzaTime",
	"PizzaTower.ByeBye",
	"PizzaTower.UnexPart2",
	"PizzaTower.Overcooked",
	"PizzaTower.Nightmare",
	"PizzaTower.Deservioli",
	"PizzaTower.UnexPart3",
	"PizzaTower.Thousand"
}

MAP.PortalPoints = {
	Vector(-6841,2527,-426),
	Vector(-6464,2503,482),
	Vector(-6500,2378,500),
	Vector(-6894,5713,-6372),
	Vector(-12369,4904,-6283),
	Vector(-6942,4827,-5849),
	Vector(-5344,3772,-7036),
	Vector(-7550,6601,-7474),
	Vector(-9558,5042,-7932),
	Vector(-5964,7518,-8588)
}

MAP.AlienSpawnClasses = {
	"npc_antlion",
	"npc_antlion",
	"npc_antlion",
	"npc_antlion",
	"npc_antlion_worker",
	"npc_antlion_worker",
	"npc_antlionguard",
}

MAP.AlienSpawnPoints = {
	-- Floor 1
	Vector(-5141,5673,-684),
	Vector(-4773,5685,-684),
	Vector(-5773,6837,-684),
	Vector(-6901,2847,-651),
	Vector(-6712,2316,-687),
	Vector(-6899,2015,-687),
	-- Floor 0
	Vector(-12537,4425,-6082),
	Vector(-8610,4664,-5819),
	Vector(-7227,5801,-5688),
	-- Caves
	Vector(-7580,7019,-7541),
	Vector(-7361,8697,-7563),
	Vector(-9193,5834,-7946),
	Vector(-9552,5261,-7975),
	Vector(-10084,5677,-7945),
	Vector(-8363,3461,-8099),
	Vector(-6774,3207,-8176),
	-- Floor -1
	Vector(-6526,5987,-8384),
	Vector(-6556,4792,-8384)
}

local cvar_maxfuel = CreateConVar("fuel_target", "", FCVAR_NOTIFY, "If set, the generator uses this value")
cvars.AddChangeCallback("fuel_target", function(name, value_old, value_new)
	local ent = ents.FindByClass("hl1_inf_generator")[1]
	if IsValid(ent) then
		if value_new == "" then
			ent:SetupMaxFuel()
			return
		end
		value_new = tonumber(value_new)
		if value_new > 0 then
			ent:SetMaxFuel(value_new)
		else
			ent:SetupMaxFuel()
		end
	end
end)

function MAP:GetMapObjectives()
	local obj = {
		[0] = "#notify_collectfuel",
		[1] = "#notify_activatelocator",
		[2] = "#obj_xen_6"
	}
	return obj
end

function MAP:GetCommonFuel()
	local fuel = 0
	for _, barrel in pairs(ents.FindByClass("hl1_collectable_barrel")) do
		if barrel.Fuel then
			fuel = fuel + barrel.Fuel
		end
	end
	for _, trigger in pairs(ents.FindByClass("hl1_trigger_func")) do
		if trigger.Fuel then
			fuel = fuel + trigger.Fuel
		end
	end
	if IsValid(generatorEnt) then
		fuel = fuel + generatorEnt:GetFuel()
	end
	return fuel
end

function MAP:FuelMultiplier()
	local commonFuel, maxFuel = self:GetCommonFuel(), generatorEnt:GetMaxFuel()
	if commonFuel < maxFuel then
		return maxFuel / commonFuel
	end
	return 1
end

function MAP:OnBarrelExplode(ent)
	if self:GetCommonFuel() - ent.Fuel <= 0 and IsValid(generatorEnt) and !generatorEnt:IsFull() then
		GAMEMODE:GameOver(false, "There is no fuel anymore")
	end
end

local siren
local sirenSnd = Sound("music/hl1coop_inf/pizza/PizzafaceLaugh2.mp3")
function MAP:GameOverEvent()
	local roundState = GAMEMODE:GetRoundState()

	local dummyEnt = ents.Create("item_battery")
	if IsValid(dummyEnt) then
		dummyEnt:SetPos(Vector(1263, -3103, 1874))
		dummyEnt:Spawn()
		dummyEnt:SetMoveType(MOVETYPE_NONE)
		dummyEnt:SetSolid(SOLID_NONE)
		dummyEnt:SetNoDraw(true)

		siren = CreateSound(dummyEnt, sirenSnd)
		siren:SetSoundLevel(0)
		siren:Play()
	end

	local failmusic = math.random(1,3)
	if failmusic == 1 then
		GAMEMODE:PlayGlobalMusic("PizzaTower.Campers")
	elseif failmusic == 2 then
		GAMEMODE:PlayGlobalMusic("PizzaTower.Munch")
	else
		GAMEMODE:PlayGlobalMusic("PizzaTower.Meatophobia")
	end

	timer.Simple(5, function()
		if siren and siren:IsPlaying() then
			siren:Stop()
		end
		if GAMEMODE:GetRoundState() == roundState then
			GAMEMODE:EmitGlobalSound("weapons/mortarhit.wav", 70)
			GAMEMODE:PlayGlobalMusic("PizzaTower.FatAss")
			for k, v in pairs(player.GetAll()) do
				v:ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 255), 3, 1)
				if v:Alive() then
					v:Kill()
				end
			end
			for k, v in pairs(ents.GetAll()) do
				if v:IsNPC() and v:Health() > 0 then
					v:TakeDamage(9999, game.GetWorld(), game.GetWorld())
				end
			end
			GAMEMODE:GameOver(false, "#game_evacfailed")
		end
	end)
end

function MAP:CreateViewPoints()
	GAMEMODE:CreateViewPointEntity(Vector(-7130, 5328, -310), Angle(32, 41, 0))
	GAMEMODE:CreateViewPointEntity(Vector(-7550, 3007, -270), Angle(24, -45, 0))
	GAMEMODE:CreateViewPointEntity(Vector(-12245, 5181, -5970), Angle(13, -124, 0))
	GAMEMODE:CreateViewPointEntity(Vector(-9176, 6201, -7861), Angle(-2, -122, 0))
	GAMEMODE:CreateViewPointEntity(Vector(-6505, 7368, -8548), Angle(-5, 27, 0))
end

local function CreateSuitEntity(pos, ang)
	local suit = ents.Create("item_suit")
	if IsValid(suit) then
		suit:SetPos(pos)
		suit:SetAngles(ang)
		suit.dontRemove = true
		suit.Respawnable = true
		suit:Spawn()
	end
end

local function CreateBarrel(pos, fuel, ang)
	ang = ang or Angle()
	local ent = ents.Create("hl1_collectable_barrel")
	if IsValid(ent) then
		ent:SetPos(pos + Vector(0,0,32))
		ent:SetAngles(ang)
		ent:Spawn()
		if fuel then
			ent:SetFuel(fuel)
		end
	end
end

local function CreateFuelTrigger(mins, maxs, fuel)
	local fTrig = ents.Create("hl1_trigger_func")
	if IsValid(fTrig) then
		fTrig.Fuel = fuel
		function fTrig:StartTouch(ent)
			if ent:IsPlayer() and ent:Alive() then
				if self.Fuel > 0 then
					self.Fuel = math.ceil(self.Fuel * MAP:FuelMultiplier())
					local plyFuel = ent:GetFuel()
					if plyFuel >= FUEL_MAX then
						ent:TextMessageCenter("#game_cantgetmorefuel", 1.5)
						return
					end
					local num = self.Fuel
					if self.Fuel + plyFuel >= FUEL_MAX then
						num = FUEL_MAX - plyFuel
					end
					ent:SetFuel(plyFuel + num)
					STATS:AddFuel(ent, num)
					ent:TextMessageCenter("#game_yougot "..num.." #game_yougotfuel2", 2)
					self.Fuel = self.Fuel - num
					ent:EmitSound("player/pl_wade"..math.random(1,4)..".wav")
				end
				if self.Fuel <= 0 then
					self:Remove()
				end
			end
		end
		fTrig:Spawn()
		fTrig:SetCollisionBoundsWS(mins, maxs)
	end
end

local function CreateDeadBody(pos, ang, pose, bodygr)
	ang = ang or Angle()
	pose = pose or 36
	bodygr = bodygr or math.random(0, 4)
	local ent = ents.Create("prop_dynamic")
	if IsValid(ent) then
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:SetModel("models/scientist.mdl")
		ent:SetBodygroup(1, bodygr)
		if bodygr == 2 then
			ent:SetSkin(1)
		end
		ent:Spawn()
		ent:SetSequence(pose)
	end
end

function MAP:FixMapEntities()
	local npcs = ents.FindByClass("npc_*")
	table.Add(npcs, ents.FindByClass("monster_*"))
	for k, v in pairs(npcs) do
		v:AddFlags(FL_NOTARGET)
	end
end

local function CreateButtonSprite(button, name)
	local sprite = ents.Create("env_sprite")
	if IsValid(sprite) then
		sprite:SetPos(button:GetPos())
		sprite:SetParent(button)
		sprite:SetKeyValue("model", "sprites/glow08.vmt")
		sprite:SetKeyValue("scale", ".15")
		sprite:SetKeyValue("rendermode", "9")
		sprite:SetKeyValue("rendercolor", "100 200 100")
		sprite:Spawn()
		sprite:Activate()
		sprite:SetName(name)
		sprite:Fire("HideSprite")
		button:Fire("AddOutput", "OnIn "..name..":ShowSprite:0:-1")
		button:Fire("AddOutput", "OnOut "..name..":HideSprite:0:-1")
	end
end

function GM:CreateSpawner_B_LNR(pos, ang, ztype, freq)
	ztype = ztype or 0
	freq = freq or 1
	local ent = ents.Create("bs_lnr")
	if IsValid(ent) then
		ent:SetZombieType(ztype)
		ent:SetSpawnFrequency(freq)
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:Spawn()
		debugPrint("Created zombie spawner", ent, pos, ang, ztype, freq)
	end
end

function MAP:ModifyMapEntities()

	local randomspawnpoints = math.random(1,10)
	if randomspawnpoints == 1 then
		GAMEMODE:CreateCoopSpawnpoints(Vector(-7957,5378,196), Angle(9,74,0))
	elseif randomspawnpoints == 2 then
		GAMEMODE:CreateCoopSpawnpoints(Vector(-3564,6390,-652), Angle(6,169,0))
	elseif randomspawnpoints == 3 then
		GAMEMODE:CreateCoopSpawnpoints(Vector(-6742,6782,-5689), Angle(4,-92,0))
	elseif randomspawnpoints == 4 then
		GAMEMODE:CreateCoopSpawnpoints(Vector(-12659,4517,-6082), Angle(3,-25,0))
	elseif randomspawnpoints == 5 then
		GAMEMODE:CreateCoopSpawnpoints(Vector(-8147,4005,-5885), Angle(0,0,0))
	elseif randomspawnpoints == 6 then
		GAMEMODE:CreateCoopSpawnpoints(Vector(-7559,6744,-7521), Angle(-1,93,0))
	elseif randomspawnpoints == 7 then
		GAMEMODE:CreateCoopSpawnpoints(Vector(-9416,5541,-7977), Angle(-3,-118,0))
	elseif randomspawnpoints == 8 then
		GAMEMODE:CreateCoopSpawnpoints(Vector(-6543,5286,-8385), Angle(-0,117,0))
	elseif randomspawnpoints == 9 then
		GAMEMODE:CreateCoopSpawnpoints(Vector(-5742,3004,592), Angle(2,177,0))
	else
		GAMEMODE:CreateCoopSpawnpoints(Vector(-6335,5642,-687), Angle(2,169,0))
	end
	
	chargerEnt = ents.Create("item_healthcharger")
	if IsValid(chargerEnt) then
		chargerEnt:SetPos(Vector(-12756,3979,-7008))
		chargerEnt:SetAngles(Angle(0,90,0))
		chargerEnt:Spawn()
	end
	locatorEnt = ents.Create("hl1_inf_locator")
	if IsValid(locatorEnt) then
		locatorEnt:SetPos(Vector(-6351,5783,571))
		locatorEnt:SetAngles(Angle(0,-135,-180))
		locatorEnt:Spawn()
	end
	generatorEnt = ents.Create("hl1_inf_generator")
	if IsValid(generatorEnt) then
		generatorEnt:SetPos(generatorPos)
		generatorEnt:SetAngles(Angle(0,173,0))
		generatorEnt:Spawn()
		local cvar_int = cvar_maxfuel:GetInt()
		if cvar_int > 0 then
			generatorEnt:SetMaxFuel(cvar_int)
		end
	end
	panelEnt = ents.Create("hl1_inf_panel")
	if IsValid(panelEnt) then
		if randomgeneratorspot == 2 then
			panelEnt:SetPos(Vector(-6905,2311,-667))
		elseif randomgeneratorspot == 3 then
			panelEnt:SetPos(Vector(-6933,6118,-5676))
		elseif randomgeneratorspot == 4 then
			panelEnt:SetPos(Vector(-12516,4361,-6058))
		elseif randomgeneratorspot == 5 then
			panelEnt:SetPos(Vector(-9799,4753,-7914))
		elseif randomgeneratorspot == 6 then
			panelEnt:SetPos(Vector(-6406,5308,-8367))
		else
			panelEnt:SetPos(Vector(-6854,5804,-849))
		end
		panelEnt:SetAngles(Angle(-4,-17,0))
		panelEnt:Spawn()
		panelEnt:SetGenerator(generatorEnt)
		panelEnt:SetLocator(locatorEnt)
	end

	function panelEnt:Use(activator)
		if self.NextUse > CurTime() then return end
		self.NextUse = CurTime() + 1
		if activator:IsPlayer() then
			if !IsValid(self.GeneratorEnt) or !self.GeneratorEnt:IsEnabled() then
				self:EmitSound("buttons/button2.wav")
			elseif self.Activated and IsValid(self.LocatorEnt) and !self.LocatorEnt:IsActivated() then
				GAMEMODE:SetObjective(2)
				self:EmitSound("buttons/button5.wav")
				self.LocatorEnt:On()
				self.RadioTime = CurTime() + 5
			
				NO_WAVE_MUSIC = true
				local PanelMusic = math.random(1,3)
				if PanelMusic == 1 then
					GAMEMODE:PlayGlobalMusic("PizzaTower.Spooky")
				elseif PanelMusic == 2 then
					GAMEMODE:PlayGlobalMusic("PizzaTower.UnexPart1")
				else
					GAMEMODE:PlayGlobalMusic("PizzaTower.NeverEnd")
				end
				self.glowSprite:SetKeyValue("rendercolor", "0 255 0")
				
				if MAP.Zombieset == 4 then
					local gonarchboss = ents.Create("npc_vj_hlr1_gonarch")
					-- if IsValid(gonarchboss) then
						gonarchboss:SetPos(Vector(-6822, 2405, -213))
						gonarchboss:Spawn()
						gonarchboss:SetHealth(math.min(1000 * player.GetCount(), 5000))
						gonarchboss:EmitSound("vj_hlr/hl1_npc/gonarch/gon_alert"..math.random(1,3)..".wav",180,100)
						-- gonarchboss:SetCollisionBounds(Vector(-40, -40, 0), Vector(40, 40, 200))
					-- end		
				end

			end
		end	
	end

	-- for k, v in pairs(ents.FindByName("elevator_model")) do
		-- v:SetKeyValue("speed", "1000")
	-- end
	-- Floor 2 - Above Generator Room
	-- Floor 1 - Generator Room
	-- Floor 0 - Below Generator Room
	-- Floor -1 - Even Deeper
	-- Floor 2
	CreateBarrel(Vector(-7939,5931,146), math.random(1,10))
	CreateBarrel(Vector(-7464,5951,150), math.random(1,10))
	CreateBarrel(Vector(-7242,5817,140), math.random(1,10))
	-- Elevator shaft ledge in generator room
	CreateBarrel(Vector(-6995,5637,-79), math.random(1,10))
	-- Next to the generator
	CreateBarrel(Vector(-7162,5547,-835), math.random(5,10))
	-- Ledge in the generator room
	CreateBarrel(Vector(-7129,5304,-651), math.random(5,10))
	CreateBarrel(Vector(-7079,5255,-651), math.random(5,10))
	-- Disabled generator in the generator room
	CreateFuelTrigger(Vector(-6459, 5287, -670), Vector(-6520, 5270, -644), math.random(25,30))

	-- Tunnel 12
	CreateBarrel(Vector(-4401,5745,-683), math.random(10,15))
	CreateBarrel(Vector(-4400,5524,-685), math.random(10,15))
	-- Tunnel 36
	CreateBarrel(Vector(-4758,7895,-644), math.random(10,15))
	CreateBarrel(Vector(-4423,7159,-644), math.random(10,15))
	CreateBarrel(Vector(-4032,7079,-687), math.random(10,15))
	CreateBarrel(Vector(-4115,7192,-687), math.random(10,15))
	CreateBarrel(Vector(-4400,7368,-680), math.random(10,15))
	CreateBarrel(Vector(-3787,6316,-687), math.random(10,15))
	CreateBarrel(Vector(-3928,8526,-687), math.random(10,15))
	CreateBarrel(Vector(-3998,6805,-687), math.random(10,15))
	
	CreateBarrel(Vector(-3965,6434,-687), math.random(10,15))
	CreateBarrel(Vector(-3809,6619,-687), math.random(10,15))
	CreateBarrel(Vector(-4317,6754,-687), math.random(10,15))
	CreateBarrel(Vector(-4443,8031,-687), math.random(10,15))
	CreateBarrel(Vector(-4227,8369,-678), math.random(10,15))
	CreateBarrel(Vector(-3990,8567,-684), math.random(10,15))
	CreateBarrel(Vector(-4766,7128,-687), math.random(10,15))
	CreateBarrel(Vector(-4721,7065,-687), math.random(10,15))
	CreateBarrel(Vector(-5312,7280,-683), math.random(10,15))

	-- Tunnel 24 Lower Area
	CreateBarrel(Vector(-7199,3024,-703), math.random(10,15))
	CreateBarrel(Vector(-7354,2585,-465), math.random(10,15))
	CreateBarrel(Vector(-6609,2964,-693), math.random(10,15))
	CreateBarrel(Vector(-6606,2894,-705), math.random(10,15))
	CreateBarrel(Vector(-6156,2878,-629), math.random(10,15))
	CreateBarrel(Vector(-6181,2953,-629), math.random(10,15))
	CreateBarrel(Vector(-6257,2943,-629), math.random(10,15))
	CreateBarrel(Vector(-7137,1999,-558), math.random(10,15))
	CreateBarrel(Vector(-7189,2677,-687), math.random(10,15))
	CreateBarrel(Vector(-7188,2513,-687), math.random(10,15))
	CreateBarrel(Vector(-7167,1990,-687), math.random(10,15))
	CreateBarrel(Vector(-7167,2134,-687), math.random(10,15))
	
	CreateBarrel(Vector(-6170,2100,-687), math.random(10,15))
	CreateBarrel(Vector(-6261,2101,-687), math.random(10,15))
	CreateBarrel(Vector(-6336,2102,-687), math.random(10,15))
	CreateBarrel(Vector(-6162,2167,-687), math.random(10,15))
	CreateBarrel(Vector(-6258,2168,-687), math.random(10,15))
	CreateBarrel(Vector(-6341,2168,-687), math.random(10,15))
	CreateBarrel(Vector(-6673,1844,-687), math.random(10,15))
	CreateBarrel(Vector(-6677,1926,-687), math.random(10,15))
	CreateBarrel(Vector(-6681,2007,-687), math.random(10,15))
	CreateBarrel(Vector(-6457,2347,-623), math.random(10,15))

	CreateFuelTrigger(Vector(-7128, 2369, -687), Vector(-7200, 2367, -651), math.random(25,30))

	-- Tunnel 24 Upper Area
	CreateBarrel(Vector(-5678,2897,580), math.random(10,20))
	CreateBarrel(Vector(-5607,3046,580), math.random(10,20))
	CreateBarrel(Vector(-5604,3203,580), math.random(10,20))
	CreateBarrel(Vector(-5670,3206,580), math.random(10,20))
	CreateBarrel(Vector(-5742,3205,580), math.random(10,20))
	CreateBarrel(Vector(-6255,2581,580), math.random(10,20))
	CreateBarrel(Vector(-5833,3066,580), math.random(10,20))
	
	CreateBarrel(Vector(-5729,2957,580), math.random(10,20))
	CreateBarrel(Vector(-5652,2981,580), math.random(10,20))
	CreateBarrel(Vector(-5534,3003,580), math.random(10,20))
	CreateBarrel(Vector(-5670,3066,580), math.random(10,20))
	CreateBarrel(Vector(-5621,3124,580), math.random(10,20))
	CreateBarrel(Vector(-5708,3140,580), math.random(10,20))


	-- Anything below is in floor 0, under the generator room
	CreateBarrel(Vector(-6569,6795,-5696), math.random(10,30))
	CreateBarrel(Vector(-8489,4951,-5826), math.random(10,30))
	CreateBarrel(Vector(-6771,5613,-5696), math.random(10,30))
	CreateBarrel(Vector(-6987,5505,-5904), 0)
	CreateBarrel(Vector(-12364,4909,-6086), math.random(1,75))
	CreateBarrel(Vector(-12267,4711,-6082), math.random(10,30))
	CreateBarrel(Vector(-12357,4710,-6082), math.random(10,30))

	CreateBarrel(Vector(-13157,5162,-6082), math.random(10,30))
	CreateBarrel(Vector(-12215,5153,-6082), math.random(10,30))
	CreateBarrel(Vector(-12120,5144,-6082), math.random(10,30))
	CreateBarrel(Vector(-5046,4007,-5885), math.random(10,30))

	CreateBarrel(Vector(-12920,3837,-7042), math.random(50,100))

	-- Anything below is in floor -1
	CreateBarrel(Vector(-6639,7654,-8611), math.random(10,35))
	CreateBarrel(Vector(-6629,7517,-8595), math.random(10,35))
	CreateBarrel(Vector(-5917,7366,-8615), math.random(10,35))
	CreateBarrel(Vector(-5885,7516,-8617), math.random(10,35))
	CreateBarrel(Vector(-6028,7566,-8634), math.random(10,35))
	
	CreateBarrel(Vector(-6596,2962,-8377), math.random(10,30))
	
	CreateBarrel(Vector(-6279,5034,-8384), math.random(10,45))
	CreateBarrel(Vector(-6205,5259,-8384), math.random(10,45))
	CreateBarrel(Vector(-6347,5640,-8412), math.random(10,45), Angle(26, -60, 90))
	CreateBarrel(Vector(-6378,6042,-8384), math.random(10,45))
	CreateBarrel(Vector(-6911,5018,-8414), math.random(10,45), Angle(26, -60, 90))
	
	CreateBarrel(Vector(-6137,5743,-8352), math.random(10,45))
	CreateBarrel(Vector(-6256,5862,-8352), math.random(10,45))
	CreateBarrel(Vector(-6266,5965,-8352), math.random(10,45))
	CreateBarrel(Vector(-6368,5755,-8352), math.random(10,45))
	CreateBarrel(Vector(-6354,6182,-8384), math.random(10,45))
	CreateBarrel(Vector(-6625,6007,-8382), math.random(10,45))
	CreateBarrel(Vector(-6749,4742,-8381), math.random(10,45))
	CreateBarrel(Vector(-6821,4848,-8395), math.random(10,45))
	CreateBarrel(Vector(-7053,4862,-8398), math.random(10,45))
	CreateBarrel(Vector(-6795,5223,-8387), math.random(10,45))
	CreateBarrel(Vector(-6921,5371,-8385), math.random(10,45))
	CreateBarrel(Vector(-7054,5341,-8388), math.random(10,45))
	CreateBarrel(Vector(-7133,5467,-8396), math.random(10,45))
	CreateBarrel(Vector(-7118,5699,-8391), math.random(10,45))
	CreateBarrel(Vector(-7001,5603,-8330), math.random(10,45))
	CreateBarrel(Vector(-7007,5774,-8456), math.random(10,45), Angle(26, -60, 90))
	CreateBarrel(Vector(-6351,4889,-8408), math.random(10,45), Angle(26, -60, 90))

	-- Caves
	CreateBarrel(Vector(-5447,3736,-7559), math.random(10,45))
	CreateBarrel(Vector(-5109,4271,-7508), math.random(10,45), Angle(26, -60, 90))
	CreateBarrel(Vector(-8628,7656,-7545), math.random(10,45), Angle(26, -60, 90))
	CreateBarrel(Vector(-9323,6966,-7888), math.random(10,45), Angle(26, -60, 90))
	CreateBarrel(Vector(-10134,5836,-7944), math.random(10,45))
	CreateBarrel(Vector(-7835,2895,-8136), math.random(10,45))
	
	CreateBarrel(Vector(-5426,4469,-7305), math.random(10,45), Angle(26, -60, 90))
	CreateBarrel(Vector(-10371,6234,-7876), math.random(10,45), Angle(26, -60, 90))
	
	CreateBarrel(Vector(-5323,3265,-7115), math.random(10,45))
	CreateBarrel(Vector(-4714,4256,-7220), math.random(10,45))
	CreateBarrel(Vector(-5929,4239,-7223), math.random(10,45))
	CreateBarrel(Vector(-6751,4929,-7393), math.random(10,45), Angle(26, -60, 90))
	CreateBarrel(Vector(-10220,6204,-7965), math.random(10,45))
	CreateBarrel(Vector(-9558,4708,-7955), math.random(10,45))
	CreateBarrel(Vector(-8810,3990,-8012), math.random(10,45), Angle(26, -60, 90))
	CreateBarrel(Vector(-7854,2951,-8182), math.random(10,45), Angle(26, -60, 90))
	
	-- GAMEMODE:CreatePhysicsDecoration("models/props_junk/ibeam01b_cluster01.mdl",Vector(-13027, 4487, -6082))
	-- GAMEMODE:CreatePhysicsDecoration("models/props_junk/ibeam01b_cluster01.mdl",Vector(-13026, 4334, -6082))
	-- GAMEMODE:CreatePhysicsDecoration("models/props_junk/ibeam01b_cluster01.mdl",Vector(-12995, 4381, -6082))
	-- GAMEMODE:CreatePhysicsDecoration("models/props_junk/ibeam01b_cluster01.mdl",Vector(-12370, 4215, -6046))
	-- GAMEMODE:CreatePhysicsDecoration("models/props_junk/ibeam01b_cluster01.mdl",Vector(-12369, 4315, -6046))
	
	GAMEMODE:CreatePhysicsDecoration("models/props_junk/pushcart01a.mdl",Vector(-12979, 4206, -6046))
	GAMEMODE:CreatePhysicsDecoration("models/props_wasteland/controlroom_filecabinet001a.mdl",Vector(-13001, 4281, -6082))
	GAMEMODE:CreatePhysicsDecoration("models/props_wasteland/controlroom_filecabinet001a.mdl",Vector(-12995, 4260, -6082))
	GAMEMODE:CreatePhysicsDecoration("models/props_wasteland/controlroom_filecabinet001a.mdl",Vector(-12995, 4260, -6055))
	GAMEMODE:CreatePhysicsDecoration("models/props_wasteland/controlroom_filecabinet001a.mdl",Vector(-13143, 4392, -6082))
	GAMEMODE:CreatePhysicsDecoration("models/props_wasteland/controlroom_storagecloset001b.mdl",Vector(-13028, 4334, -6072),Angle(0, 0, 90))

	-- GAMEMODE:CreatePhysicsDecoration("models/props_wasteland/controlroom_storagecloset001b.mdl",Vector(-12374, 4318, -6083))
	GAMEMODE:CreatePhysicsDecoration("models/props_c17/furnituredresser001a.mdl",Vector(-12375, 4220, -6047),Angle(0, 90, 0))
	GAMEMODE:CreatePhysicsDecoration("models/props_c17/furnituredresser001a.mdl",Vector(-12375, 4220, -5965),Angle(0, 90, 0))
	GAMEMODE:CreatePhysicsDecoration("models/props_c17/furnituredresser001a.mdl",Vector(-12375, 4220, -5884),Angle(0, 90, 0))

	GAMEMODE:CreateStaticDecoration("models/props_wasteland/antlionhill.mdl",Vector(-7902, 5168, 119))
	GAMEMODE:CreateStaticDecoration("models/props_wasteland/antlionhill.mdl",Vector(-4272, 4990, -607))

	if MAP.ZombieSet == 2 then
		-- LNR: HL2 - Rebels
		-- Generator room
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7265,5468,-623), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7272,5998,-623), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6772,7010,-481), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6570,6261,-688), Angle(), 8, 1)
		-- Tunnel 36 ceiling hole
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4633,7867,-479), Angle(), 9, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4553,7789,-479), Angle(), 9, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4468,7877,-482), Angle(), 9, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4381,7968,-482), Angle(), 9, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4461,8049,-474), Angle(), 9, 0.20)
		-- Tunnel 12
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3699,5735,-682), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3701,5629,-687), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3702,5514,-677), Angle(), 8, 1)
		-- Tunnel 24
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,4905,-685), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6815,4595,-673), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6800,4253,-684), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6805,3913,-678), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,3596,-687), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6815,3298,-687), Angle(), 8, 1)
		-- Tunnel 24 lower area
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7420,3083,-687), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7420,1619,-686), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7160,1860,-687), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6916,1662,-687), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6697,1873,-687), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6254,2168,-687), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6441,2979,-623), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6686,2669,-687), Angle(), 8, 1)
		-- Tunnel 24 upper area
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5799,2212,592), Angle(), 10, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5834,2716,592), Angle(), 10, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5831,3038,592), Angle(), 10, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5674,3029,592), Angle(), 10, 1)
		-- Floor 0 near elevator
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6872,6234,-5696), Angle(), 10, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6939,5367,-5885), Angle(), 10, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7400,5783,-5696), Angle(), 10, 1)
		-- Floor 0
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8160,5589,-5696), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8585,4861,-5826), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8639,4470,-5826), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8310,4382,-5826), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9205,4391,-5826), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9965,4396,-5954), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10431,4327,-5954), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10775,4294,-5954), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-11598,4327,-6083), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12506,4348,-6082), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12595,4452,-6082), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12911,4235,-6082), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12803,4455,-6082), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12849,4804,-6082), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-13005,4840,-6082), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12940,4993,-6082), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12604,4911,-6082), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12412,4745,-6082), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12168,5121,-6082), Angle(), 8, 1)
		-- Ventilation tube
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7659,4004,-5885), Angle(), 10, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6487,4006,-5885), Angle(), 10, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5677,4008,-5885), Angle(), 10, 1)
		-- Caves
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6432,4585,-7335), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6675,5396,-7328), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7431,5862,-7395), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7531,6569,-7510), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7584,7316,-7528), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8171,7706,-7566), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7404,8730,-7563), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8314,8384,-7534), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9402,7769,-7740), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9942,6912,-7799), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9766,6582,-7871), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9216,5912,-7947), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9506,5246,-7978), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10072,5617,-7949), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10249,4551,-7975), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9244,3957,-7995), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8382,3432,-8131), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8040,2676,-8129), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,2903,-8165), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7417,3770,-8150), Angle(), 8, 1)
		-- Floor -1
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6606,3522,-8376), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6746,4801,-8389), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6214,4744,-8372), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6028,6028,-8384), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6444,7011,-8531), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6245,7419,-8708), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6503,5002,-7946), Angle(), 9, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6602,3063,-8382), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6622,3862,-8378), Angle(), 8, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6604,4337,-8382), Angle(), 8, 1)
		
	elseif MAP.ZombieSet == 3 then
		-- HLA Antlions
		-- Generator room
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7265,5468,-623), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7272,5998,-623), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6772,7010,-481), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6570,6261,-688), Angle(), 11, 0.65)
		-- Tunnel 36 ceiling hole
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4633,7867,-479), Angle(), 11, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4553,7789,-479), Angle(), 11, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4468,7877,-482), Angle(), 11, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4381,7968,-482), Angle(), 11, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4461,8049,-474), Angle(), 11, 0.20)
		-- Tunnel 12
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3699,5735,-682), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3701,5629,-687), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3702,5514,-677), Angle(), 11, 0.65)
		-- Tunnel 24
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,4905,-685), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6815,4595,-673), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6800,4253,-684), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6805,3913,-678), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,3596,-687), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6815,3298,-687), Angle(), 11, 0.65)
		-- Tunnel 24 lower area
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7420,3083,-687), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7420,1619,-686), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7160,1860,-687), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6916,1662,-687), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6697,1873,-687), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6254,2168,-687), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6441,2979,-623), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6686,2669,-687), Angle(), 11, 0.65)
		-- Tunnel 24 upper area
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5799,2212,592), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5834,2716,592), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5831,3038,592), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5674,3029,592), Angle(), 11, 0.65)
		-- Floor 0 near elevator
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6872,6234,-5696), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6939,5367,-5885), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7400,5783,-5696), Angle(), 11, 0.65)
		-- Floor 0
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8160,5589,-5696), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8585,4861,-5826), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8639,4470,-5826), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8310,4382,-5826), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9205,4391,-5826), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9965,4396,-5954), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10431,4327,-5954), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10775,4294,-5954), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-11598,4327,-6083), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12506,4348,-6082), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12595,4452,-6082), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12911,4235,-6082), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12803,4455,-6082), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12849,4804,-6082), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-13005,4840,-6082), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12940,4993,-6082), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12604,4911,-6082), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12412,4745,-6082), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12168,5121,-6082), Angle(), 11, 0.65)
		-- Ventilation tube
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7659,4004,-5885), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6487,4006,-5885), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5677,4008,-5885), Angle(), 11, 0.65)
		-- Caves
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6432,4585,-7335), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6675,5396,-7328), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7431,5862,-7395), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7531,6569,-7510), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7584,7316,-7528), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8171,7706,-7566), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7404,8730,-7563), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8314,8384,-7534), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9402,7769,-7740), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9942,6912,-7799), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9766,6582,-7871), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9216,5912,-7947), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9506,5246,-7978), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10072,5617,-7949), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10249,4551,-7975), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9244,3957,-7995), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8382,3432,-8131), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8040,2676,-8129), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,2903,-8165), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7417,3770,-8150), Angle(), 11, 0.65)
		-- Floor -1
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6606,3522,-8376), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6746,4801,-8389), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6214,4744,-8372), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6028,6028,-8384), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6444,7011,-8531), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6245,7419,-8708), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6503,5002,-7946), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6602,3063,-8382), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6622,3862,-8378), Angle(), 11, 0.65)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6604,4337,-8382), Angle(), 11, 0.65)
		
	elseif MAP.ZombieSet == 4 then
		-- HLR Zombies
		-- Generator room
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7265,5468,-623), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7272,5998,-623), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6772,7010,-481), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6570,6261,-688), Angle(), 12, 1)
		-- Tunnel 36 ceiling hole
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4633,7867,-479), Angle(), 12, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4553,7789,-479), Angle(), 12, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4468,7877,-482), Angle(), 12, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4381,7968,-482), Angle(), 12, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4461,8049,-474), Angle(), 12, 0.20)
		-- Tunnel 12
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3699,5735,-682), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3701,5629,-687), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3702,5514,-677), Angle(), 12, 1)
		-- Tunnel 24
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,4905,-685), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6815,4595,-673), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6800,4253,-684), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6805,3913,-678), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,3596,-687), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6815,3298,-687), Angle(), 12, 1)
		-- Tunnel 24 lower area
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7420,3083,-687), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7420,1619,-686), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7160,1860,-687), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6916,1662,-687), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6697,1873,-687), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6254,2168,-687), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6441,2979,-623), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6686,2669,-687), Angle(), 12, 1)
		-- Tunnel 24 upper area
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5799,2212,592), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5834,2716,592), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5831,3038,592), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5674,3029,592), Angle(), 12, 1)
		-- Floor 0 near elevator
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6872,6234,-5696), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6939,5367,-5885), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7400,5783,-5696), Angle(), 12, 1)
		-- Floor 0
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8160,5589,-5696), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8585,4861,-5826), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8639,4470,-5826), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8310,4382,-5826), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9205,4391,-5826), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9965,4396,-5954), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10431,4327,-5954), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10775,4294,-5954), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-11598,4327,-6083), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12506,4348,-6082), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12595,4452,-6082), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12911,4235,-6082), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12803,4455,-6082), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12849,4804,-6082), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-13005,4840,-6082), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12940,4993,-6082), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12604,4911,-6082), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12412,4745,-6082), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12168,5121,-6082), Angle(), 12, 1)
		-- Ventilation tube
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7659,4004,-5885), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6487,4006,-5885), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5677,4008,-5885), Angle(), 12, 1)
		-- Caves
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6432,4585,-7335), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6675,5396,-7328), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7431,5862,-7395), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7531,6569,-7510), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7584,7316,-7528), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8171,7706,-7566), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7404,8730,-7563), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8314,8384,-7534), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9402,7769,-7740), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9942,6912,-7799), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9766,6582,-7871), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9216,5912,-7947), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9506,5246,-7978), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10072,5617,-7949), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10249,4551,-7975), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9244,3957,-7995), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8382,3432,-8131), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8040,2676,-8129), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,2903,-8165), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7417,3770,-8150), Angle(), 12, 1)
		-- Floor -1
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6606,3522,-8376), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6746,4801,-8389), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6214,4744,-8372), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6028,6028,-8384), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6444,7011,-8531), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6245,7419,-8708), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6503,5002,-7946), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6602,3063,-8382), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6622,3862,-8378), Angle(), 12, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6604,4337,-8382), Angle(), 12, 1)
	else
		-- LNR: HL2 - HL2 Zombies
		-- Generator room
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7265,5468,-623), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7272,5998,-623), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6772,7010,-481), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6570,6261,-688), Angle(), 7, 1)
		-- Tunnel 36 ceiling hole
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4633,7867,-479), Angle(), 4, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4553,7789,-479), Angle(), 4, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4468,7877,-482), Angle(), 4, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4381,7968,-482), Angle(), 4, 0.20)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-4461,8049,-474), Angle(), 4, 0.20)
		-- Tunnel 12
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3699,5735,-682), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3701,5629,-687), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-3702,5514,-677), Angle(), 7, 1)
		-- Tunnel 24
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,4905,-685), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6815,4595,-673), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6800,4253,-684), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6805,3913,-678), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,3596,-687), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6815,3298,-687), Angle(), 7, 1)

		-- Tunnel 24 lower area
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7420,3083,-687), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7420,1619,-686), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7160,1860,-687), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6916,1662,-687), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6697,1873,-687), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6254,2168,-687), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6441,2979,-623), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6686,2669,-687), Angle(), 7, 1)
		-- Tunnel 24 upper area
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5799,2212,592), Angle(), 6, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5834,2716,592), Angle(), 6, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5831,3038,592), Angle(), 6, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5674,3029,592), Angle(), 6, 1)
		-- Floor 0 near elevator
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6872,6234,-5696), Angle(), 6, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6939,5367,-5885), Angle(), 6, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7400,5783,-5696), Angle(), 6, 1)
		-- Floor 0
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8160,5589,-5696), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8585,4861,-5826), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8639,4470,-5826), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8310,4382,-5826), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9205,4391,-5826), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9965,4396,-5954), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10431,4327,-5954), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10775,4294,-5954), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-11598,4327,-6083), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12506,4348,-6082), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12595,4452,-6082), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12911,4235,-6082), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12803,4455,-6082), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12849,4804,-6082), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-13005,4840,-6082), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12940,4993,-6082), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12604,4911,-6082), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12412,4745,-6082), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-12168,5121,-6082), Angle(), 7, 1)
		-- Ventilation tube
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7659,4004,-5885), Angle(), 5, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6487,4006,-5885), Angle(), 5, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-5677,4008,-5885), Angle(), 5, 1)
		-- Caves
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6432,4585,-7335), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6675,5396,-7328), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7431,5862,-7395), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7531,6569,-7510), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7584,7316,-7528), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8171,7706,-7566), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7404,8730,-7563), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8314,8384,-7534), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9402,7769,-7740), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9942,6912,-7799), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9766,6582,-7871), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9216,5912,-7947), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9506,5246,-7978), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10072,5617,-7949), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-10249,4551,-7975), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-9244,3957,-7995), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8382,3432,-8131), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-8040,2676,-8129), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6810,2903,-8165), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-7417,3770,-8150), Angle(), 7, 1)
		-- Floor -1
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6606,3522,-8376), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6746,4801,-8389), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6214,4744,-8372), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6028,6028,-8384), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6444,7011,-8531), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6245,7419,-8708), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6505,5001,-7837), Angle(), 4, 1)

		-- add these to the other ones too
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6602,3063,-8382), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6622,3862,-8378), Angle(), 7, 1)
		GAMEMODE:CreateSpawner_B_LNR(Vector(-6604,4337,-8382), Angle(), 7, 1)
		
	end
	
	for k, v in pairs(ents.FindInBox(Vector(-6075, 2128, 592), Vector(-5937, 2128, 592))) do
		if v:GetClass() == "weapon_frag" then
			v:Remove()
		end		
	end
	for k, v in pairs(ents.FindInBox(Vector(-7202, 2077, -559), Vector(-7201, 1978, 558))) do
		if v:GetClass() == "weapon_357" then
			v:Remove()
		end		
	end
	for k, v in pairs(ents.FindInBox(Vector(-5651, 2955, 592), Vector(-5522, 2942, 592))) do
		if v:GetClass() == "weapon_shotgun" then
			v:Remove()
		end		
	end
	for k, v in pairs(ents.FindInBox(Vector(-7231, 2377, -687), Vector(-7117, 2385, -687))) do
		if v:GetClass() == "weapon_shotgun" then
			v:Remove()
		end		
	end
	for k, v in pairs(ents.FindInBox(Vector(-12476, 4287, -6082), Vector(-12364, 4277, -6083))) do
		if v:GetClass() == "prop_physics" then
			v:Remove()
		end		
	end

end

function MAP:AddItemPickups()

	GAMEMODE:CreateWeaponEntity("weapon_m249", Vector(-6723, 2543, 335))
	GAMEMODE:CreatePickupEntity("ammo_556", Vector(-6723, 2600, 335))
	GAMEMODE:CreatePickupEntity("ammo_556", Vector(-6723, 2400, 335))
	GAMEMODE:CreatePickupEntity("ammo_556", Vector(-6723, 2300, 335))
	GAMEMODE:CreatePickupEntity("ammo_556", Vector(-6723, 2200, 335))

	GAMEMODE:CreateWeaponEntity("weapon_m16", Vector(-6941, 4839, -5885))

	GAMEMODE:CreateWeaponEntity("weapon_ak47", Vector(-6866, 5810, -8120))

	GAMEMODE:CreateWeaponEntity("weapon_hornetgun", Vector(-7071, 1727, -267))

	GAMEMODE:CreateWeaponEntity("weapon_egon", Vector(-7052,5848,-5312))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-12451, 4826, -6319), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-12294, 4826, -6319), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-12294, 4983, -6313), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-12454, 4986, -6319), Angle(0, math.random(-180, 180), 0))

	GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(-7099, 2142, -559))
	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(-7124, 2155, -559))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-7124, 2130, -559))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-7124, 2114, -559))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-7062, 2677, -483))
	GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(-7086, 2656, -486))
	GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(-6144, 2407, -619))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-6158, 2356, -619))
	
	GAMEMODE:CreateWeaponEntity("weapon_crossbow", Vector(-6271, 2423, 592))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-6286, 2456, 592))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-6287, 2477, 592))

	GAMEMODE:CreateWeaponEntity("weapon_shotgun", Vector(-5977, 2303, 592))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-6022, 2313, 592))
	GAMEMODE:CreatePickupEntity("hl1_ammo_argrenades", Vector(-4559, 5733, -681))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-4577, 5730, -681))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-4592, 5732, -681))
	GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(-4612, 5728, -681))
	GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(-4063, 5504, -652))
	GAMEMODE:CreateWeaponEntity("weapon_satchel", Vector(-4049, 5529, -654))
	GAMEMODE:CreatePickupEntity("hl1_ammo_357", Vector(-4326, 7428, -683))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-4352, 7434, -687))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-4348, 7408, -681))
	GAMEMODE:CreatePickupEntity("hl1_ammo_argrenades", Vector(-4033, 6989, -655))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-4022, 7005, -655))

	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-4119,7064,-687))

	GAMEMODE:CreateWeaponEntity("weapon_mp5", Vector(-3992, 7025, -655))
	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(-3976, 7044, -655))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-7873, 5463, 170))
	GAMEMODE:CreatePickupEntity("hl1_ammo_357", Vector(-7871, 5507, 174))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-7874, 5547, 178))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-7877, 5580, 185))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmbox", Vector(-7892, 5625, 186))
	GAMEMODE:CreateWeaponEntity("weapon_gauss", Vector(-6058,2370,-175))
	GAMEMODE:CreateWeaponEntity("weapon_357", Vector(-8459, 4853, -5816))
	GAMEMODE:CreatePickupEntity("hl1_ammo_357", Vector(-8475, 4834, -5826))
	GAMEMODE:CreatePickupEntity("hl1_ammo_357", Vector(-8477, 4862, -5826))
	GAMEMODE:CreatePickupEntity("hl1_ammo_rpgclip", Vector(-12850, 5272, -6082))
	GAMEMODE:CreatePickupEntity("hl1_ammo_rpgclip", Vector(-12864, 5289, -6082))
	GAMEMODE:CreateWeaponEntity("weapon_rpg", Vector(-12898, 5259, -6082))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-5708, 4751, -7203))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-5761, 4766, -7210))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-5716, 4792, -7201))
	GAMEMODE:CreatePickupEntity("hl1_ammo_357", Vector(-6865, 5005, -7342))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-8638, 7681, -7538))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-8642, 7629, -7549))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-8590, 7637, -7560))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-9104, 7084, -7784))
	GAMEMODE:CreatePickupEntity("hl1_ammo_357", Vector(-9170, 7096, -7777))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-9149, 7030, -7762))
	GAMEMODE:CreatePickupEntity("hl1_ammo_rpgclip", Vector(-9413, 7105, -7882))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-7930, 3112, -8133))
	GAMEMODE:CreatePickupEntity("hl1_ammo_357", Vector(-7922, 3053, -8133))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-7781, 3048, -8144))

	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-6811, 4971, -7345), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-8548, 7658, -7561), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-9310, 7055, -7883), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-9302, 7105, -7874), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-10275, 6342, -7872), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-10294, 6231, -7869), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-8884, 3905, -7986), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-7856, 3032, -8141), Angle(0, math.random(-180, 180), 0))
	
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-8727, 5630, -5689), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-8721, 5591, -5696), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-8476, 4792, -5823), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-12761, 5205, -6080), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-12811, 5205, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-8258, 4450, -5826), Angle(0, math.random(-180, 180), 0))
	
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-6422, 5316, -663), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-6486, 5312, -681), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-6562, 5265, -687), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-7984, 5633, 178), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-7971, 5534, 185), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-7976, 5446, 176), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-7966, 5348, 152), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-7936, 5447, 173), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-7931, 5531, 178), Angle(0, math.random(-180, 180), 0))

	-- GAMEMODE:CreateWeaponEntity("weapon_snark", Vector(-7241, 1438, -678))
	-- GAMEMODE:CreateWeaponEntity("weapon_snark", Vector(-6148, 3035, -623))

	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-6022, 2413, -175), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-6022, 2322, -175), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-6098, 2323, -175), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-6097, 2413, -175), Angle(0, math.random(-180, 180), 0))

	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-6786, 6279, -5696), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_argrenades", Vector(-6789, 6326, -5696), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreateWeaponEntity("weapon_handgrenade", Vector(-6812, 6290, -5696), Angle(0, math.random(-180, 180), 0))
	
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-8065, 5779, -5696), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-8086, 5746, -5696), Angle(0, math.random(-180, 180), 0))
	
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-8295, 4310, -5826), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-8295, 4181, -5826), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-8152, 4178, -5826), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_argrenades", Vector(-8008, 4176, -5826), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-8005, 3976, -5871), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-8140, 4031, -5877), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-8142, 3981, -5874), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-9443, 4637, -5850), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-9419, 4635, -5844), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-9400, 4634, -5839), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-9448, 4589, -5851), Angle(0, math.random(-180, 180), 0))

	GAMEMODE:CreateWeaponEntity("weapon_tripmine", Vector(-12750, 5066, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmar", Vector(-12747, 5098, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-12749, 5134, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-12751, 5179, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_rpgclip", Vector(-12753, 5222, -6078), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-12797, 5217, -6080), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_buckshot", Vector(-12797, 5170, -6082), Angle(0, math.random(-180, 180), 0))

	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmbox", Vector(-12946, 5214, -6082), Angle(0, math.random(-180, 180), 0))

	GAMEMODE:CreatePickupEntity("hl1_item_healthkit", Vector(-12692, 4823, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-12676, 4781, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-12638, 4775, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-12602, 4777, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_item_battery", Vector(-12565, 4776, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_argrenades", Vector(-12636, 4820, -6082), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-12527, 4710, -6082), Angle(0, math.random(-180, 180), 0))

	GAMEMODE:CreatePickupEntity("hl1_ammo_rpgclip", Vector(-12341, 4221, -6083), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_crossbow", Vector(-12342, 4307, -6083), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_argrenades", Vector(-12407, 4302, -6083), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_gaussclip", Vector(-12404, 4222, -6083), Angle(0, math.random(-180, 180), 0))
	GAMEMODE:CreatePickupEntity("hl1_ammo_9mmbox", Vector(-12376, 4261, -5959), Angle(0, math.random(-180, 180), 0))

end

function MAP:OnPlayerSpawnPre(ply)
end

function MAP:OnPlayerSpawn(ply)
	if GAMEMODE:GetRound() > 0 then
		ply:Give("weapon_glock")
	end
	ply:SetGravity(1)
	if ply.FirstSpawn then
		local timerId = "ObjectiveHint_"..ply:UserID()
		timer.Create(timerId, 10, 0, function()
			if IsValid(ply) and ply.canTakeDamage then
				GAMEMODE:ShowObjective(ply)
				timer.Stop(timerId)
			end
		end)
	else
		GAMEMODE:ShowObjective(ply)
	end
end

function GM:OnPlayerTeleportToCheckpoint(ply)
	ply:SetGravity(1)
	ply:KillNPCsInRadius(96)
end

function GM:OnSuitPickup(ply)
	if !cvars.Bool("hl1_coop_sv_custommodels") then
		ply:SetModel(DEFAULT_PLAYERMODEL_PATH)
	end
end

function MAP:OnMapRestart()
	GAMEMODE:SetObjective(0, true)
	for k, v in pairs(player.GetAll()) do
		v:SetFuel(0)
	end
	NO_WAVE_MUSIC = false
end

function MAP:GetRestartFromCheckpointPos(num)
	return Vector(-6501,5759,-666), Angle(0, 180, 0)
end

function MAP:OnRestartFromCheckpoint(num)
	if num == 1 then
		for k, v in pairs(ents.FindByClass("hl1_collectable_barrel")) do
			v.Fuel = 0
		end
		for k, v in pairs(ents.FindByClass("hl1_trigger_func")) do
			if v.Fuel then
				v:Remove()
			end
		end
		if IsValid(generatorEnt) then
			generatorEnt:SetFuel(generatorEnt:GetMaxFuel())
			generatorEnt.Enabled = true
			generatorEnt:StartSound()
		end
		if IsValid(locatorEnt) then
			locatorEnt:On()
			locatorEnt:SetPortalTime(self.PortalPrepareTime)
		end
		NO_WAVE_MUSIC = true
		local PanelMusic = math.random(1,3)
		if PanelMusic == 1 then
			GAMEMODE:PlayGlobalMusic("PizzaTower.Spooky")
		elseif PanelMusic == 2 then
			GAMEMODE:PlayGlobalMusic("PizzaTower.UnexPart1")
		else
			GAMEMODE:PlayGlobalMusic("PizzaTower.NeverEnd")
		end
	end
	for k, v in pairs(player.GetAll()) do
		v:EquipSuit()
	end
end

function MAP:OnGameEnd()
	local endmusic = math.random(1,6)
	if endmusic == 1 then
		GAMEMODE:PlayGlobalMusic("PizzaTower.Smackdown")
	elseif endmusic == 2 then
		GAMEMODE:PlayGlobalMusic("PizzaTower.Hairline")
	elseif endmusic == 3 then
		GAMEMODE:PlayGlobalMusic("PizzaTower.Pieing")
	elseif endmusic == 4 then
		GAMEMODE:PlayGlobalMusic("PizzaTower.Deluxe")
	elseif endmusic == 5 then
		GAMEMODE:PlayGlobalMusic("PizzaTower.Italian")
	else
		GAMEMODE:PlayGlobalMusic("PizzaTower.Toppings")
	end	
end

end