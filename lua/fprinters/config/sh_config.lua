FPrinters = FPrinters or {}
FPrinters.Config = {
    MaxPrinters = 4,
    Phrases = {
        Language = "en",
    },
    Upgrades = {
        MaxTier = 10,
        StartTier = 1,
        Cost = 1000,
        CostMultiplier = 2, // (1 == 100%, no change || 2 == 200%, 2x price)
        SpeedIncrease = 0.25 // Speed = Speed - (SpeedIncrease * Tier) = 5 - (0.1 * 10) = 4
    },
    Printers = {
        {
            Name = "Default Printer",
            HP = 100,
            Capacity = 10000,
            Speed = 5,
            PrintAmount = 100,
            Price = 100,
            Color = Color(255,100,150)
        }
    }
}

function FPrinters.SaveConfig()
    file.Write("fprinters/config.txt", util.TableToJSON(FPrinters.Config))
end

hook.Add("InitPostEntity", "FPrinters::LoadConfig", function()
    if CLIENT then
        net.Start("FPrinters_SyncConfig")
        net.SendToServer()

        net.Receive("FPrinters_SyncConfig", function()
            local data = net.ReadString()
            data = util.JSONToTable(data)

            FPrinters.Config = data

            hook.Call("FPrinters_FinishedLoadingConfig")
        end)
    else
        util.AddNetworkString("FPrinters_SyncConfig")
        net.Receive("FPrinters_SyncConfig", function(len, ply)
            if !IsValid(ply) then return end

            print("[FPrinters] Sending config to: " .. ply:Name())

            net.Start("FPrinters_SyncConfig")
                net.WriteString(util.TableToJSON(FPrinters.Config))
            net.Send(ply)
        end)

        if (!file.Exists("fprinters/", "DATA") || !file.Exists("fprinters/config.txt", "DATA")) then
            file.CreateDir("fprinters")
            file.Write("fprinters/config.txt", util.TableToJSON(FPrinters.Config))
        else
            FPrinters.Config = util.JSONToTable(file.Read("fprinters/config.txt", "DATA"))
        end

        hook.Call("FPrinters_FinishedLoadingConfig")
    end
end)