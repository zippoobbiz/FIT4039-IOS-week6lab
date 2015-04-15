//
//  WebViewController.m
//  week6lab
//
//  Created by BigBadEgg on 4/15/15.
//  Copyright (c) 2015 Xiaoduo. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",_newsLink);
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:_newsLink];
    [_webView loadRequest:urlRequest];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithLink:(NSURL*) newsLink{
    if(self = [super init])
    {
        self.newsLink = newsLink;
    }
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
