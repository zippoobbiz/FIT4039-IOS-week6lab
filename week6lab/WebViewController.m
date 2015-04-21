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
    _loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading news\nPlease Wait..."
                                               message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [_loadingAlert setValue:indicator forKey:@"accessoryView"];
    _webView.delegate = self;
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

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Did fail load with error: %@", [error description]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"Check your Internet connection before refreshing." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
 
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    if(_loadingAlert.isVisible == NO)
    {
        [_loadingAlert show];
    }
    
    
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSLog(@"Loading: %@", [request URL]);
//    return YES;
//}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"didFinish: %@; stillLoading: %@", [[webView request]URL],
          (webView.loading?@"YES":@"NO"));
    if(webView.loading)
    {
    
    }else{
        [_loadingAlert dismissWithClickedButtonIndex:0 animated:TRUE];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [_loadingAlert dismissWithClickedButtonIndex:0 animated:TRUE];
    [self.navigationController popViewControllerAnimated:YES];
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
