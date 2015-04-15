//
//  NewsListViewController.m
//  week6lab
//
//  Created by BigBadEgg on 4/14/15.
//  Copyright (c) 2015 Xiaoduo. All rights reserved.
//

#import "NewsListViewController.h"

@interface NewsListViewController ()

@end

@implementation NewsListViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.newsList = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self downloadNews];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.newsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell" forIndexPath:indexPath];
    Article* a = [self.newsList objectAtIndex:indexPath.row];
    cell.titleLabel.text = a.title;
    cell.descriptionTextView.text = a.descriptions;
    if(![[a.imageUrl absoluteString] isEqualToString:@"(null)"])
    {
        NSLog(@"%@",a.imageUrl);
        cell.thumbernailImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[a.imageUrl absoluteString]]]];
    }else{
        NSLog(@"use empty box image");
        UIImage * image = [UIImage imageNamed:@"emptybox.gif"];
        cell.thumbernailImage.image = image;
    }
    // Configure the cell...
    
    return cell;
}

-(void)downloadNews
{
    
    UIAlertView *loadingAlert;

    loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading news\nPlease Wait..."
                                        message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [loadingAlert setValue:indicator forKey:@"accessoryView"];
    [loadingAlert show];
    
    NSURL* url = [NSURL URLWithString:@"http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://www.abc.net.au/news/feed/51120/rss.xml&"];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(error == nil)
         {
             [self parseNewsJSON:data];
             [self.tableView reloadData];
             [loadingAlert dismissWithClickedButtonIndex:0 animated:TRUE];
         }
         else
         {
             [loadingAlert dismissWithClickedButtonIndex:0 animated:TRUE];
             UIAlertView *noConnectionAlert = [[UIAlertView alloc] initWithTitle:@"Connection Error!"
                                                                message:@"Cannot dowlnoad news from ABC, please check your Internet connection!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
             noConnectionAlert.tag = 100;
             [noConnectionAlert show];
             NSLog(@"Connection Error:\n%@", error.userInfo);
         } }];
    
}

-(void)parseNewsJSON:(NSData*)data
{
    NSError* error;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(result == nil) {
        NSLog(@"Error parsing JSON:\n%@", error.userInfo);
        return;
    }
    if([result isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"Found news!");
        NSDictionary *responseData = [result objectForKey:@"responseData"];
        NSDictionary *feed = [responseData objectForKey:@"feed"];
        NSArray *entries = [feed objectForKey:@"entries"];
        for(NSDictionary * news in entries)
        {
            NSDictionary *jsontitle = [news objectForKey:@"title"];
            NSDictionary *jsondescriptions = [news objectForKey:@"content"];
            NSDictionary *jsonuimageurl = [[[[[[[news objectForKey:@"mediaGroups"] objectAtIndex:0] objectForKey:@"contents"] objectAtIndex:0] objectForKey:@"thumbnails"] objectAtIndex:0]objectForKey:@"url"];
            NSDictionary *jsonlink = [news objectForKey:@"link"];
            Article* article = [[Article alloc]init];
            article.title = [[NSString alloc] initWithFormat:@"%@",jsontitle];
            article.descriptions  = [[[[NSString alloc] initWithFormat:@"%@",jsondescriptions] stringByReplacingOccurrencesOfString:@"<p>" withString:@""] stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            
            article.imageUrl = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@",jsonuimageurl]];
            article.articleLink =[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@",jsonlink]];
            [self.newsList addObject:article];
//            NSLog(@"length: %d",[self.newsList count]);
//            NSLog(@"%@",jsontitle);
//            NSLog(@"%@",jsondescriptions);
//            NSLog(@"%@",jsonuimageurl);

        }
    }else if ([result isKindOfClass:[NSArray class]]){
        
        //        NSArray *nsArray = (NSArray *)result;
        NSLog(@"Dersialized JSON Array");
        
    }
    else
    {
        NSLog(@"Unexpected JSON format");
        return;
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 100) {
        [self downloadNews];
    }
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString:@"ReadNews"])
     {
         WebViewController* controller = segue.destinationViewController;
         NSURL* url;
         Article* a = (Article *)[self.newsList objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
         url = a.articleLink;
         controller.newsLink = url;
     }
 }


@end
