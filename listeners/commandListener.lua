
include("command-parser/parse-args.lua");
include("security.lua");
include("table-ext.lua");


local textureAliasMap = {
  air = 0,
  dirt = 1,
  grass = 2,
  stone = 3
  --- TODO : add more textures!
};
local fillAvailableArgs = table.keys(textureAliasMap);
local clearAvailableArgs = {"obj","con","veg","all","abs"};

table.insert(fillAvailableArgs, "#id");


local function weHelp(event, args)
  local helpContext = string.lower(args[1] or "");

  if helpContext == "select" then
    print("Showing /we select help");
    event.player:sendTextMessage("[#33FF33]/we select");
    event.player:sendTextMessage("[#FFFF00]"..i18n.t(event.player, "help.select.usage"));
  elseif helpContext == "cancel" then
    print("Showing /we cancel help");
    event.player:sendTextMessage("[#33FF33]/we cancel");
    event.player:sendTextMessage("[#FFFF00]"..i18n.t(event.player, "help.cancel.usage"));
  elseif helpContext == "clear" then
    print("Showing /we clear help");
    event.player:sendTextMessage("[#33FF33]/we clear ["..table.concat(clearAvailableArgs, '|').."]");
    event.player:sendTextMessage("[#FFFF00]"..i18n.t(event.player, "help.clear.usage"));
  elseif helpContext == "fill" then
    print("Showing /we fill help");
    event.player:sendTextMessage("[#33FF33]/we fill ["..table.concat(fillAvailableArgs, '|').."]");
    event.player:sendTextMessage("[#FFFF00]"..i18n.t(event.player, "help.fill.usage"));
  elseif helpContext == "place" then
    print("Showing /we place help");
    event.player:sendTextMessage("[#33FF33]/we place blocktype id [north|east|south|west] [sideway|flipped]");
    event.player:sendTextMessage("[#FFFF00]"..i18n.t(event.player, "help.place.usage"));
    event.player:sendTextMessage("[#FFFF00]"..i18n.t(event.player, "help.place.blocktypes", "blocktype", table.concat(getBlockTypes(), ', ')));
  else
    print("Showing general help");
    event.player:sendTextMessage("[#33FF33]/we help|select|cancel|clear|fill|place [args]");
    event.player:sendTextMessage("[#FFFF00]"..i18n.t(event.player, "help.usage", "/we help clear"));
  end
end



local function setLabel(event, text)
  local label = event.player:getAttribute("stateLabel");

  if text then
    label:setText(text);
    label:setVisible(true);
  else
    label:setText("");
    label:setVisible(false);
  end
end



local function weSelect(event)
  print("Area selection start");
  event.player:enableMarkingSelector(function()

  end);

  setLabel(event, i18n.t(event.player, "select.start"));
end


local function weCancel(event)
  event.player:disableMarkingSelector(function(markingEvent)
    if markingEvent ~= false then
      setLabel(event);

      print("Area selection cancelled");
      event.player:sendTextMessage("[#FF0000]"..i18n.t(event.player, "select.cancelled"));
    end
  end);
end


local function weClear(event, args, flags)
  local clearObjType = string.lower(args[1] or "all");

  event.player:disableMarkingSelector(function(markingEvent)
    if markingEvent ~= false then
      local coords = getCoordsFromMarkEvent(markingEvent);
      setLabel(event);

      if clearObjType == "obj" then
        print("Clearing area of objects");
        removeObjects(coords);
      elseif clearObjType == "con" then
        print("Clearing area of construction");
        removeConstr(coords);
      elseif clearObjType == "veg" then
        print("Clearing area of vegetation");
        removeVeg(coords);
      elseif clearObjType == "all" then
        print("Clearing area of all");
        removeAll(coords, false);
      elseif clearObjType == "abs" then
        print("Clearing area of absolutely everything");
        removeAll(coords, true);
      else
        return event.player:sendTextMessage("[#FF0000]"..i18n.t(event.player, "cmd.use.args", table.concat(clearAvailableArgs, ", ")));
      end
    else
      event.player:sendTextMessage("[#FF0000]"..i18n.t(event.player, "cmd.no.selection"));
    end
  end);

end


local function wePlaceBlock(event, args, flags)
  local blockType = args[1] and string.lower(args[1]);
  local direction = args[3] and string.lower(args[3]) or "north";
  local orientation = args[4] and string.lower(args[4]) or "";
  local blockId = args[2] and getBlockId(tonumber(args[2]), blockType, direction, orientation);

  if blockType and blockId then

    if blockId < 21 then
      print("Block id adjusted from "..blockId.." to 21");
      blockId = 21;
    end;

    event.player:disableMarkingSelector(function(markingEvent)
      if markingEvent ~= false then
        local coords = getCoordsFromMarkEvent(markingEvent);
        setLabel(event);

        print("Placing "..blockType.." in area with id "..blockId..(cleanup ~= nil and " with cleanup" or ""));
        fillWithBlock(coords, blockId);
      else
        event.player:sendTextMessage("[#FF0000]"..i18n.t(event.player, "cmd.no.selection"));
      end
    end);
  elseif blockType == nil then
    event.player:sendTextMessage("[#FF0000]"..i18n.t(event.player, "cmd.missing.arg", "type"));
  elseif blockId == nil then
    event.player:sendTextMessage("[#FF0000]"..i18n.t(event.player, "cmd.missing.arg", "id"));
  end
end


local function weFill(event, args, flags)
  local cleanup = flags["c"] or flags["clean"];
  local id = tonumber(args[1]) or textureAliasMap[string.lower(args[1] or "")];

  if id then

    if id < 0 or id > 16 then
      print("Terrain id adjusted from "..id.." to 0");
      id = 0;
    end;

    event.player:disableMarkingSelector(function(markingEvent)
      if markingEvent ~= false then
        local coords = getCoordsFromMarkEvent(markingEvent);
        setLabel(event);

        print("Filling area with id "..id..(cleanup ~= nil and " with cleanup" or ""));
        fillWith(coords, id, cleanup);
      else
        event.player:sendTextMessage("[#FF0000]"..i18n.t(event.player, "cmd.no.selection"));
      end
    end);
  else
    event.player:sendTextMessage("[#FF0000]"..i18n.t(event.player, "cmd.use.args", table.concat(fillAvailableArgs, ", ")));
  end
end



local function onPlayerCommand(event)
  local args, flags = parseArgs(event.command);
  local cmd;

  if #args >= 1 then

    if string.lower(args[1]) == "/we" then
      -- command handled
      event:setCancel(true);

      cmd = string.lower(args[2] or "");

      if cmd == "help" then
        if checkPlayerAccess(event.player, "help") then weHelp(event, table.slice(args, 3)); end;
      elseif cmd == "select" then
        if checkPlayerAccess(event.player, "select") then weSelect(event); end;
      elseif cmd == "cancel" then
        weCancel(event); -- no player access necessary...
      elseif cmd == "clear" then
        if checkPlayerAccess(event.player, "clear") then weClear(event, table.slice(args, 3), flags); end;
      elseif cmd == "fill" then
        if checkPlayerAccess(event.player, "fill") then weFill(event, table.slice(args, 3), flags); end;
      elseif cmd == "place" then
        if checkPlayerAccess(event.player, "place") then wePlaceBlock(event, table.slice(args, 3), flags); end;
      else
        print("Unknown command: "..event.command);
        event.player:sendTextMessage("[#FF0000]"..i18n.t(event.player, "cmd.unknown"));
      end
    end
  end
end
addEvent("PlayerCommand", onPlayerCommand);
