//
//  Article.h
//  week6lab
//
//  Created by BigBadEgg on 4/14/15.
//  Copyright (c) 2015 Xiaoduo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* descriptions;
@property (strong, nonatomic) NSURL* imageUrl;
@property (strong, nonatomic) NSURL* articleLink;


-(id)init;
-(id)initWith:(NSString*)title description:(NSString*) descriptions imageUrl:(NSURL*) imageUrl andArticleLink:(NSURL*)articleLink;
@end
