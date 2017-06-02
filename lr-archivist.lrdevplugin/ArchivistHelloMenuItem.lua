require "Logger"

local LrApplication = import 'LrApplication'
local LrFunctionContext = import "LrFunctionContext"
local LrDialogs = import "LrDialogs"

local catalog = LrApplication.activeCatalog()

local top_colset_name = "Archivist"


local function find_top_collection_set()
  local colsets = catalog:getChildCollectionSets()
  for i, colset in ipairs(colsets) do
    if colset:getName() == top_colset_name then
      logger:tracef("Found top colset %s (%s)", colset:getName(), colset.localIdentifier)
      return colset
    end
  end
end


local function hello_world()
  LrFunctionContext.postAsyncTaskWithContext( "analyzing photos",
    function( context )  
      logger:tracef( "hello_world: enter" )
      LrDialogs.attachErrorDialogToFunctionContext( context )
        
      logger:tracef( "Archivist: Starting" )
      local colset = find_top_collection_set()
      logger:tracef( "Archivist: colset %s", colset:getName())
    end
  )
end


--------------------------------
hello_world()