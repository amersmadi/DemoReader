//
//  ReaderPageView.h
//  DemoReader
//
//  Created by Amer Smadi on 3/11/15.
//  Copyright (c) 2015 Amer Smadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReaderPageView : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *pageTextView;

@property int index;

@property NSMutableAttributedString *attr;

@end
