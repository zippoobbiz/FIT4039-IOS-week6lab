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
    cell.descriptionTextView = a.descriptions;
    if(a.imageUrl)
    {
        NSLog(@"%@",a.imageUrl);
        cell.thumbernailImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[a.imageUrl absoluteString]]]];
    }
    // Configure the cell...
    
    return cell;
}

-(void)downloadNews
{
    NSURL* url = [NSURL URLWithString:@"http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://www.abc.net.au/news/feed/51120/rss.xml&"];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(error == nil)
         {
             [self parseNewsJSON:data];
             [self.tableView reloadData];
         }
         else
         {
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
            Article* article = [[Article alloc]init];
            article.title = jsontitle;
            article.descriptions  =jsondescriptions;
            article.imageUrl = [NSURL URLWithString:jsonuimageurl];
            
            
            
            [self.newsList addObject:article];
            NSLog(@"length: %d",[self.newsList count]);
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
