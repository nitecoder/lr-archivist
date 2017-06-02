--[[----------------------------------------------------------------------------

 Helper plugin for sorting and organizing old photos
 Copyright 2017 Dmitry Serebrennikov

--------------------------------------------------------------------------------

Info.lua
Summary information for the plug-in.

Adds menu items to Lightroom.

------------------------------------------------------------------------------]]

return {
  
  LrSdkVersion = 5.0,
  LrSdkMinimumVersion = 5.0, -- minimum SDK version required by this plug-in

  LrToolkitIdentifier = "com.nitecoder.lightroom.archivist",

  LrPluginName = LOC( "$$$/Archivist/PluginName=Archivist" ),
  LrPluginInfoUrl = "https://github.com/nitecoder/lr-archivist",
  
  -- Add the menu item to the Library menu.
  
  LrLibraryMenuItems = {
    {
      title = LOC( "$$$/Archivist/LibraryMenuItem=Hello World" ),
      file = "ArchivistHelloMenuItem.lua",
      enabledWhen = "photosAvailable",
    }
  },

  VERSION = { major = 1, minor = 0, revision = 0, build = 1, },

}
