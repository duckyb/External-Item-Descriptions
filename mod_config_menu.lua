
-- MOD CONFIG MENU Compatibility
local MCMLoaded, MCM = pcall(require, "scripts.modconfig")
EID.MCMCompat_isDisplayingEIDTab = false
local MCMCompat_isDisplayingDummyMCMObj = false
local MCMCompat_oldPermanentObj = false

function EID:renderMCMDummyDescription()
	if MCMLoaded then
		EID:addTextPosModifier("MCM_HudOffset", Vector(MCM.Config.HudOffset*2,MCM.Config.HudOffset))
		if MCM.IsVisible and EID.permanentDisplayTextObj == nil and EID.MCMCompat_isDisplayingEIDTab then
			MCMCompat_oldPermanentObj = EID.permanentDisplayTextObj
			local demoDescObj = EID:getDescriptionObj(5, 100, 33)
			demoDescObj.Name = "Demo Object Name"
			demoDescObj.Transformation = "Demo Transformation"
			demoDescObj.Description = "A very cool description as a demonstration of the power of EID!#\1 This is also a cool line#This line loves you {{Heart}}"
			EID:displayPermanentText(demoDescObj)
			MCMCompat_isDisplayingDummyMCMObj = true
		elseif not MCM.IsVisible and MCMCompat_isDisplayingDummyMCMObj then
			if MCMCompat_oldPermanentObj == nil then
				EID:hidePermanentText()
			else
				EID.permanentDisplayTextObj = MCMCompat_oldPermanentObj
			end
			EID.MCMCompat_isDisplayingEIDTab = false
			MCMCompat_oldPermanentObj = nil
			MCMCompat_isDisplayingDummyMCMObj = false
		end
	end
end

