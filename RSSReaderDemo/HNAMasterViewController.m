//
//  HNAMasterViewController.m
//  RSSReaderDemo
//
//  Created by Ngo Anh Hoang on 4/6/13.
//  Copyright (c) 2013 HoangNA. All rights reserved.
//

#import "HNAMasterViewController.h"
#import "HNADetailViewController.h"
#import "HNARSSEntry.h"
#import "ASIHTTPRequest.h"

@interface HNAMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation HNAMasterViewController
@synthesize allEntries = _allEntries;
@synthesize feeds = _feeds;
@synthesize queue = _queue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
    [_objects release];
    // Demo 1st time
    [_allEntries release];
    _allEntries = nil;
    // Demo 2nd time
    [_queue release];
    _queue = nil;
    [_feeds release];
    _feeds = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;
    */
    
    // Demo 1st time
    /*
    self.title = @"Feeds";
    self.allEntries = [NSMutableArray array];
    [self addRows];
     */
    
    // Demo 2nd time
    self.title = @"Feeds";
    self.allEntries = [NSMutableArray array];
    self.queue = [[[NSOperationQueue alloc] init] autorelease];
    self.feeds = [NSArray arrayWithObjects:@"http://kites.vn/rss.html", @"http://kites.vn/forum.php?mod=rss&auth=0", nil];
    [self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _objects.count;
    return [_allEntries count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    /*
    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell; 
    */
    HNARSSEntry *entry = [_allEntries objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *articleDateString = [dateFormatter stringFromDate:entry.articleDate];
    //NSLog(@"%@", articleDateString);
    cell.textLabel.text = entry.articleTitle;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", articleDateString, entry.blogTitle];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[[HNADetailViewController alloc] initWithNibName:@"HNADetailViewController" bundle:nil] autorelease];
    }
    NSDate *object = _objects[indexPath.row];
    self.detailViewController.detailItem = object;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

#pragma mark - Handle view of feeds
// Add some record for demo
- (void)addRows {
    HNARSSEntry *entry1 = [[[HNARSSEntry alloc] initWithBlogTitle:@"Article no 1" articleTitle:@"This is title of article 1" articleUrl:@"1" articleDate:[NSDate date]] autorelease];
    HNARSSEntry *entry2 = [[[HNARSSEntry alloc] initWithBlogTitle:@"Article no 2" articleTitle:@"This is title of article 2" articleUrl:@"2" articleDate:[NSDate date]] autorelease];
    HNARSSEntry *entry3 = [[[HNARSSEntry alloc] initWithBlogTitle:@"Article no 3" articleTitle:@"This is title of article 3" articleUrl:@"3" articleDate:[NSDate date]] autorelease];
    [_allEntries insertObject:entry1 atIndex:0];
    [_allEntries insertObject:entry2 atIndex:0];
    [_allEntries insertObject:entry3 atIndex:0];
}
// Refresh URL
- (void)refresh {
    for (NSString *feed in _feeds) {
        NSURL *url = [NSURL URLWithString:feed];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [_queue addOperation:request];
    }
}
// Do after successfully get a request
- (void)requestFinished:(ASIHTTPRequest *)request {
    HNARSSEntry *entry = [[[HNARSSEntry alloc] initWithBlogTitle:request.url.absoluteString articleTitle:request.url.absoluteString articleUrl:request.url.absoluteString articleDate:[NSDate date]] autorelease];
    int insertIndex = 0;
    [_allEntries insertObject:entry atIndex:insertIndex];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:insertIndex inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
}
// Do after fail to get a request
- (void)requestFailed:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    NSLog(@"Error: %@", error);
}

@end
