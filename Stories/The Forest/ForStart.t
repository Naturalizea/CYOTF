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
        
        Player.moveInto(ForForest);
        
        local genderArray = [
            ['Male',ForMaleHook],
            ['Female',ForFemaleHook]
        ];
        
        "<br>Are you male or female?<br>";
        PresentChoice(genderArray);
        
        clearScreen();
        "You wake up, and find yourself lost deep within a forest. You don't know how you got here, but it seems that all you can really do is wonder around and try
        to find something.";        
        ContributionBanner.Update(ForStartContrib);
    }
}

ForMaleHook : Hook
{
    event()
    {
        libGlobal.playerChar.isHim = true;
        libGlobal.playerChar.Tags += 'MALE';
        libGlobal.playerChar.isHer = nil;
    }
}

ForFemaleHook : Hook
{
    event()
    {
        libGlobal.playerChar.isHer = true;
        libGlobal.playerChar.Tags += 'FEMALE';
        libGlobal.playerChar.isHim = nil;
    }
}

ForForest : OutdoorRoom
{
    name = 'Lost on a forest'
    
    north = ForForestRandomEncounterConnector
    south = ForForestRandomEncounterConnector
    west = ForForestRandomEncounterConnector
    east = ForForestRandomEncounterConnector
    northwest = ForForestRandomEncounterConnector
    southwest = ForForestRandomEncounterConnector
    northeast = ForForestRandomEncounterConnector
    southeast = ForForestRandomEncounterConnector
}

ForForestRandomEncounterConnector : PathPassage
{
    destination = ForForest
    isCircularPassage = true
    dobjFor(TravelVia)
    {
        action()
        {
            
            local choiceArray = [];
            forEachInstance(ForForestTravelHook, {x: choiceArray += [[x.name,x]]});
            return ChooseRandomChoice(choiceArray);
        }
    }
}

ForForestTravelHook : Hook {}
