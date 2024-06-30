Config = {}

Config.webhook = "" -- Webhook.

Config.usecommand = true -- Om man kan bruge en command til at åbne menu'en.

Config.command = {
    command = 'revisor', -- Hvad skal commanden for at åbne menuen være?
    NeedsToBeInZone = true, -- Hvis du vil have at revisoren skal stå ved at bestment sted for at åbne menuen sæt denne til true, hvis den skal kunne åbnes overalt sæt til false.
    Distance = 2.5 -- Den afstand du skal vær af en af coords'ne.
}

Config.UsingQbTarget = true -- Skal du bruge QB Target så sæt denne true hvis ikke false.

Config.job = "revisor" -- Det job man skal have få at bruge menuen.

Config.Item = 'markedbills' -- Blackmoney Item.

Config.Time = 3 -- Hvor mange gange skal antalpenge ganges for at få tiden det tager at beregne.
Config.MaxMoney = 1000000 -- Hvis antal af penge er over en million så ganger den ikke tiden og sørger for at det max kan tage 15 minutter.
Config.MaxTime = 900000 -- Hvis antal af penge ganget med 3 overstiger 15 minutter så bliver tiden sat til 15 minutter.

Config.OpenPlaces = { -- Steder hvor du kan åbne menuen, med Qbtarget hvis den er true, og eller med command hvis nneds to be in zone er true.
    vector3(-81.05, -802.13, 243.4),
    vector3(-72.5693, -814.1973, 243.3860),
}

-- ENGLISH
Config.Lang = { 
    ['accountant'] = 'Accountant',
    ['open_accountant'] = 'Open accountant tablet', 
    ['accountant_menu_title'] = 'Accountant Menu', 
    ['money_ammount'] = 'Amount of money', 
    ['money_ammount_bio'] = 'How much money needs to be washed?',
    ['id_players'] = 'ID of the player', 
    ['id_players_bio'] = 'ID of the player who needs to have their cash washed', 
    ['take_procent'] = 'How many percent', 
    ['take_procent_bio'] = 'How many percent do you want to take?', 
    ['invalid_space'] = 'One or more text fields need to be filled out', 
    ['cancled'] = 'You canceled the transaction', 
    ['proccessing_error'] = 'Wait to wash more cash until youre finished, or press X to cancel', 
    ['perm_error'] = 'You do not have access to this!', 
    ['location_error'] = 'You need to be at the accountants computer to wash with this command!', 
    ['confirm_message'] = 'Do you want the accountant to wash: $',
    ['person_is_accountant_error'] = 'You cannot wash the persons money as they are accountant themselves',
    ['you_are_accountant_error'] = 'You cannot wash this money as you are accountant yourself', 
    ['not_enough_money'] = 'The person does not have enough black cash on them',
    ['not_online'] = 'The player is not online', 
    ['not_confirm'] = 'The player did not confirm!', 
    ['washed'] = 'You washed: $', 
    ['earned'] = 'The accountant business earned: $',
    ['money_amount'] = 'Amount to be laundered: ', 
    ['id_accountant'] = 'ID of the accountant: ',
    ['id_player'] = 'ID of the player: ', 
    ['player_earned'] = 'Player earned: ',
    ['accountant_earned'] = 'Accountant earned: ', 
}

-- DANISH
--[[ Config.Lang = { 
    ['accountant'] = 'Revisor',
    ['open_accountant'] = 'Åben revisor tablet',
    ['accountant_menu_title'] = 'Revisor menu',
    ['money_ammount'] = 'Antal penge',
    ['money_ammount_bio'] = 'Hvor mange penge skal bogføres?',
    ['id_players'] = 'ID på spiller',
    ['id_players_bio'] = 'ID på spiller der skal have bogført sine kontanter',
    ['take_procent'] = 'Hvor mange procent',
    ['take_procent_bio'] = 'Hvor mange procent vil du tage?',
    ['invalid_space'] = 'En(flere) tekst felter mangler at blive udfyldt',
    ['cancled'] = 'Du annullerede bogførlsen',
    ['proccessing_error'] = 'Vent med at bogføre flere kontanter til du er færdig. Eller tryk [X] for at annullere', 
    ['perm_error'] = 'Du har ikke adgang til dette!',
    ['location_error'] = 'Du skal stå ved revisor computeren for at bogføre med denne kommando!',
    ['confirm_message'] = 'Vil du have revisoren til at bogfører: DKK',
    ['person_is_accountant_error'] = 'Du kan ikke bogfører personens penge da de selv er revisor',
    ['you_are_accountant_error'] = 'Du kan ikke hvidvaske dine egne penge da du selv er revisor',
    ['not_enough_money'] = 'Personen har ikke nok sorte kontanter på sig',
    ['not_online'] = 'Spilleren er ikke online',
    ['not_confirm'] = 'Spilleren accepterede ikke!',
    ['washed'] = 'Du bogførte: DKK ',
    ['earned'] = 'Revisor firmaet tjente: DKK ',
    ['money_amount'] = 'Beløb der skal hvidvaskes: ',
    ['id_accountant'] = 'ID på revisor: ',
    ['id_player'] = 'ID på spiller: ',
    ['player_earned'] = 'Spiller tjente: ',
    ['accountant_earned'] = 'Revisor Tjente: ',
} ]]