
--- Player connect event.
-- This event is triggered when a player connects to the server. Note that the
-- player is currently in the loadingscreen at the moment this event is triggered,
-- so it's useless to display anything on the players screen.
-- @param event The event object. Cancel the event to prevent the player to connect
function onPlayerConnect(event)
	local label = Gui:createLabel("", 0.05, 0.3);
	label:setFontsize(19);
	label:setVisible(false);
	label:setFontColor(0xFFFF00FF); -- yellow, opaque
	label:setPivot(0);  -- left aligned
	event.player:setAttribute("weStateLabel", label);
	event.player:addGuiElement(label);
end
addEvent("PlayerConnect", onPlayerConnect);