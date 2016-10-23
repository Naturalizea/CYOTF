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
}


gameMain: GameMainDef
{
    initialPlayerChar = me
}


startRoom: Room 
{
    name = 'Start Room'
    desc = "This is the starting room. "
}

+ me: Actor;