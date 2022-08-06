FPrinters = FPrinters or {}

hook.Add("FPrinters_FinishedLoadingConfig", "FPrinters::LoadPrinters", function()
    print("Creating printers...")
    
    DarkRP.createCategory{
        name = "FPrinters",
        categorises = "entities",
        startExpanded = true,
        color = Color(255, 143, 47, 255),
        canSee = function(ply) return true end,
    }

    for id,values in pairs(FPrinters.Config.Printers) do
        local printer = scripted_ents.Get( "fprinters_base" )
        printer.PrintName = values.Name
        printer.Defaults = values

        local entName = "fprinters_" .. id

        scripted_ents.Register( printer, entName )

        DarkRP.createEntity(values.Name, {
            ent = entName,
            model = "models/props_c17/consolebox01a.mdl",
            cmd = entName,
            price = values.Price,
            max = FPrinters.Config.MaxPrinters,
            category = "FPrinters", 
        })
    end
end)

hook.Add("playerBoughtCustomEntity", "FPrinters::ChangeOwner", function(ply, entTbl, ent, price)
    if entTbl.category == "FPrinters" then
        ent:CPPISetOwner(ply)
    end
end)