if CLIENT then return end 

for i = 1, 5 do util.PrecacheSound("weapons/fx/rics/ric"..i..".wav") end -- Precache the bullet richochet sounds.

local enabled = CreateConVar("armorover100upgrade_enabled", 1, FCVAR_ARCHIVE)

local minarmor = CreateConVar("armorover100upgrade_minimumamount", 100, FCVAR_ARCHIVE)

local absorbfalldamage = CreateConVar("armorover100upgrade_absorbfalldamage", 0, FCVAR_ARCHIVE)
local absorbpoisondamage = CreateConVar("armorover100upgrade_absorbpoisondamage", 0, FCVAR_ARCHIVE)
local absorbnervegasdamage = CreateConVar("armorover100upgrade_absorbnervegasdamage", 0, FCVAR_ARCHIVE)
local absorbradiationdamage = CreateConVar("armorover100upgrade_absorbradiationdamage", 0, FCVAR_ARCHIVE)
local absorbshockdamage = CreateConVar("armorover100upgrade_absorbshockdamage", 0 , FCVAR_ARCHIVE)
local absorbdrowningdamage = CreateConVar("armorover100upgrade_absorbdrowningdamage", 0, FCVAR_ARCHIVE)
local dmgthresholdenable = CreateConVar("armorover100upgrade_dmgthreshholdenabled", 0, FCVAR_ARCHIVE)
local dmgthresholdamount = CreateConVar("armorover100upgrade_dmgthreshholddmgamount", 3, FCVAR_ARCHIVE)



hook.Add("EntityTakeDamage", "armorover100takedamage", function(victim,damage)

	if (!victim:IsPlayer()) then return end
	local ply = victim
	local plyarmor = ply:Armor()
	local dmg = damage:GetDamage()
	local eff = EffectData()

	if not enabled:GetBool() then return end 

	if damage:IsDamageType(DMG_FALL) && (!absorbfalldamage:GetBool()) then return end // If enabled, armor will absorb all fall damage
	if damage:IsDamageType(DMG_POISON) && (!absorbpoisondamage:GetBool()) then return end // If enabled, armor will absorb poison damage
	if damage:IsDamageType(DMG_NERVEGAS) && (!absorbnervegasdamage:GetBool()) then return end // If enabled, armor will abosrb neurotoxin damage 
	if damage:IsDamageType(DMG_RADIATION) && (!absorbradiationdamage:GetBool()) then return end // If enabled, armor will abosrb radiation damage
	if damage:IsDamageType(DMG_SHOCK) && (!absorbshockdamage:GetBool()) then return end  // If enabled, armor will absorb electrical damage
	if damage:IsDamageType(DMG_DROWN) && (!absorbdrowningdamage:GetBool()) then return end  // If enabled, armor will... protect you from drowning??

	if plyarmor < minarmor:GetInt() then return end 
	

	if dmg > (plyarmor - minarmor:GetInt()) then 
		ply:SetArmor(math.Clamp(plyarmor - (plyarmor - minarmor:GetInt()), 0, 666666)) // If damage is greater than remaining armor before you go below threshhold,
		damage:SetDamage(dmg - (plyarmor - minarmor:GetInt()))	
	else  

	ply:SetArmor((plyarmor) - dmg)
	damage:SetDamage(0)

	end 

	if not dmgthresholdenable:GetBool() then return end 

	if damage:IsDamageType(DMG_RADIATION) then return end
	if damage:IsDamageType(DMG_DROWN) then return end 
	if damage:IsDamageType(DMG_NERVEGAS) then return end 
	if damage:IsDamageType(DMG_ACID) then return end 
	if damage:IsDamageType(DMG_FALL) then return end 

	if dmg <= dmgthresholdamount:GetInt() then 
		ply:SetArmor(plyarmor + 1)

		eff:SetOrigin(damage:GetDamagePosition())
		eff:SetMagnitude(2)
		eff:SetScale(1)
		eff:SetRadius(1)
		eff:SetNormal(damage:GetDamagePosition():GetNormalized() *-1 )
		util.Effect("Sparks", eff)
		ply:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav", 65, math.random(80,120), 0.2, CHAN_BODY)
	else 
		ply:SetArmor((plyarmor + 1) - (dmg-dmgthresholdamount:GetInt()))
	end 
																		// If damage is not greater than remaining armor before you go below threshhold,
end)
