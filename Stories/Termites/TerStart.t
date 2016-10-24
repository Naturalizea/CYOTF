#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

TerStartContrib : ContributionItem
{
    ChapterName = 'The termite nest'
    Author = 'Naturalizea'
    Date = '2016/10/24'
    Description = 'Player finds a giant termite mound.'
}

TerStartHook : ForForestTravelHook
{
    name = 'The termite nest'
    event()
    {
        "After wondering around the large forest for a while, you come across a giant, rocky mound, mostly made of hardened dirt, reaching just above the treeline. There is a 
        large cave-like entrance into the structure, should you wish to enter.";
    
        TermiteMound.moveInto(ForForest);
        ContributionBanner.Update(TerStartContrib);
    }
}


TermiteMound : Fixture, PathPassage
{
    name = 'mound'
    vocabWords = 'termite mound/cave/entrance'
    desc()
    {
        "This tall mound is what it looks like. Tall, made of mostly hardened dirt. There is an entrance large enough for you to enter.";
    }
    specialDesc()
    {
        "A rather large, mound of mostly hardened dirt is here. It is large enough, that there is an entrance which you could walk in to get inside
        should you so desire.";
    }

    destination = TerEntrance;
}

class TerRoom : Room
{
    X = 0
    Y = 0
    Z = 0
}

TerEntrance : TerRoom
{    
    name = 'Cave entrance'
    desc()
    {
        "You are standing within the entrance to a large network of caves.";
    }
    
    hasBuilt = nil
    
    enteringRoom (traveller)
    {
        if (!hasBuilt)
        {
            TerMoundManager.BuildTermiteMound();
            hasBuilt = true;
        }
        inherited(traveller);
    }
}

TerQueenChamber : Room
{
    name = 'Large open chamber'
    desc()
    {
        "You find yourself in a large, open chamber within this cave. You have a feeling that in the past, this room used to be full of life. What it's purpose
        used to be, however, is not very clear.";
    }    
}


//mound manager
TerMoundManager : object
{
    map = nil
    Size = 3
    baseYOffset = 0
    
    BuildTermiteMound()
    {
        map = new LookupTable();
        
        //create the entrance tunnel in the south. Lets put the chords on 0,-3,0
        
        local X = 0;
        local Y = -3;
        local Z = 0;
        
        TerEntrance.Z = Z;
        TerEntrance.Y = Y;
        TerEntrance.X = X;        
        local key = '' + Z + ',' + Y + ',' + X;
        map[key] = TerEntrance;
        
        //build our tunnel 3 in
        local prevRoom = nil;
        
        for (local i=1; i<=3; i++)
        {
            prevRoom = map[key];
            Y += 1;
            local tunnel = DigTunnel(prevRoom,[Z,Y,X]);
            key = '' + Z + ',' + Y + ',' + X;
            map[key] = tunnel;            
        }
        
        //one up
        prevRoom = map[key];
        Z += 1;
        local tunnel = DigTunnel(prevRoom,[Z,Y,X]);
        key = '' + Z + ',' + Y + ',' + X;
        map[key] = tunnel;
        
        //and then the centre of the mound. The queens chamber
        Z += 1;
        TerQueenChamber.Z = Z;
        TerQueenChamber.Y = Y;
        TerQueenChamber.X = X;
        
        key = '' + Z + ',' + Y + ',' + X;
        
        ConnectRooms(tunnel, TerQueenChamber);
        ConnectRooms(TerQueenChamber, tunnel);
        map[key] = TerQueenChamber;
        
    }
    
    DigTunnel(source, newPos)
    {        
        local tunnel = new TerMoundTunnel();
        tunnel.Z = newPos[1];
        tunnel.Y = newPos[2];
        tunnel.X = newPos[3];
        
        ConnectRooms(source, tunnel);
        ConnectRooms(tunnel, source);
        
        return tunnel;  
    }
    
    ConnectRooms(room1,room2)
    {
        //determine where we are in relation to eachother
        local x = room2.X - room1.X;
        local y = room2.Y - room1.Y;
        local z = room2.Z - room1.Z;
        
        //create the link (one way)
        if (z == 1) //up
        {
            room1.up = room2;
            //room2.down = room1;
        }
        else if (z == -1) //down
        {
            room1.down = room2;
            //room2.up = room1;        
        }
        else
        {
            if (y == -1) //south
            {
                if (x == 1) //east
                {
                    room1.southeast = room2;
                    //room2.southwest = room1;
                }
                else if (x == -1) //west
                {
                    room1.southwest = room2;
                    //room2.southeast = room1;
                }
                else
                {
                    room1.south = room2;
                    //room2.south = room1;
                }
            }
            else if (y == 1) // north
            {
                if (x == 1) //east
                {
                    room1.northeast = room2;
                    //room2.northeast = room1;
                }
                else if (x == -1) //west
                {
                    room1.northwest = room2;  
                    //room2.northwest = room1;
                }
                else
                {
                    room1.north = room2;
                    //room2.north = room1;
                }
            }
            else if (x == 1) //east
            {
                room1.east = room2;
                //room2.west = room1;
            }
            else //west
            {
                room1.west = room2;
                //room2.east = room1;            
            }
            
        }
        //should be done!
    }
}


class TerMoundTunnel : Room
{
    name = 'Tunnel'
    desc()
    {
        "You are in a tunnel.";
    }
}