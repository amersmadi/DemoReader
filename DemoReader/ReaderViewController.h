//
//  ReaderViewController.h
//  DemoReader
//
//  Created by Amer Smadi on 3/11/15.
//  Copyright (c) 2015 Amer Smadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReaderViewController : UIViewController <UIPageViewControllerDataSource>

@property UIPageViewController *pageView;

@property NSMutableString *allChapters;

@property NSMutableAttributedString *book;

@property NSMutableArray *containerContent;

@property int pagesNumber;

@end
