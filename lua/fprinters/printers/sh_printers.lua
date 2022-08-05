FPrinters = FPrinters or {}

hook.Add("InitPostEntity", "FPrinters::LoadPrinters", function()
    DarkRP.createCategory{
        name = "FPrinters",
        categorises = "entities",
        startExpanded = true,
        color = Color(255, 143, 47, 255),
        canSee = function(ply) return true end,
    }

    for name,values in pairs(FPrinters.Config.Printers) do
        local printer = scripted_ents.Get( "fprinters_base" )
        printer.PrintName = name
        printer.Defaults = values

        scripted_ents.Register( printer, values.Class )

        DarkRP.createEntity(name, {
            ent = values.Class,
            model = "models/props_c17/consolebox01a.mdl",
            cmd = values.Class,
            price = values.Price,
            max = values.MaxPrinters,
            category = "FPrinters", 
        })
    end
end)

hook.Add("playerBoughtCustomEntity", "FPrinters::ChangeOwner", function(ply, entTbl, ent, price)
    if entTbl.category == "FPrinters" then
        ent:CPPISetOwner(ply)
    end
end)