require "Logger"

local Util = require "Util"

local LrApplication = import 'LrApplication'
local LrTasks = import "LrTasks"
local LrFunctionContext = import "LrFunctionContext"
local LrDialogs = import "LrDialogs"
local LrSelection = import "LrSelection"

local catalog = LrApplication.activeCatalog()

local top_colset_name = LOC "$$$/Archivist/TopColSet=Archivist"
local training_colset_name = LOC "$$$/Archivist/TrainingColSet=Training Photos"

local top_colset
local training_col

local function ensure_colsets() 
  opts = {timeout=1}
  top_colset = Util.getOrCreateCollectionSet(top_colset_name, nil, opts)
  training_col = Util.getOrCreateCollection(training_colset_name, top_colset, opts)
  logger:tracef( "Archivist: training colsets %s, %s", top_colset, training_col)
end



local function hello_world()
  LrFunctionContext.postAsyncTaskWithContext( "analyzing photos",
    function( context )  
      logger:tracef( "hello_world: enter" )
      LrDialogs.attachErrorDialogToFunctionContext( context )
        
      ensure_colsets()

      logger:tracef( "Archivist: List training photos" )
      LrTasks.startAsyncTask(
        function(context)
          logger:tracef("in task")
          training_photos = training_col:getPhotos()
          
          for i, photo in ipairs(training_photos) do
            logger:tracef("Photo %d: %s", i, photo)
          end
        end,
        "List training photos"
      )  
    end
  )
end


--------------------------------
hello_world()