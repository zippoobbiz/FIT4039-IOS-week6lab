//
//  ArticleCell.h
//  week6lab
//
//  Created by BigBadEgg on 4/14/15.
//  Copyright (c) 2015 Xiaoduo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbernailImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;


@end
