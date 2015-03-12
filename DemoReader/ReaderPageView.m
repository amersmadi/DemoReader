//
//  ReaderPageView.m
//  DemoReader
//
//  Created by Amer Smadi on 3/11/15.
//  Copyright (c) 2015 Amer Smadi. All rights reserved.
//

#import "ReaderPageView.h"

@interface ReaderPageView ()

@end

@implementation ReaderPageView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pageTextView setAttributedText:self.attr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
