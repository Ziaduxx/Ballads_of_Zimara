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
    ; First Disable Cure Curse and Cures
    ; ==========================================================================
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_disablecaststack_cure TRUE FALSE TRUE
    oc !ci -ChangeOgreBotUIOption ${Me.Name} checkbox_settings_disablecaststack_cure TRUE FALSE TRUE

    ; ==========================================================================
    ; Enable on Settings2 - Enable Selective Single Target Cures
    ; Not sure if this overrides the disabled Cure functionality
    ; ==========================================================================

    ; ==========================================================================
    ; Enable on Settings2 - Enable Auto Cure Potions for Elemental (So can target add) and Trauma (Not sure about enabling Trauma)
    ; Not sure 100% if cures are disabiled
    ; ==========================================================================

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
}
