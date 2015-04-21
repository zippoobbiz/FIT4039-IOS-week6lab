//
//  WebViewController.h
//  week6lab
//
//  Created by BigBadEgg on 4/15/15.
//  Copyright (c) 2015 Xiaoduo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) NSURL * newsLink;
@property (strong,nonatomic) UIAlertView *loadingAlert;
-(id)initWithLink:(NSURL*) newsLink;

@end
