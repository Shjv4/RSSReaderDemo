//
//  HNADetailViewController.h
//  RSSReaderDemo
//
//  Created by Ngo Anh Hoang on 4/6/13.
//  Copyright (c) 2013 HoangNA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNADetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
