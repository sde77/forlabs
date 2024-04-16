


hook.Add("AddToolMenuCategories", "AzbrCategory", function()
	spawnmenu.AddToolCategory("Options", "Azbr", "#Azbr")
end)	


hook.Add("PopulateToolMenu", "AzbrMenuSettings", function()
	spawnmenu.AddToolMenuOption("Options", "Azbr", "azbrarmorupgrade", "Armor Upgrade Options", "", "", function(panel)  
		panel:CheckBox("Enabled", "armorover100upgrade_enabled")
			panel:ControlHelp("Enable addon.")
		panel:NumSlider("Protection Threshhold", "armorover100upgrade_minimumamount", 0, 200,0)
			panel:ControlHelp("Your armor must be above this amount to\n absorb all incoming damage. (Default is 100)")
		panel:CheckBox("Enabled", "armorover100upgrade_dmgthreshholdenabled")
			panel:ControlHelp("Enable armor not to take damage if damage received is below the amount below.")
		panel:NumSlider("Armor Impervious Threshhold", "armorover100upgrade_dmgthreshholddmgamount", 0,200,0)
			panel:ControlHelp("Damage received must be higher than this value to damage your armor.")
		panel:CheckBox("Will armor absorb fall damage?", "armorover100upgrade_absorbfalldamage")
		panel:CheckBox("Will armor protect against neurotoxin?", "armorover100upgrade_absorbpoisondamage")
		panel:CheckBox("Will armor protect against nervegas?", "armorover100upgrade_absorbnervegasdamage")
		panel:CheckBox("Will armor protect against radiation?", "armorover100upgrade_absorbradiationdamage")
		panel:CheckBox("Will armor protect against electricity?", "armorover100upgrade_absorbshockdamage")
		panel:CheckBox("Will armor protect against... drowning?", "armorover100upgrade_absorbdrowningdamage")
			panel:ControlHelp("Don't ask why this is here, I figured the option would be appreciated...")

	end)
end)