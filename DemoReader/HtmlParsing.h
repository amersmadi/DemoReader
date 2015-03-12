//
//  HtmlParsing.h
//  YaqutSwift
//
//  Created by Amer Smadi on 2/8/15.
//  Copyright (c) 2015 Kindi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TSMarkdownParser.h"

@interface HtmlParsing : NSObject

- (NSMutableAttributedString *) parseString: (NSString *) htmlString;

@end
