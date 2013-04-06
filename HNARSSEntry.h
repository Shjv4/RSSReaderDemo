//
//  HNARSSEntry.h
//  RSSReaderDemo
//
//  Created by Ngo Anh Hoang on 4/6/13.
//  Copyright (c) 2013 HoangNA. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface HNARSSEntry : NSObject {
    // declare variables
    NSString *_blogTitle;
    NSString *_articleTitle;
    NSString *_articleUrl;
    NSDate *_articleDate;
}

@property (copy) NSString *blogTitle;
@property (copy) NSString *articleTitle;
@property (copy) NSString *articleUrl;
@property (copy) NSDate *articleDate;

- (id)initWithBlogTitle:(NSString*)blogTitle
           articleTitle:(NSString*)articleTitle
             articleUrl:(NSString*)articleUrl
            articleDate:(NSDate*) articleDate;
@end
