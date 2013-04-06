//
//  HNAMasterViewController.h
//  RSSReaderDemo
//
//  Created by Ngo Anh Hoang on 4/6/13.
//  Copyright (c) 2013 HoangNA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNADetailViewController;

@interface HNAMasterViewController : UITableViewController {
    // declare variables
    NSMutableArray *_allEntries;
    NSOperationQueue *_queue;
    NSArray *_feeds;
}
@property (retain) NSMutableArray *allEntries;
@property (retain) NSOperationQueue *queue;
@property (retain) NSArray *feeds;
@property (strong, nonatomic) HNADetailViewController *detailViewController;

@end
