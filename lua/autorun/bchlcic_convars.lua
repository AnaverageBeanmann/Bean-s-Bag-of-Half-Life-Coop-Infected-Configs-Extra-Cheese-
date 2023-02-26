/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Bean's Bag of Half-Life Coop Infected Map Configs (Extra Cheese)"
local AddonName = "Bean's Bag of Half-Life Coop Infected Map Configs (Extra Cheese)"
local AddonType = "Convars"
local AutorunFile = "autorun/bchlcic.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")

if VJExists == true then

	/*
	update 3 changelog
	
	Music
	- Peppino's Sauce Machine is now a wave song instead of a panel song
	- Spooky Apartment Escape is now a panel song instead of an escape song
	- Thousand March is now an escape song instead of a panel song
	- Panel music now plays if you lose and restart at the checkpoint
	- Wave music now plays if you vote for and play the map again after beating it
	- Added Time For A Smackdown, Pizza Deluxe, Pizza Pie-Ing, Receding Hairline Celebration Party, Choosing The Toppings, and Hip To Be Italian for use in the upcoming custom end-of-match credits function
	- Added Meatophobia, Hard Drive To Munch You, Your Fat Ass Slows You Down, and Okay Campers, Rise and Shine! for use in the escape fail sequence
	- Added Unexpectancy Part 3 as another escape song
	
	NPCs
	- Added spawn points in tunnel 24
	- Added three more spawn points to the lowest spot the elevator can go to/where the antlion caves end
	- Adjusted the hole ceiling spawn in the same area
	- Enemies now have FindEnemy_UseSphere and FindEnemy_CanSeeThroughWalls set to true
	- Added the HLA Antlions to the npc health table
	- Zombines, Tau Rebels, and Heavy Rebels can no longer spawn at spawners with the "walkers only" spawnlist
	- Adjusted Zombine item drops so you can't get two different grenade weapons
	- Zombines now give 75 points instead of 50
	- Reduced spawn rate of HLA Antlions

	Weapons/Items
	- Shuffled around the hidden weapons
	- Moved an mp5 mag in tunnel 36 so it doesn't float anymore
	- Moved a barrel in tunnel 36 to a different spot
	- Slightly moved a barrel in the area tunnel 24 leads to so that it doesn't clip into the wall

	Other
	- Adjusted player spawns
	- The escape fail sequence is now shorter
	- Pizzaface's laugh now plays instead of the siren in the escape fail
	
	recommended setup for hl2 enemies
	zombies infecting from attacks - disabled
	player controlled zombies - disabled
	zombies being able to climb and jump - enabled
	difficulty - 
	crawlers
	runners
	super sprinters
	anything else can be left up to personal preference

	*/

	include('autorun/vj_controls.lua')

	local AddConvars = {}
	AddConvars["BBoHLCIMCEC_Enemies"] = 0

	for k, v in pairs(AddConvars) do
		if !ConVarExists( k ) then CreateConVar( k, v, {FCVAR_ARCHIVE} ) end
	end
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end