FPrinters = FPrinters or {}

if SERVER then
    include("fprinters/config/sh_config.lua")
    include("fprinters/printers/sh_printers.lua")
    include("fprinters/printers/sv_printers.lua")
    AddCSLuaFile("fprinters/config/sh_config.lua")
    AddCSLuaFile("fprinters/printers/sh_printers.lua")
    AddCSLuaFile("fprinters/vgui/cl_fonts.lua")
    AddCSLuaFile("fprinters/vgui/cl_printers_admin.lua")
    AddCSLuaFile("fprinters/vgui/cl_printer_menu.lua")
else
    include("fprinters/config/sh_config.lua")
    include("fprinters/printers/sh_printers.lua")
    include("fprinters/vgui/cl_fonts.lua")
    include("fprinters/vgui/cl_printers_admin.lua")
    include("fprinters/vgui/cl_printer_menu.lua")
end