if MCMLoaded then
	function AnIndexOf(t, val)
		for k, v in ipairs(t) do
			if v == val then
				return k
			end
		end
		return 1
	end

	-- Language
	local displayLanguage = {"English", "English (detailed)", "French",  "Portuguese", "Russian", "Spanish", "Bulgarian (WIP)", "Polish (WIP)", "Turkish (WIP)"}
	local langLookup = {"en_us", "en_us_detailed", "fr", "pt", "ru", "spa", "bul", "pl", "turkish"}
	ModConfigMenu.AddSetting(
		"EID",
		"General",
		{
			Type = ModConfigMenuOptionType.NUMBER,
			CurrentSetting = function()
				return AnIndexOf(langLookup, EID.Config["Language"])
			end,
			Minimum = 1,
			Maximum = #langLookup,
			Display = function()
				return "Language: " .. displayLanguage[AnIndexOf(langLookup, EID.Config["Language"])]
			end,
			OnChange = function(currentNum)
				EID.Config["Language"] = langLookup[currentNum]
			end
		}
	)
	
	-- Disable on Curse
	ModConfigMenu.AddSetting(
		"EID",
		"General",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["DisableOnCurse"]
			end,
			Display = function()
				local onOff = "True"
				if EID.Config["DisableOnCurse"] then
					onOff = "False"
				end
				return 'Show on "Curse of Blind": ' .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["DisableOnCurse"] = currentBool
			end
		}
	)
	--indicator
	local indicators = {"arrow", "blink", "border", "highlight", "none"}
	ModConfigMenu.AddSetting(
		"EID",
		"General",
		{
			Type = ModConfigMenuOptionType.NUMBER,
			CurrentSetting = function()
				return AnIndexOf(indicators, EID.Config["Indicator"])
			end,
			Minimum = 1,
			Maximum = 5,
			Display = function()
				return "Indicator: " .. EID.Config["Indicator"]
			end,
			OnChange = function(currentNum)
				EID.Config["Indicator"] = indicators[currentNum]
			end
		}
	)

	--------ShowUnidentifiedPillDescriptions---------
	ModConfigMenu.AddSetting(
		"EID",
		"General",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["ShowUnidentifiedPillDescriptions"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["ShowUnidentifiedPillDescriptions"] then
					onOff = "True"
				end
				return "Show Unidentified Pilleffects: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["ShowUnidentifiedPillDescriptions"] = currentBool
			end
		}
	)
	--------Sacrifice Room---------
	ModConfigMenu.AddSetting(
		"EID",
		"Rooms",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["DisplaySacrificeInfo"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["DisplaySacrificeInfo"] then
					onOff = "True"
				end
				return "Sacrifice Room Infos: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["DisplaySacrificeInfo"] = currentBool
			end
		}
	)

	--------Dice Room---------
	ModConfigMenu.AddSetting(
		"EID",
		"Rooms",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["DisplayDiceInfo"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["DisplayDiceInfo"] then
					onOff = "True"
				end
				return "Dice Room Infos: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["DisplayDiceInfo"] = currentBool
			end
		}
	)

	------------Collectibles--------------

	ModConfigMenu.AddSetting(
		"EID",
		"General",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["DisplayItemInfo"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["DisplayItemInfo"] then
					onOff = "True"
				end
				return "Collectible Infos: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["DisplayItemInfo"] = currentBool
			end
		}
	)
	------------Trinkets--------------

	ModConfigMenu.AddSetting(
		"EID",
		"General",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["DisplayTrinketInfo"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["DisplayTrinketInfo"] then
					onOff = "True"
				end
				return "Trinket Infos: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["DisplayTrinketInfo"] = currentBool
			end
		}
	)
	------------CARDS--------------

	ModConfigMenu.AddSetting(
		"EID",
		"General",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["DisplayCardInfo"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["DisplayCardInfo"] then
					onOff = "True"
				end
				return "Card Infos: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["DisplayCardInfo"] = currentBool
			end
		}
	)

	------------PILLS--------------
	ModConfigMenu.AddSetting(
		"EID",
		"General",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["DisplayPillInfo"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["DisplayPillInfo"] then
					onOff = "True"
				end
				return "Pill Infos: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["DisplayPillInfo"] = currentBool
			end
		}
	)

	ModConfigMenu.AddSpace("EID", "Rooms")
	ModConfigMenu.AddText("EID", "Rooms", "Display Infos in Shops")
	------------CARDS--------------

	ModConfigMenu.AddSetting(
		"EID",
		"Rooms",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["DisplayCardInfoShop"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["DisplayCardInfoShop"] then
					onOff = "True"
				end
				return "Card Infos: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["DisplayCardInfoShop"] = currentBool
			end
		}
	)

	------------PILLS--------------
	ModConfigMenu.AddSetting(
		"EID",
		"Rooms",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["DisplayPillInfoShop"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["DisplayPillInfoShop"] then
					onOff = "True"
				end
				return "Pill Infos: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["DisplayPillInfoShop"] = currentBool
			end
		}
	)

	-- SCALE
	local textScales = {0.5, 0.75, 1, 1.25, 1.5, 2}
	ModConfigMenu.AddSetting(
		"EID",
		"Display",
		{
			Type = ModConfigMenuOptionType.NUMBER,
			CurrentSetting = function()
				return AnIndexOf(textScales, EID.Config["Scale"])
			end,
			Minimum = 1,
			Maximum = 6,
			Display = function()
				EID.MCMCompat_isDisplayingEIDTab = true;
				return "Text Size: " .. EID.Config["Scale"]
			end,
			OnChange = function(currentNum)
				EID.Config["Scale"] = textScales[currentNum]
			end
		}
	)
	-- maxDistance
	local distances = {1, 1.5, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	ModConfigMenu.AddSetting(
		"EID",
		"Display",
		{
			Type = ModConfigMenuOptionType.SCROLL,
			CurrentSetting = function()
				return AnIndexOf(distances, EID.Config["MaxDistance"]) - 1
			end,
			Display = function()
				return "Display Distance: $scroll" ..
					AnIndexOf(distances, EID.Config["MaxDistance"]) - 1 .. " " .. EID.Config["MaxDistance"] .. " Grids"
			end,
			OnChange = function(currentNum)
				EID.Config["MaxDistance"] = distances[currentNum + 1]
			end
		}
	)

	-- Transparency
	local transparencies = {0.1, 0.175, 0.25, 0.3, 0.4, 0.5, 0.6, 0.75, 0.8, 0.9, 1}
	ModConfigMenu.AddSetting(
		"EID",
		"Display",
		{
			Type = ModConfigMenuOptionType.SCROLL,
			CurrentSetting = function()
				return AnIndexOf(transparencies, EID.Config["Transparency"]) - 1
			end,
			Display = function()
				return "Transparency: $scroll" ..
					AnIndexOf(transparencies, EID.Config["Transparency"]) - 1 .. " " .. EID.Config["Transparency"]
			end,
			OnChange = function(currentNum)
				EID.Config["Transparency"] = transparencies[currentNum + 1]
			end
		}
	)

	local fontTypes = {"default","borderless","inverted"}
	ModConfigMenu.AddSetting(
		"EID",
		"Display",
		{
			Type = ModConfigMenuOptionType.NUMBER,
			CurrentSetting = function()
				return AnIndexOf(fontTypes, EID.Config["FontType"])
			end,
			Minimum = 1,
			Maximum = #fontTypes,
			Display = function()
				return "Font Type: " .. EID.Config["FontType"]
			end,
			OnChange = function(currentNum)
				EID.Config["FontType"] = fontTypes[currentNum]
				local fontFile = EID.Config["FontType"] or "default"
				EID:loadFont(EID.modPath .. "resources/font/eid_"..fontFile..".fnt")
			end
		}
	)

	--------ShowItemName---------
	ModConfigMenu.AddSetting(
		"EID",
		"Display",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["ShowItemName"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["ShowItemName"] then
					onOff = "True"
				end
				return "Display Item Name: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["ShowItemName"] = currentBool
			end
		}
	)
	--------ShowItemType---------
	ModConfigMenu.AddSetting(
		"EID",
		"Display",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["ShowItemType"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["ShowItemType"] then
					onOff = "True"
				end
				return "Display Item Type: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["ShowItemType"] = currentBool
			end
		}
	)
	-------TRANSFORMATIONS---------

	ModConfigMenu.AddSetting(
		"EID",
		"Display",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["TransformationText"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["TransformationText"] then
					onOff = "True"
				end
				return "Display Transformation Name: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["TransformationText"] = currentBool
			end
		}
	)
	ModConfigMenu.AddSetting(
		"EID",
		"Display",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["TransformationIcons"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["TransformationIcons"] then
					onOff = "True"
				end
				return "Display Transformation Icon: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["TransformationIcons"] = currentBool
			end
		}
	)
	ModConfigMenu.AddSetting(
		"EID",
		"Display",
		{
			Type = ModConfigMenuOptionType.BOOLEAN,
			CurrentSetting = function()
				return EID.Config["ShowItemIcon"]
			end,
			Display = function()
				local onOff = "False"
				if EID.Config["ShowItemIcon"] then
					onOff = "True"
				end
				return "Display Item Icon: " .. onOff
			end,
			OnChange = function(currentBool)
				EID.Config["ShowItemIcon"] = currentBool
			end
		}
	)
end
