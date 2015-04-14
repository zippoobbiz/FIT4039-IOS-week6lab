//
//  Article.m
//  week6lab
//
//  Created by BigBadEgg on 4/14/15.
//  Copyright (c) 2015 Xiaoduo. All rights reserved.
//

#import "Article.h"

@implementation Article
-(id)init{
    self = [super init];

    return self;

}
-(id)initWith:(NSString*)title description:(NSString*) descriptions imageUrl:(NSURL*) imageUrl andArticleLink:(NSURL*)articleLink
{
    if(self = [super init])
    {
        self.title = title;
        self.descriptions = descriptions;
        self.imageUrl = imageUrl;
        self.articleLink = articleLink;
    }
    return self;
}

@end
