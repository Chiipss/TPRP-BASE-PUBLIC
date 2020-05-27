-- TriggerEvent('tp-policedog:openMenu') to open menu

Config = {
    Job = 'police',
    Command = 'policedog', -- set to false if you dont want to have a command
    Model = 351016938,
    TpDistance = 50.0,
    Sit = {
        dict = 'creatures@rottweiler@amb@world_dog_sitting@base',
        anim = 'base'
    },
    Drugs = {'weed', 'weed_pooch', 'coca-powder', 'coca-paste', 'coke_pooch', 'coke', 'meth'}, -- add all drugs here for the dog to detect
}

Strings = {
    ['not_police'] = 'You are ~r~not ~s~an officer!',
    ['menu_title'] = 'Police dog',
    ['take_out_remove'] = 'Take out / remove police dog',
    ['deleted_dog'] = 'Removed the police dog',
    ['spawned_dog'] = 'Created a police dog',
    ['sit_stand'] = 'Make dog sit / stand',
    ['no_dog'] = "You don't have any dog!",
    ['dog_dead'] = 'Your dog is dead :/',
    ['search_drugs'] = 'Search closest player for drugs',
    ['no_drugs'] = 'No drugs found.', 
    ['drugs_found'] = 'Found drugs',
    ['dog_too_far'] = 'The dog is too far away!',
    ['attack_closest'] = 'Attack closest player'
}