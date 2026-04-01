local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')

local _G = _G
local format = format
local ipairs, unpack = ipairs, unpack
local GetSocketTypes = GetSocketTypes
local hooksecurefunc = hooksecurefunc

function S:Blizzard_ItemSocketingUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.socket) then return end

	local ItemSocketingFrame = _G.ItemSocketingFrame
	S:HandlePortraitFrame(ItemSocketingFrame)

	_G.ItemSocketingDescription:DisableDrawLayer('BORDER')
	_G.ItemSocketingDescription:DisableDrawLayer('BACKGROUND')
	local scrollFrame = _G.ItemSocketingScrollFrame
	scrollFrame:StripTextures()
	scrollFrame:SetTemplate('Transparent')

	local scrollBar = scrollFrame.ScrollBar or _G.ItemSocketingScrollFrameScrollBar
	if scrollBar then
		if scrollBar.Track or scrollBar.Back or scrollBar.Forward then
			S:HandleTrimScrollBar(scrollBar)
		else
			S:HandleScrollBar(scrollBar)
		end
	end

	for i = 1, _G.MAX_NUM_SOCKETS do
		local button = _G[format('ItemSocketingSocket%d', i)]
		local button_bracket = _G[format('ItemSocketingSocket%dBracketFrame', i)]
		local button_bg = _G[format('ItemSocketingSocket%dBackground', i)]
		local button_icon = _G[format('ItemSocketingSocket%dIconTexture', i)]

		if button then
			button:StripTextures()
			button:StyleButton()
			button:SetTemplate(nil, true)
		end

		if button_bracket then
			button_bracket:Kill()
		end

		if button_bg then
			button_bg:Kill()
		end

		if button_icon then
			button_icon:SetTexCoord(unpack(E.TexCoords))
			button_icon:SetInside()
		end
	end

	hooksecurefunc('ItemSocketingFrame_Update', function()
		local sockets = _G.ItemSocketingFrame and _G.ItemSocketingFrame.Sockets
		if not sockets then return end

		for i, socket in ipairs(sockets) do
			local gemColor = GetSocketTypes(i)
			local color = E.GemTypeInfo[gemColor]
			if socket and color then
				socket:SetBackdropBorderColor(color.r, color.g, color.b)
			elseif socket then
				socket:SetBackdropBorderColor(unpack(E.media.bordercolor))
			end
		end
	end)

	if _G.ItemSocketingFramePortrait then
		_G.ItemSocketingFramePortrait:Kill()
	end

	if _G.ItemSocketingSocketButton then
		_G.ItemSocketingSocketButton:ClearAllPoints()
		_G.ItemSocketingSocketButton:Point('BOTTOMRIGHT', ItemSocketingFrame, 'BOTTOMRIGHT', -5, 5)
		S:HandleButton(_G.ItemSocketingSocketButton)
	end
end

S:AddCallbackForAddon('Blizzard_ItemSocketingUI')
