local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')

local _G = _G
local gsub = gsub
local hooksecurefunc = hooksecurefunc

local function ReplaceIconString(frame, text)
	if not frame then return end
	if not text then text = frame:GetText() end
	if not text or text == '' then return end

	local newText, count = gsub(text, '|T(%d+):24:24[^|]*|t', ' |T%1:16:16:0:0:64:64:5:59:5:59|t')
	if count > 0 then frame:SetFormattedText('%s', newText) end
end

local function HandleRewardButton(button)
	if not button then return end

	local container = button.ContentsContainer
	if container and not container.isSkinned then
		container.isSkinned = true

		if container.Icon then
			S:HandleIcon(container.Icon)
		end

		if container.Price then
			ReplaceIconString(container.Price)
			hooksecurefunc(container.Price, 'SetText', ReplaceIconString)
		end
	end
end

function S:Blizzard_PerksProgram()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.perks) then return end

	local frame = _G.PerksProgramFrame
	if not frame then return end

	local productsFrame = frame.ProductsFrame
	if productsFrame then
		local filter = productsFrame.PerksProgramFilter
		if filter and filter.FilterDropDownButton then
			S:HandleButton(filter.FilterDropDownButton)
		end

		local currencyFrame = productsFrame.PerksProgramCurrencyFrame
		if currencyFrame then
			if currencyFrame.Text then
				currencyFrame.Text:FontTemplate(nil, 30)
			end

			if currencyFrame.Icon then
				S:HandleIcon(currencyFrame.Icon)
				currencyFrame.Icon:Size(30)
			end
		end

		local detailsFrame = productsFrame.PerksProgramProductDetailsContainerFrame
		if detailsFrame then
			if detailsFrame.Border then
				detailsFrame.Border:Hide()
			end

			detailsFrame:SetTemplate('Transparent')
		end

		local productsContainer = productsFrame.ProductsScrollBoxContainer
		if productsContainer then
			productsContainer:StripTextures()
			productsContainer:SetTemplate('Transparent')

			if productsContainer.ScrollBar then
				S:HandleTrimScrollBar(productsContainer.ScrollBar, true)
			end

			local holdFrame = productsContainer.PerksProgramHoldFrame
			if holdFrame then
				holdFrame:StripTextures()
				holdFrame:CreateBackdrop('Transparent')
				holdFrame.backdrop:SetInside(3, 3)
			end

			if productsContainer.ScrollBox and not productsContainer.ScrollBoxHooked then
				productsContainer.ScrollBoxHooked = true
				hooksecurefunc(productsContainer.ScrollBox, 'Update', function(container)
					if container and container.ForEachFrame then
						container:ForEachFrame(HandleRewardButton)
					end
				end)
			end
		end
	end

	local footer = frame.FooterFrame
	if footer then
		if footer.LeaveButton then
			S:HandleButton(footer.LeaveButton, nil, nil, nil, true, nil, nil, nil, true)
		end

		if footer.PurchaseButton then
			S:HandleButton(footer.PurchaseButton, nil, nil, nil, true, nil, nil, nil, true)
		end

		if footer.RefundButton then
			S:HandleButton(footer.RefundButton, nil, nil, nil, true, nil, nil, nil, true)
		end

		if footer.RotateButtonContainer then
			if footer.RotateButtonContainer.RotateLeftButton then
				S:HandleButton(footer.RotateButtonContainer.RotateLeftButton, nil, nil, nil, true, nil, nil, nil, true)
			end

			if footer.RotateButtonContainer.RotateRightButton then
				S:HandleButton(footer.RotateButtonContainer.RotateRightButton, nil, nil, nil, true, nil, nil, nil, true)
			end
		end

		if footer.TogglePlayerPreview then
			S:HandleCheckBox(footer.TogglePlayerPreview)
		end

		if footer.ToggleHideArmor then
			S:HandleCheckBox(footer.ToggleHideArmor)
		end
	end
end

S:AddCallbackForAddon('Blizzard_PerksProgram')
