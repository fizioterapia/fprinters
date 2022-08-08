if engine.ActiveGamemode() != 'darkrp' then
    print("FPrinters won't work on other gamemode than DarkRP!")
else
    FPrinters = FPrinters or {}

    if SERVER then
        include("fprinters/config/sh_config.lua")
        include("fprinters/vgui/phrases/sh_lang.lua")
        include("fprinters/printers/sh_printers.lua")
        include("fprinters/printers/sv_printers.lua")
        AddCSLuaFile("fprinters/config/sh_config.lua")
        AddCSLuaFile("fprinters/printers/sh_printers.lua")
        AddCSLuaFile("fprinters/vgui/phrases/sh_lang.lua")
        AddCSLuaFile("fprinters/vgui/cl_fonts.lua")
        AddCSLuaFile("fprinters/vgui/cl_printer_menu.lua")
        AddCSLuaFile("fprinters/vgui/cl_printer_admin.lua")
    else
        include("fprinters/config/sh_config.lua")
        include("fprinters/printers/sh_printers.lua")
        include("fprinters/vgui/phrases/sh_lang.lua")
        include("fprinters/vgui/cl_fonts.lua")
        include("fprinters/vgui/cl_printer_menu.lua")
        include("fprinters/vgui/cl_printer_admin.lua")
    end
end