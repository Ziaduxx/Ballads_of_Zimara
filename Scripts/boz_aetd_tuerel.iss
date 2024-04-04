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
    ; First Disable Cure Curse, Group and Raid, and Single Target Cures
    ; ==========================================================================
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_disablecaststack_curecurse TRUE FALSE TRUE
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_disable_group_cures TRUE FALSE TRUE
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_disable_singletarget_cures TRUE FALSE TRUE

    ; ==========================================================================
    ; Enable on Settings2 - Enable Selective Single Target Cures
    ; Not sure if this overrides the disabled Cure functionality
    ; ==========================================================================
    ; Enable Selective Cures 
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_enable_selective_st_cures TRUE FALSE TRUE

    ; For Elemental and Tramua
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_selective_stcure_elemental TRUE FALSE TRUE
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_selective_stcure_trauma TRUE FALSE TRUE

    ; ==========================================================================
    ; Enable on Settings2 - Enable Auto Cure Potions for Elemental (So can target add) and Trauma (Not sure about enabling Trauma)
    ; Not sure 100% if cures are disabiled that this will work
    ; ==========================================================================
    ; Enable Selective Cures 
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_enable_curepotions TRUE FALSE TRUE

    ; For Elemental and Tramua pots
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_curepotion_elemental TRUE FALSE TRUE
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_curepotion_trauma TRUE FALSE TRUE

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
