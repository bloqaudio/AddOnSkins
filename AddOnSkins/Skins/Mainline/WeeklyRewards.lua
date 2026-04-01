local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')

local _G = _G
local gsub, pairs = gsub, pairs
local hooksecurefunc = hooksecurefunc

local ITEMQUALITY_EPIC = Enum.ItemQuality.Epic or 4

-- Credits Siweia | AuroraClassic

local function SkinRewardIcon(itemFrame)
	if not itemFrame or itemFrame.IsSkinned or not itemFrame.Icon then return end

	local r, g, b = E:GetItemQualityColor(ITEMQUALITY_EPIC)

	itemFrame:CreateBackdrop('Transparent')
	itemFrame:DisableDrawLayer('BORDER')
	itemFrame.Icon:Point('LEFT', 6, 0)
	S:HandleIcon(itemFrame.Icon, true)
	itemFrame.backdrop:SetBackdropBorderColor(r, g, b)
	itemFrame.IsSkinned = true
end

local function UpdateSelection(frame)
	if not frame or not frame.backdrop or not frame.SelectedTexture then return end

	if frame.SelectedTexture:IsShown() then
		frame.backdrop:SetBackdropBorderColor(1, 0.8, 0)
	else
		frame.backdrop:SetBackdropBorderColor(0, 0, 0)
	end
end

local function SkinActivityFrame(frame, isObject)
	if not frame then return end

	if isObject then
		if frame.Border then
			frame.Border:SetAlpha(0)
		end

		if frame.ItemFrame then
			hooksecurefunc(frame.ItemFrame, 'SetDisplayedItem', SkinRewardIcon)
		elseif frame.UnselectedFrame and E.private.skins.parchmentRemoverEnable then
			if not frame.backdrop then
				frame:CreateBackdrop('Transparent')
			end

			if frame.SelectedTexture then
				frame.SelectedTexture:SetAlpha(0)
			end

			frame.UnselectedFrame:SetAlpha(0)
			hooksecurefunc(frame, 'SetSelectionState', UpdateSelection)
		end
	else
		if frame.Border then
			frame.Border:SetTexCoord(.926, 1, 0, 1)
			frame.Border:Point('LEFT', frame, 'RIGHT', 3, 0)
			frame.Border:Size(25, 137)
		end

		if frame.Background and frame.Name then
			frame.Background:Size(390, 140)
			frame.Background:SetDrawLayer('ARTWORK', 2)

			frame.Background:CreateBackdrop('Transparent')
			frame.Background.backdrop.Center:SetDrawLayer('ARTWORK', 1)
		end
	end
end

local function ReplaceIconString(frame, text)
	if not frame then return end
	if not text then text = frame:GetText() end
	if not text or text == '' then return end

	local newText, count = gsub(text, '24:24:0:%-2', '14:14:0:0:64:64:5:59:5:59')
	if count > 0 then
		frame:SetFormattedText('%s', newText)
	end
end

local function ReskinConfirmIcon(frame)
	if not frame or not frame.Icon then return end

	S:HandleIcon(frame.Icon, true)
	if frame.IconBorder then
		S:HandleIconBorder(frame.IconBorder, frame.Icon.backdrop)
	end
end

local function SelectReward(reward)
	if not reward then return end

	local selection = reward.confirmSelectionFrame
	if selection then
		if _G.WeeklyRewardsFrameNameFrame then
			_G.WeeklyRewardsFrameNameFrame:Hide()
		end

		ReskinConfirmIcon(selection.ItemFrame)

		local alsoItems = selection.AlsoItemsFrame
		if alsoItems and alsoItems.pool then
			for items in alsoItems.pool:EnumerateActive() do
				ReskinConfirmIcon(items)
			end
		end
	end
end

local function UpdateOverlay(frame)
	if not frame then return end

	local overlay = frame.Overlay
	if overlay then
		overlay:StripTextures()
		overlay:SetTemplate()
	end
end

local function HandleWarning(frame)
	if not frame then return end

	frame:SetTemplate('Transparent')
	if frame.ExtraBG then
		frame.ExtraBG:Hide()
	end
end

function S:Blizzard_WeeklyRewards()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.weeklyRewards) then return end

	-- /run UIParent_OnEvent({}, 'WEEKLY_REWARDS_SHOW')
	local frame = _G.WeeklyRewardsFrame
	if not frame then return end

	if E.private.skins.parchmentRemoverEnable then
		frame:StripTextures()
		frame:SetTemplate('Transparent')

		local header = frame.HeaderFrame
		if header then
			header:ClearAllPoints()
			header:Point('TOP', 1, -42)
			header:StripTextures()
			header:SetTemplate('Transparent')
		end

		if frame.BorderContainer then
			frame.BorderContainer:StripTextures()
		end

		if frame.ConcessionFrame then
			frame.ConcessionFrame:StripTextures()
		end
	end

	if frame.CloseButton then
		S:HandleCloseButton(frame.CloseButton)
	end

	if frame.SelectRewardButton then
		S:HandleButton(frame.SelectRewardButton)
	end

	SkinActivityFrame(frame.RaidFrame)
	SkinActivityFrame(frame.MythicFrame)
	SkinActivityFrame(frame.PVPFrame)
	SkinActivityFrame(frame.WorldFrame)

	for _, activity in pairs(frame.Activities or {}) do
		SkinActivityFrame(activity, true)
	end

	local rewardText = frame.ConcessionFrame and frame.ConcessionFrame.RewardsFrame and frame.ConcessionFrame.RewardsFrame.Text
	if rewardText then
		ReplaceIconString(rewardText)
		hooksecurefunc(rewardText, 'SetText', ReplaceIconString)
	end

	local warningDialog = _G.WeeklyRewardExpirationWarningDialog
	if warningDialog then
		warningDialog:Point('TOP', frame, 'BOTTOM', 0, -1)
		if warningDialog.NineSlice and not warningDialog.NineSlice.ASWarningHooked then
			warningDialog.NineSlice.ASWarningHooked = true
			warningDialog.NineSlice:HookScript('OnShow', HandleWarning)
		end
	end

	hooksecurefunc(frame, 'SelectReward', SelectReward)
	hooksecurefunc(frame, 'UpdateOverlay', UpdateOverlay)
end

S:AddCallbackForAddon('Blizzard_WeeklyRewards')
