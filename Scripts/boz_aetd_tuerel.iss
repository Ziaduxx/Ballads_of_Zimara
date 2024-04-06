; ===============================================================================================================
/*
	Script Name: boz_aetd_tuerel.iss
    Description: Script for "Tuer'el of the Delves"
	Created By: Ziaduz 2024(c)

*/
; ===============================================================================================================
#include "${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/InstanceController/Support_Files_Common/IC_Helper.iss"

variable string MobName="Tuer'el of the Delves"


function main()
{
    ; ==========================================================================
    oc ${Me.Name} Starting the Script for ${MobName}
    ; ==========================================================================

    ; ==========================================================================
    ; Disable necessary items
    ; ==========================================================================
    ; Disable Group and Raidwide Cures - Will manually cast them before arcane and after add dies
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_disable_group_cures TRUE FALSE TRUE 

    ; Disable these as for some reason the Arcane became enabled so doing nox also as a precaution
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_selective_stcure_arcane FALSE FALSE FALSE
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_selective_stcure_noxious FALSE FALSE FALSE
    
    ; ==========================================================================
    ; Enable on Settings2 - Enable Selective Single Target Cures
    ; ==========================================================================
    ; Going to enable only for Healers and not Mages if Two Healers in group
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_enable_selective_st_cures TRUE FALSE TRUE

    ; If People have the Eleemental and Arcane need to cure the Arcane
    ; For Elemental and Tramua
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_selective_stcure_elemental TRUE FALSE TRUE
    ; This is here as a forward thought on possible single target curing it off Mages only as they have their own solo cure
    ;oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_selective_stcure_trauma TRUE FALSE TRUE

    ; ==========================================================================
    ; Enable on Settings2 - Enable Auto Cure Potions for Elemental (So can target add) and Trauma (Not sure about enabling Trauma)
    ; ==========================================================================
    ; Enable Selective Pots - This could affect single target curing as is the Healer cures it just as 
    ; target is healer might cure arcane by mistake should not use I think at this time to stpo that

    ; oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_enable_curepotions TRUE FALSE TRUE

    ; ; For Elemental and Tramua pots
    ; oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_curepotion_elemental TRUE FALSE TRUE
    ; oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_curepotion_trauma TRUE FALSE TRUE


    ; ==========================================================================
    ; Curing Functionality
    ; ==========================================================================
    ; If we have two healers in grp we can split the grp in two, Healer 1 does first 3 members and healer two
    ; the last three. This way healers will not be double casting on a single person to mistakenly cure the Arcane
    ; There is always a chance that it can happen but this should reduce the chances.

    ; Whem the first Trauma comes it can be group cured, also if Trauma and Elemental only are on grp we should be able to group cure
    ; both before Arcane. The Arcane is casted on groups just prior to the add and bell spawning.
    ; After Add Dies we cna also group cure everything including the Arcane as its always reapplied prior to add spawning.

    ; We need the name of the spell cast or the text to attach script to it in order to get some timer on either the arcane cast tmie or add spwn time
    ; With those timers we can do cures either grp or single target between them.

    ; This functionality is actual not redifficult to code. 

    ; Exception - If one healer like my group, due to having 3 mages, They cna take the place of the second healer and cure only themselves
    ; of the Trauma and Elemental reducing the risk of mistakenly curing the Arance

    ;Thoughts?

    ; ==========================================================================
    ; Main Combat Loop
    ; ==========================================================================
    while ${Actor[exactname,${MobName}].ID(exists)}
    {
        wait 5
    }

}

function atexit()
{
    oc ${Me.Name} Ending Script for  for ${MobName} in ${Zone.Name}
    ; Enable Cure Curse and Cures
    oc !ci -ChangeOgreBotUIOption igw:${Me.Name} checkbox_settings_disablecaststack_curecurse FALSE FALSE FALSE
    oc !ci -ChangeOgreBotUIOption igw:${Me.Name} checkbox_settings_disablecaststack_cure FALSE FALSE FALSE

    ; Disable Selective single target Cures
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_enable_selective_st_cures FALSE FALSE FALSE
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_selective_stcure_elemental FALSE FALSE FALSE
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_selective_stcure_trauma FALSE FALSE FALSE

    ; Disable Selective Potion Cures
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_enable_curepotions FALSE FALSE FALSE
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_curepotion_elemental FALSE FALSE FALSE
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_curepotion_trauma FALSE FALSE FALSE
}
