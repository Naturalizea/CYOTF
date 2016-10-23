#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

ForStartContrib : ContributionItem
{
    ChapterName = 'The Forest'
    Author = 'Naturalizea'
    Date = '2016/10/23'
    Description = 'Player wakes up lost in a forest'
}

ForStartHook : IntroHook
{
    name = 'The Forest'
    event()
    {
        clearScreen();
        Player.moveInto(ForRoom);
        
        local genderArray = [
            ['Male',ForMaleHook],
            ['Female',ForFemaleHook]
        ];
        
        "<br>Are you male or female?<br>";
        PresentChoice(genderArray);
        
        ContributionBanner.Update(ForStartContrib);
    }
}

ForMaleHook : Hook
{
    event()
    {
        libGlobal.playerChar.isHim = true;
        libGlobal.playerChar.isHer = nil;
    }
}

ForFemaleHook : Hook
{
    event()
    {
        libGlobal.playerChar.isHer = true;
        libGlobal.playerChar.isHim = nil;
    }
}

ForRoom : OutdoorRoom
{
    roomName = 'Lost on a forest'
}