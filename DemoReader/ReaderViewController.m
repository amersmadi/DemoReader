//
//  ReaderViewController.m
//  DemoReader
//
//  Created by Amer Smadi on 3/11/15.
//  Copyright (c) 2015 Amer Smadi. All rights reserved.
//

#import "ReaderViewController.h"
#import "HtmlParsing.h"
#import "ReaderPageView.h"

@interface ReaderViewController ()

@end

@implementation ReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allChapters = [[NSMutableString alloc] init];
    self.containerContent = [[NSMutableArray alloc] init];
    
    self.pageView = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageView.view.frame = CGRectMake(0, 0, 320, 568);
    self.pageView.dataSource = self;
    
    [self readAndParseFiles];
    [self generateTextContainers];
}

- (void) readAndParseFiles {
    NSString* path;
    NSString* content;
    
    for (int i = 0; i < 4; i++) {
        path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"chapter_%d", i+1] ofType:@"html"];
        content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
        [self.allChapters appendString:content];
    }
    
    HtmlParsing *parse = [[HtmlParsing alloc] init];
    self.book = [parse parseString:self.allChapters];
    self.pagesNumber = [self numberOfpages:self.book];
    NSLog(@"self.pagesNumber: %d", self.pagesNumber);
}

- (CGFloat) numberOfpages: (NSMutableAttributedString *)attr {
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 280, CGFLOAT_MAX)];
    textView.attributedText = attr;
    [textView sizeToFit];
    
    int pages = textView.frame.size.height / 548;
    
    return pages;
}

- (void) generateTextContainers{
    
    NSLayoutManager *layout = [[NSLayoutManager alloc] init];
    NSTextStorage *storage = [[NSTextStorage alloc] initWithAttributedString:self.book];
    [storage addLayoutManager:layout];
//    for (int i = 0; i < self.pagesNumber; i++) {
    for (int i = 0; i < 75; i++) {
        NSLog(@"i: %d", i);
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(280, 548)];
        [layout addTextContainer:textContainer];
        NSAttributedString *attr = [self.book attributedSubstringFromRange:[layout glyphRangeForTextContainer:textContainer]];
        [self.containerContent addObject:attr];
    }
    
    NSArray *initView = @[[self viewControllerAtIndex:0]];
    [self.pageView setViewControllers:initView direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageView];
    [self.view insertSubview:self.pageView.view atIndex:0];
    [self.pageView didMoveToParentViewController:self];
}

- (ReaderPageView *) viewControllerAtIndex: (int) index {
    ReaderPageView *page = [[ReaderPageView alloc] initWithNibName:@"ReaderPageView" bundle:nil];
    page.index = index;
    page.attr = (NSMutableAttributedString *) [self.containerContent objectAtIndex:index];
    
    return page;
}

- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    int index = ((ReaderPageView *) viewController).index;
    
    index++;
    if (index == self.pagesNumber) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    int index = ((ReaderPageView *) viewController).index;
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
