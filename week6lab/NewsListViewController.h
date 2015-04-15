//
//  NewsListViewController.h
//  week6lab
//
//  Created by BigBadEgg on 4/14/15.
//  Copyright (c) 2015 Xiaoduo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleCell.h"
#import "Article.h"
#import "WebViewController.h"

@interface NewsListViewController : UITableViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray* newsList;
-(void)downloadNews;
@end
