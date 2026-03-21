local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local _G = _G
local next = next

function S:StyleTooltips()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tooltip) then return end

	for _, tt in next, {
		_G.ItemRefTooltip,
		_G.ItemRefShoppingTooltip1,
		_G.ItemRefShoppingTooltip2,
		_G.FriendsTooltip,
		_G.WarCampaignTooltip,
		_G.EmbeddedItemTooltip,
		_G.ReputationParagonTooltip,
		_G.GameTooltip,
		_G.ShoppingTooltip1,
		_G.ShoppingTooltip2,
		_G.QuickKeybindTooltip,
		_G.GameSmallHeaderTooltip,
		_G.QuestScrollFrame.StoryTooltip,
		_G.QuestScrollFrame.CampaignTooltip,
		-- ours
		_G.ElvUIConfigTooltip,
		_G.ElvUISpellBookTooltip,
		-- libs
		_G.SettingsTooltip,
	} do
		TT:SetStyle(tt)
	end
end

function S:TooltipFrames()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tooltip) then return end

	S:StyleTooltips()
	S:HandleCloseButton(_G.ItemRefTooltip.CloseButton)

	_G.QuestScrollFrame.StoryTooltip:SetFrameLevel(4)

	local ItemTT = _G.GameTooltip.ItemTooltip
	S:HandleIcon(ItemTT.Icon, true)
	S:HandleIconBorder(ItemTT.IconBorder, ItemTT.Icon.backdrop)
	ItemTT.Count:ClearAllPoints()
	ItemTT.Count:Point('BOTTOMRIGHT', ItemTT.Icon, 'BOTTOMRIGHT', 1, 0)

	-- EmbeddedItemTooltip (also Paragon Reputation)
	local EmbeddedTT = _G.EmbeddedItemTooltip.ItemTooltip
	S:HandleIcon(EmbeddedTT.Icon, true)
	S:HandleIconBorder(EmbeddedTT.IconBorder, EmbeddedTT.Icon.backdrop)

	-- Skin GameTooltip Status Bar
	_G.GameTooltipStatusBar:SetStatusBarTexture(E.media.normTex)
	_G.GameTooltipStatusBar:CreateBackdrop('Transparent')
	_G.GameTooltipStatusBar:ClearAllPoints()
	_G.GameTooltipStatusBar:Point('TOPLEFT', _G.GameTooltip, 'BOTTOMLEFT', E.Border, -(E.Spacing * 3))
	_G.GameTooltipStatusBar:Point('TOPRIGHT', _G.GameTooltip, 'BOTTOMRIGHT', -E.Border, -(E.Spacing * 3))
	E:RegisterStatusBar(_G.GameTooltipStatusBar)

	-- Tooltip Styling
	if _G.GameTooltip_ShowStatusBar and not TT:IsHooked('GameTooltip_ShowStatusBar') then TT:SecureHook('GameTooltip_ShowStatusBar') end -- Skin Status Bars
	if not TT:IsHooked('GameTooltip_ShowProgressBar') then TT:SecureHook('GameTooltip_ShowProgressBar') end -- Skin Progress Bars
	if not TT:IsHooked('GameTooltip_ClearProgressBars') then TT:SecureHook('GameTooltip_ClearProgressBars') end
	if not TT:IsHooked('GameTooltip_AddQuestRewardsToTooltip') then TT:SecureHook('GameTooltip_AddQuestRewardsToTooltip') end -- Color Progress Bars
	if not TT:IsHooked('SharedTooltip_SetBackdropStyle') then TT:SecureHook('SharedTooltip_SetBackdropStyle', 'SetStyle') end -- This also deals with other tooltip borders like AzeriteEssence Tooltip
end

S:AddCallback('TooltipFrames')
