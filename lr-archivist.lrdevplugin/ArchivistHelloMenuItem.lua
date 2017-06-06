require "Logger"

local LrApplication = import 'LrApplication'
local LrFunctionContext = import "LrFunctionContext"
local LrDialogs = import "LrDialogs"
local LrTasks = import "LrTasks"

local catalog = LrApplication.activeCatalog()

local top_colset_name = "Archivist"


--local function get_or_create_top_colset()
--  local colsets = catalog:getChildCollectionSets()
--  for i, colset in ipairs(colsets) do
--    if colset:getName() == top_colset_name then
--      logger:tracef("Found top colset %s (%s)", colset:getName(), colset.localIdentifier)
--      return colset
--    end
--  end
--  
--  -- Top colset not found. Create it. We don't take the write lock until here.
--  local created = nil
--  catalog:withWriteAccessDo(
--    LOC "$$$/Archivist/CreateTopColSet=Create Archivist top collection set",
--    function () created = catalog:createCollectionSet(top_colset_name, nil, true) end,
--    { timeout = 1 }
--  ) 
--  return created
--end

-- Similar to LrCatalog:createCollectionSet but takes care of locking if necessary
-- At the same time, avoids taking the lock if collection already exists.
-- Options are passed to withWriteAccessDo if it has to be called.
function getOrCreateCollectionSet(name, parent, options)
  local attempt = 0
  local result
  local f = function ()
    attempt = attempt + 1
    logger:tracef("attempt %d", attempt)
    result = catalog:createCollectionSet(name, parent, true)
    return result
  end

  -- First attempt to call without taking a lock
  local status, res = LrTasks.pcall(f)
  if status then
    -- Either we found an existing set or we were able to create one because
    -- the write lock was already obtained by the caller
    return res
  end

  -- If here, we need the write access (hopefully)
  -- logger:tracef("getOrCreateCollectionSet pcall failed (%s): %s", type(message), message)
  return catalog:withWriteAccessDo(
    LOC "$$$/Archivist/CreateTopColSet=Create collection set " .. name,
    f
  )
end


local function hello_world()
  LrFunctionContext.postAsyncTaskWithContext( "analyzing photos",
    function( context )  
      logger:tracef( "hello_world: enter" )
      LrDialogs.attachErrorDialogToFunctionContext( context )
        
      logger:tracef( "Archivist: Starting" )
      local colset = getOrCreateCollectionSet(top_colset_name, nil, {timeout=1})
      logger:tracef( "Archivist: colset %s", colset:getName())
    end
  )
end


--------------------------------
hello_world()