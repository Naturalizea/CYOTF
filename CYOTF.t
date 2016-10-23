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
        if (gameMain.currentContributionItem != nil)
        {
            "Currently in <q><<gameMain.currentContributionItem.ChapterName>></q> by <<gameMain.currentContributionItem.Author>>. Created on <<gameMain.currentContributionItem.Date>>.";
            "<br><br>";
            "<<gameMain.currentContributionItem.Description>>";
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
    initialPlayerChar = me
    currentContributionItem = nil
    
}


startRoom: Room 
{
    name = 'Start Room'
    desc = "This is the starting room. "
}

+ me: Actor;