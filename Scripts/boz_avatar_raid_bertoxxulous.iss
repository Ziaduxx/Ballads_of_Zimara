; ===============================================================================================================
/*
	Script Name: boz_avatar_raid_bertoxxulous.iss
    Description:
	Created By: Ziaduz 2024(c)

    Notes: 
    
    Dets: 
    ${OgreBotAPI.DetrimentalInfo[MainIcon, BackDropIcon]}
    Name: Blood Plague MainIconID: 1128 BackDropIconID: 262 
    Name: Mind Plague MainIconID: 1129 BackDropIconID: 262 
    Name: Clubbed Feet MainIconID: 746 BackDropIconID: 651 
    Name: Infectious Scratches MainIconID: 934 MainIconID: 314
*/
; ===============================================================================================================

; ===============================================================================================================
; FILES TO INCLUDE
; ===============================================================================================================
#include "${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/InstanceController/Ogre_Instance_Include.iss"

; ===============================================================================================================
; VARIABLES
; ===============================================================================================================
variable string MobName = "Bertoxxulous"
variable point3f TankSpot = "63.00,-483.00,-70.00" 
variable string TankSpot2 = "62.51,-483.05,-51.85"
variable point3f RaidSpot = "63.00,-483.00,-90.00"
variable point3f BloodPlagueSpot = "63.00,-483.00,-107.00"
variable point3f MindPlagueSpot = "63.00,-483.00,-70.00"
variable bool IsTank = FALSE
variable bool IsMeele = FALSE

; ===============================================================================================================
; MAIN FUNCTION
; ===============================================================================================================
function main()
{
    oc ${Me.Name}: Starting the ${MobName} helper script.

	;Initialize/Attach the event Atoms that we defined previously
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]

    if ${Me.Class.Equals["crusader"]} || ${Me.Class.Equals["warrior"]} || ${Me.Class.Equals["brawler"]}
    {
        IsTank:Set[TRUE]
        OgreBotAPI:ChangeCastStackListBoxItemByTag[${Me.Name},Snap,FALSE,FALSE,TRUE]
        OgreBotAPI:ChangeCastStackListBoxItemByTag[${Me.Name},Snap2,FALSE,FALSE,TRUE]
    }

    Ogre_CampSpot:Set_HowClose[${Me.Name}, 2]

    while ${Actor[exactname,${MobName}].ID(exists)}
    {
        ; Set intial Tank Spot
        Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}+fighter, ${TankSpot}]
        ; Set intial Raid Spot
        Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}+notfighter, ${RaidSpot}]

        ;Blood Plague
        if ${OgreBotAPI.DetrimentalInfo[1128, 212]}
        {
            call BloodPlague
        }

        ;Mind Plague
        if ${OgreBotAPI.DetrimentalInfo[1129, 262]}
        {
            call MindPlague
        }

        wait 5
    }
}

function DisableTank()
{
    ; Disable Combat and cast Subtle Strikes
    oc !ci -CastAbility igw:${Me.Name} "Subtle Strikes"
    oc !ci -ChangeOgreBotUIOption igw:${Me.Name} checkbox_settings_disablecaststack TRUE TRUE
    ; Don't move till not hated so you don't pull mob
    while ${Me.IsHated}
    {
        wait 20
    }
}

function BloodPlague()
{
    ; Different Text for Tank who has it
    if ${IsTank}
        eq2ex r ${Me.Name}: TANK HAVE BLOOD PLAGUE: MOVING OUT FROM ${MobName}.
    else
        eq2ex r I HAVE BLOOD PLAGUE: MOVING OUT FROM ${MobName}.

    ; Need to put in fighter code to switch agro
    if ${IsTank}
        call DisableTank

    ; Move to Blood Plague Spot
    Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${BloodPlagueSpot}]

    if ${OgreBotAPI.DetrimentalInfo[746, 651]}
    {
        eq2ex r I HAVE CLUB FOOT BLOOD PLAGUE: MOVING ${MobName}.
    }
        
    while ${OgreBotAPI.DetrimentalInfo[1128, 212]}
    {
        wait 5
    }

    ; Move back to Tank or Raid Spot
    if ${IsTank}
    {
        ; Reanble Cast Stack and Cancel 
        oc !ci -ChangeOgreBotUIOption igw:${Me.Name} checkbox_settings_disablecaststack FALSE FALSE
        oc !ci -CancelMaintainedForWho igw:${Me.Name} "Subtle Strikes"
        Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${TankSpot}]
    }
    else
    {
        Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${RaidSpot}]
    }
}

function MindPlague()
{
    eq2ex r I HAVE MIND PLAGUE: MOVING TO ${MobName}.

    if !${IsTank}
        Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${MindPlagueSpot}]

    if ${OgreBotAPI.DetrimentalInfo[746, 651]}
    {
        eq2ex r I HAVE CLUB FOOT MIND PLAGUE: MOVING ${MobName}.
    }
    
    while ${OgreBotAPI.DetrimentalInfo[1129, 262]}
    {
        wait 5
    }

    ; Move back to Raid Spot && !${IsMeele}
    if !${IsTank} 
    {
        Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${RaidSpot}]
    }
}

atom EQ2_onIncomingText(string Text)
{
    ; Trying to handle the agro switch if needed
    if ${Text.Find["${Me.Name}: TANK HAVE BLOOD PLAGUE"]}
    {
        ; Do nothing
        wait 5
    }
    elseif ${Text.Find["TANK HAVE BLOOD PLAGUE"]}
    {
        if !${Me.IsHated}
        {
            oc !ci -CastAbility igw:${Me.Name} "Rescue"
            wait 10
        }
        
        if !${Me.IsHated}
        {
            oc !ci -CastAbility igw:${Me.Name} "Sneering Assult"
            wait 10 
        }   
    }
    ; elseif ${Text.Find["I HAVE CLUB FOOT MIND PLAGUE"]}
    ; {
    ;     Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${RaidSpot}]
    ;     wait 50
    ;     Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${TankSpot2}]   
    ;     wait 30
    ;     Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${TankSpot}]
    ;     wait 20
    ; }

}

atom atexit()
{
    ; We're done with the script, so let's detach all of the event atoms
	Event[EQ2_onIncomingText]:DetachAtom[EQ2_onIncomingText]

    Ogre_CampSpot:Set_HowClose[${Me.Name}, 5]
    OgreBotAPI:ChangeCastStackListBoxItemByTag[${Me.Name},Snap,TRUE,FALSE,TRUE]
    OgreBotAPI:ChangeCastStackListBoxItemByTag[${Me.Name},Snap2,TRUE,FALSE,TRUE]
    oc ${Me.Name}: Ending the ${MobName} helper script.
}
