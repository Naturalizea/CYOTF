#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

class ContributionItem : object
{
    ChapterName = 'Chapter'
    Author = 'Author name'
    Date = '99 Month 9999'
    Description = 'A description goes here'
}

ContributionBanner: CustomBannerWindow 
{
    bannerArgs = [nil, BannerAfter, statuslineBanner, BannerTypeText, BannerAlignTop, 1, BannerSizeAbsolute, BannerStyleBorder]

    isActive = nil;

    Update(ContributionItem)
    {
        if (!isActive)
        {
            activate();
        }
        
        local contents = '<CENTER><B>';        
        contents += ContributionItem.ChapterName;        
        contents += '</B> By ' + ContributionItem.Author + '</CENTER>';
        
        updateContents(contents);
    }
}