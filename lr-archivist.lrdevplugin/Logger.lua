--[[----------------------------------------------------------------------------

 Archivist
 Copyright 2017 Dmitry Serebrennikov

--------------------------------------------------------------------------------

Logger.lua

------------------------------------------------------------------------------]]

-- Access the Lightroom SDK namespaces.
local LrLogger = import "LrLogger"

-- Create the logger and enable the print function.
logger = LrLogger( "com.nitecoder.lightroom.archivist" )
logger:enable( "logfile" )
