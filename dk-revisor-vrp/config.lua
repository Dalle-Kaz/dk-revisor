Config = {}

Config.webhook = "" -- Webhook.

------------------------------------------------------------

Config.job = "Mekaniker Chef" -- Det job man skal have få at bruge menuen.

Config.DirtyMoney = 'dirty_money' -- Sorte penge item 

------------------------------------------------------------

Config.useoxtaget = true -- Om den skal lave et ox target eller bare bruge commanden.

Config.OpenPlaces = { -- Alle de steder den laver et ox target hvis Config.useoxtaget er true.
    vector3(-1556.1042480469,-574.69390869141,108.52715301514),
    vector3(-585.8406, -337.2523, 35.9197-0.4)
}

------------------------------------------------------------

Config.Command = { -- Command settings
    useCommand = true, -- Om man kan bruge en command til at åbne menu'en.
    command = 'revisor' -- Commanden
}

------------------------------------------------------------

Config.Rules = { -- Relger scriptet føgler
    WashEmployees = false, -- Om man kan hvaske andre revisors penge.
    WashOwn = true, -- Om man kan hvaske sin egen penge.
    MaxPercentage = 50 -- Det max procent tal en revisor kan tage
}

------------------------------------------------------------