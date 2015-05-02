---
--- World Edit script
---

-- load dependencies
include("i18n/i18n.lua");
include("blocks.lua");
include("listeners/playerListener.lua");
include("listeners/commandListener.lua");


local world = getWorld();


function onEnable()
	local config = getProperty("config.properties");

	i18n.init(config);

	-- The console already prepend the script name on every log output
  print("Script v0.5.67 loaded.");
end



function getCoordsFromMarkEvent(e)
	return e ~= false and {
		e.startChunkpositionX,
		e.startChunkpositionY,
		e.startChunkpositionZ,

		e.startBlockpositionX,
		e.startBlockpositionY,
		e.startBlockpositionZ,

		e.endChunkpositionX,
		e.endChunkpositionY,
		e.endChunkpositionZ,

		e.endBlockpositionX,
		e.endBlockpositionY,
		e.endBlockpositionZ
	} or nil;
end



function fillWith(c, texId, cleanup)
	if cleanup then
		removeAll(c, true);
	end
	world:setTerrainDataInArea(c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12], texId);
end

function fillWithBlock(c, blockID)
	world:setBlockDataInArea(c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12], blockID);
end


function removeObjects(c)
	world:removeAllObjectsInArea(c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12]);
end

function removeConstr(c)
	world:removeAllConstructionsInArea(c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12]);
end

function removeVeg(c)
	world:removeAllVegetationsInArea(c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12]);
end

function removePlayerBlocks(c)
	fillWithBlock(c, 0);
end

function removeTerrainBlocks(c)
	world:setTerrainDataInArea(c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12], 0);
end

function removeAll(c, clearTerrain)
	removeObjects(c);
	removeConstr(c);
	removeVeg(c);
	removePlayerBlocks(c);
	if clearTerrain then
		removeTerrainBlocks(c);
	end
end