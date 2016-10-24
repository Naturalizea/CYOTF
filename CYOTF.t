#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

versionInfo: GameID
{
    IFID = 'bdaaea0f-1635-4727-a46e-861b20437474'
    name = 'Choose Your Own Transformation'
    byline = 'by Naturalizea'
    htmlByline = 'by <a href="mailto:Naturalizea@gmail.com">
                  Naturalizea</a>'
    version = '1'
    authorEmail = 'Naturalizea <Naturalizea@gmail.com>'
    desc = 'Open-source, interactive choose your own adventure type game, focusing on transformation.'
    htmlDesc = 'Open-source, interactive choose your own adventure type game, focusing on transformation.'
    
    showAbout()
    {
        local choiceArray = [
            ['About this game', MAboutHook],
            ['About my current chapter',MCurrentHook],
            ['Continue playing',TrueHook]
        ];
        
        
        PresentChoice(choiceArray);
    }
}

MAboutHook : Hook
{
    event()
    {
        "Choose Your Own Transformation is a experimental project at making an open-source, extendible interactive fiction game, with a focus on transformations.";
        inputManager.pauseForMore(true);
        "<br><br>";
        versionInfo.showAbout();
    }
}

MCurrentHook : Hook
{
    event()
    {
        if (ContributionBanner.currentContributionItem != nil)
        {
            "Currently in <q><<ContributionBanner.currentContributionItem.ChapterName>></q> by <<ContributionBanner.currentContributionItem.Author>>. 
            Created on <<ContributionBanner.currentContributionItem.Date>>.";
            "<br><br>";
            "<<ContributionBanner.currentContributionItem.Description>>";
        }
        else
        {
            "Currently not in a chapter.";
        }
        inputManager.pauseForMore(true);
        "<br><br>";
        
        versionInfo.showAbout();
    }
}


gameMain: GameMainDef
{
    initialPlayerChar = Player
    
    showIntro()
    {
        randomize();
        
        "Enable debug mode (enable choices when random)? ";
        choiceBanner.debugmode = PresentChoice([['Yes',TrueHook],['No',FalseHook]]);
        "<br><br>";
        "Choose your story : ";
        local choiceArray = [];
        forEachInstance(IntroHook, {x: choiceArray += [[x.name,x]]});
        choiceArray += [['Random',RandomIntroHook]];

        return PresentChoice(choiceArray);
    }
    
    ChangePlayerInto(newPlayer)
    {
        newPlayer.name = libGlobal.playerChar.name;
        newPlayer.isHim = libGlobal.playerChar.isHim;
        newPlayer.isHer = libGlobal.playerChar.isHer;
        foreach (local item in libGlobal.playerChar.contents)
        {
           item.moveInto(newPlayer);
           if (item.isWornBy(libGlobal.playerChar))
           {
               item.makeWornBy(newPlayer);
           }
        }
        
        newPlayer.moveIntoForTravel(libGlobal.playerChar.location);
        libGlobal.playerChar.moveIntoForTravel(nil);
        setPlayer(newPlayer);
    }
    
}

Player: Actor { 
    Tags = []

}

class IntroHook : Hook {}

RandomIntroHook : Hook
{
    event()
    {
        local choiceArray = [];
        forEachInstance(IntroHook, {x: choiceArray += [[x.name,x]]});   
        
        ChooseRandomChoice(choiceArray);
    }
}