; TESTING GITHUB COMMIT AND PULL FOR THOR
; DOING ANOTHER TEST FOR THOR - at 3:08PM
;Run on everyone.
#include "${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/InstanceController/Ogre_Instance_Include.iss"
variable string MobName="Erollisi Marr"
variable point3f TankSpot = "-2.75,37.65,-276.06" 
variable point3f Joust1Spot = "11.36,37.65,-275.47"
variable point3f Joust2Spot = "-17.85,37.65,-274.65"

function main()
{
    variable bool Divided=FALSE	
    oc ${Me.Name}: Starting the ${MobName} helper script.

    while ${Actor[exactname,${MobName}].ID(exists)}
    {
        Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${TankSpot}]
	
	    ;Name: Two Hearts Joined BackDropIconID: 314 MainIconID: 496
        if ${OgreBotAPI.DetrimentalInfo[496, 314]} || ${OgreBotAPI.DetrimentalInfo[496, 317]}
        {
	    ;oc !ci -joustout ${Me.Name}
            eq2ex r I have Two Hearts Joined: Get me back to the raid and cure my curse.
            wait 50
        }

	    ;Name: Two Hearts Divided BackDropIconID: 317 MainIconID: 170
        if ${OgreBotAPI.DetrimentalInfo[170, 317]}
        {
            eq2ex r I have Two Hearts Divided: Moving out for cure.
            Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${Joust1Spot}]
	    ;oc !ci -joustout ${Me.Name}
            wait 50
        }
	
	    ;Name: Two Hearts Divided BackDropIconID: 314 MainIconID: 170
        if ${OgreBotAPI.DetrimentalInfo[170, 314]} 
        {
            eq2ex r I have Two Hearts Divided: Moving out for cure.
            Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${Joust2Spot}]
            ;oc !ci -joustout ${Me.Name}
            wait 50
        }
    wait 5
    }
}

atom atexit()
{
;    oc !ci -ChangeOgreBotUIOption igw:${Me.Name} checkbox_settings_disablecaststack_curecurse FALSE FALSE FALSE
    oc ${Me.Name}: Ending the ${MobName} helper script.
}
