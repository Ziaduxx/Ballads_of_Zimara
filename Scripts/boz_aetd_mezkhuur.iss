; ===============================================================================================================
/*
	Script Name: boz_aetd_mezkhuur.iss
    Description:
	Created By: Ziaduz 2024(c)

    Notes: Run on everyone
    Start at: "-836.36,69.95,-846.39" "-837.22,69.95,-846.33"
    By Rock at: "-885.98,67.73,-806.76"
    By Pillar at: "-831.49,68.57,-807.03"
*/
; ===============================================================================================================
#include "${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/InstanceController/Support_Files_Common/IC_Helper.iss"

variable string MobName="Mezkhuur"
variable point3f fPullSpot = "-837.22,69.95,-846.33"
variable point3f fRockSpot = "-885.98,67.73,-806.76"
variable point3f fMoveFromRock = "-894.16,67.25,-822.10"
 
variable point3f fPillarSpot1 = "-865.52,68.59,-872.77"
variable point3f fPillarSpot2 = "-858.95,68.72,-812.35"
variable point3f fPillarSpot3 = "-827.05,68.57,-804.88"
variable point3f fPillarSpot4 = "-802.36,69.20,-860.33"
variable point3f fMoveFromPillar1 = "-872.20,68.26,-863.57" 
variable point3f fMoveFromPillar2 = "-848.74,68.80,-808.79" 
variable point3f fMoveFromPillar3 = "-815.33,68.89,-808.43" 
variable point3f fMoveFromPillar4 = "-809.23,69.71,-869.31"


function main()
{
    ; ==========================================================================
    oc ${Me.Name} Starting the Script
    ; ==========================================================================
    while ${Actor[exactname,${MobName}].ID(exists)}
    {
        if (${Math.Distance[${Me.Loc}, ${fPullSpot}]} > 5)
        {
            if (${Math.Distance[${Me.Loc}, ${fRockSpot}]} < 8)
            {
                ;oc ${Me.Name} I'm by the rock
                call stuckbehindspot ${fRockSpot} ${fMoveFromRock}
            }
            elseif (${Math.Distance[${Me.Loc}, ${fPillarSpot1}]} < 8)
            {
                oc ${Me.Name} I'm by the 1st pillar 
                ; 1st: -865.52,68.59,-872.77
                ; Move: -872.20,68.26,-863.57
                call stuckbehindspot ${fPillarSpot1} ${fMoveFromPillar1}
            }
            elseif (${Math.Distance[${Me.Loc}, ${fPillarSpot2}]} < 8)
            {
                oc ${Me.Name} I'm by the 2sd pillar 
                ; 2sd: -858.95,68.72,-812.35
                ; Move: -848.74,68.80,-808.79
                call stuckbehindspot ${fPillarSpot2} ${fMoveFromPillar2}

            }
            elseif (${Math.Distance[${Me.Loc}, ${fPillarSpot3}]} < 8)
            {
                oc ${Me.Name} I'm by the 3rd pillar 
                ; 3rd: -827.05,68.57,-804.88
                ; Move: -815.33,68.89,-808.43
                call stuckbehindspot ${fPillarSpot3} ${fMoveFromPillar3}
                
            }
            elseif (${Math.Distance[${Me.Loc}, ${fPillarSpot4}]} < 8)
            {
                oc ${Me.Name} I'm by the 4th pillar
                ; 4th: -803.10,69.12,-859.07
                ; Move: -809.23,69.71,-869.31
                call stuckbehindspot ${fPillarSpot4} ${fMoveFromPillar4}
            }            
            else
            {
                ;oc ${Me.Name} I'm not near middle but not near Rock or Pillar also
                Ogre_CampSpot:Set_HowClose[${Me.Name}, 3]
                Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${fPullSpot}]
                wait 5
            }
        }
        wait 20
    }
}

function stuckbehindspot(point3f currentloc, point3f moveloc)
{
    ; Moves toon out so they can move back to pull spot
    Ogre_CampSpot:Set_HowClose[${Me.Name}, 3]
    Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${currentloc}]
    wait 10
    Ogre_CampSpot:Set_ChangeCampSpot[${Me.Name}, ${moveloc}]
    wait 10
}

function atexit()
{
    oc ${Me.Name} Ending Script for ${Zone.Name}
}
