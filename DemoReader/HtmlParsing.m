//
//  HtmlParsing.m
//  YaqutSwift
//
//  Created by Amer Smadi on 2/8/15.
//  Copyright (c) 2015 Kindi. All rights reserved.
//

#import "HtmlParsing.h"

NSString static *const imgRegex = @"(<img src=\"[A-Z+a-z])\\w+";
NSString static *const h1WithStyleRegex = @"(?:<h1 style=\")(?:[^\\>]*)\">";
NSString static *const h2WithStyleRegex = @"(?:<h2 style=\")(?:[^\\>]*)\">";
NSString static *const h3WithStyleRegex = @"(?:<h3 style=\")(?:[^\\>]*)\">";
NSString static *const h1Regex = @"<h1>[^<>]*</h1>";
NSString static *const h2Regex = @"<h2>[^<>]*</h2>";
NSString static *const h3Regex = @"<h3>[^<>]*</h3>";
NSString static *const spanRegex = @"(?:<span style=\")(?:[^\\>]*)\">";
NSString static *const brRegex = @"<br>";
NSString static *const fontRegex = @"</font>";
//NSString static *const paragraphWithStyleRegex = @"(?:<p style=\")(?:[^\\>]*)\">";
//NSString static *const paragraphRegex = @"<p>[^<>]*</p>";
NSString static *const cleanRegex = @"<(?!(?:p|img)|/p>)[^>]*>";

@interface HtmlParsing ()

@property NSMutableArray *pStrings;
@property NSMutableArray *h1Strings;
@property NSMutableArray *h2Strings;
@property NSMutableArray *h3Strings;

@end

@implementation HtmlParsing

- (id) init {
    self = [super init];
    if (self) {
        self.pStrings = [[NSMutableArray alloc] init];
        self.h1Strings = [[NSMutableArray alloc] init];
        self.h2Strings = [[NSMutableArray alloc] init];
        self.h3Strings = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSMutableAttributedString *) parseString: (NSString *) htmlString {
    
    TSMarkdownParser *parser = [TSMarkdownParser new];
    NSError *error;
    
    NSRegularExpression *h1WithStyleParsing = [NSRegularExpression regularExpressionWithPattern:h1WithStyleRegex options:NSRegularExpressionCaseInsensitive error:&error];
    [parser addParsingRuleWithRegularExpression:h1WithStyleParsing withBlock:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString) {
        
        [attributedString replaceCharactersInRange:NSMakeRange(match.range.location, match.range.length) withString:@"<h1>"];
        
    }];

    NSRegularExpression *h2WithStyleParsing = [NSRegularExpression regularExpressionWithPattern:h2WithStyleRegex options:NSRegularExpressionCaseInsensitive error:&error];
    [parser addParsingRuleWithRegularExpression:h2WithStyleParsing withBlock:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString) {
        
        [attributedString replaceCharactersInRange:NSMakeRange(match.range.location, match.range.length) withString:@"<h2>"];
        
    }];

    NSRegularExpression *h3WithStyleParsing = [NSRegularExpression regularExpressionWithPattern:h3WithStyleRegex options:NSRegularExpressionCaseInsensitive error:&error];
    [parser addParsingRuleWithRegularExpression:h3WithStyleParsing withBlock:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString) {
        
        [attributedString replaceCharactersInRange:NSMakeRange(match.range.location, match.range.length) withString:@"<h3>"];
        
    }];

    
    NSRegularExpression *h1Parsing = [NSRegularExpression regularExpressionWithPattern:h1Regex options:NSRegularExpressionCaseInsensitive error:&error];
    [parser addParsingRuleWithRegularExpression:h1Parsing withBlock:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString) {
        
        [self.h1Strings addObject:[[attributedString string] substringWithRange:NSMakeRange(match.range.location + 4, match.range.length - 9)]];
        [attributedString deleteCharactersInRange:NSMakeRange(match.range.location, 4)];
        [attributedString deleteCharactersInRange:NSMakeRange(match.range.location + match.range.length - 9, 5)];
        
    }];
    
    NSRegularExpression *h2Parsing = [NSRegularExpression regularExpressionWithPattern:h2Regex options:NSRegularExpressionCaseInsensitive error:&error];
    [parser addParsingRuleWithRegularExpression:h2Parsing withBlock:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString) {
        
        [self.h2Strings addObject:[[attributedString string] substringWithRange:NSMakeRange(match.range.location + 4, match.range.length - 9)]];
        [attributedString deleteCharactersInRange:NSMakeRange(match.range.location, 4)];
        [attributedString deleteCharactersInRange:NSMakeRange(match.range.location + match.range.length - 9, 5)];
        
    }];

    NSRegularExpression *h3Parsing = [NSRegularExpression regularExpressionWithPattern:h3Regex options:NSRegularExpressionCaseInsensitive error:&error];
    [parser addParsingRuleWithRegularExpression:h3Parsing withBlock:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString) {
        
        [self.h3Strings addObject:[[attributedString string] substringWithRange:NSMakeRange(match.range.location + 4, match.range.length - 9)]];
        [attributedString deleteCharactersInRange:NSMakeRange(match.range.location, 4)];
        [attributedString deleteCharactersInRange:NSMakeRange(match.range.location + match.range.length - 9, 5)];
    }];
    
    NSRegularExpression *clean = [NSRegularExpression regularExpressionWithPattern:cleanRegex options:NSRegularExpressionCaseInsensitive error:&error];
    [parser addParsingRuleWithRegularExpression:clean withBlock:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString) {
        
        [attributedString replaceCharactersInRange:NSMakeRange(match.range.location, match.range.length) withString:@" "];
        
    }];

//    NSRegularExpression *paragraphWithStyleParsing = [NSRegularExpression regularExpressionWithPattern:paragraphWithStyleRegex options:NSRegularExpressionCaseInsensitive error:&error];
//    [parser addParsingRuleWithRegularExpression:paragraphWithStyleParsing withBlock:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString) {
//        
//        [attributedString replaceCharactersInRange:NSMakeRange(match.range.location, match.range.length) withString:@"<p>"];
//        
//    }];
//    
//    NSRegularExpression *paragraphParsing = [NSRegularExpression regularExpressionWithPattern:paragraphRegex options:NSRegularExpressionCaseInsensitive error:&error];
//    [parser addParsingRuleWithRegularExpression:paragraphParsing withBlock:^(NSTextCheckingResult *match, NSMutableAttributedString *attributedString) {
//        
//        [self.pStrings addObject:[[attributedString string] substringWithRange:NSMakeRange(match.range.location + 3, match.range.length - 7)]];
//        [attributedString deleteCharactersInRange:NSMakeRange(match.range.location, 3)];
//        [attributedString deleteCharactersInRange:NSMakeRange(match.range.location + match.range.length - 7, 4)];
//        
//    }];
    
    NSAttributedString *attributedFromParser = [parser attributedStringFromMarkdown:htmlString];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[[attributedFromParser string] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
    UIFont *font = [UIFont fontWithName:@"Al Bayan" size: 26];
    NSMutableParagraphStyle *textAlign = [[NSMutableParagraphStyle alloc] init];
    [textAlign setBaseWritingDirection:NSWritingDirectionRightToLeft];
    [textAlign setAlignment:NSTextAlignmentJustified];
    [textAlign setParagraphSpacingBefore:0];
    [textAlign setParagraphSpacing:0];

    [attributedString addAttribute:NSFontAttributeName
                             value:font
                             range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:textAlign
                             range:NSMakeRange(0, attributedString.length)];
    
    if (self.h1Strings.count != 0) {
        for (int i = 0; i < self.h1Strings.count; i++) {
            UIFont *font = [UIFont fontWithName:@"Baghdad" size:30];
            NSMutableParagraphStyle *textAlign = [[NSMutableParagraphStyle alloc] init];
            [textAlign setBaseWritingDirection:NSWritingDirectionRightToLeft];
            [textAlign setAlignment:NSTextAlignmentCenter];
            
            NSString *newString = [self.h1Strings[i] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [attributedString addAttribute:NSFontAttributeName
                                     value:font
                                     range:[[attributedString string] rangeOfString:newString]];
            [attributedString addAttribute:NSParagraphStyleAttributeName
                                     value:textAlign
                                     range:[[attributedString string] rangeOfString:newString]];
            NSAttributedString *cr = [[NSAttributedString alloc] initWithString: @"\n"];
            [attributedString appendAttributedString:cr];
            
        }
    }
    
    if (self.h2Strings.count != 0) {
        for (int i = 0; i < self.h2Strings.count; i++) {
            UIFont *font = [UIFont fontWithName:@"Baghdad" size:28];
            NSMutableParagraphStyle *textAlign = [[NSMutableParagraphStyle alloc] init];
            [textAlign setBaseWritingDirection:NSWritingDirectionRightToLeft];
            [textAlign setAlignment:NSTextAlignmentCenter];
            
            NSString *newString = [self.h2Strings[i] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [attributedString addAttribute:NSFontAttributeName
                                     value:font
                                     range:[[attributedString string] rangeOfString:newString]];
            [attributedString addAttribute:NSParagraphStyleAttributeName
                                     value:textAlign
                                     range:[[attributedString string] rangeOfString:newString]];
        }
    }
    
    if (self.h3Strings.count != 0) {
        for (int i = 0; i < self.h3Strings.count; i++) {
            UIFont *font = [UIFont fontWithName:@"Baghdad" size:26];
            NSMutableParagraphStyle *textAlign = [[NSMutableParagraphStyle alloc] init];
            [textAlign setBaseWritingDirection:NSWritingDirectionRightToLeft];
            [textAlign setAlignment:NSTextAlignmentCenter];
            
            NSString *newString = [self.h3Strings[i] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [attributedString addAttribute:NSFontAttributeName
                                     value:font
                                     range:[[attributedString string] rangeOfString:newString]];
            [attributedString addAttribute:NSParagraphStyleAttributeName
                                     value:textAlign
                                     range:[[attributedString string] rangeOfString:newString]];
        }
    }
    
//    if (self.pStrings.count != 0) {
//        for (int i = 0; i < self.pStrings.count; i++) {
//            UIFont *font = [UIFont fontWithName:@"Al Bayan" size: 26];
//            NSMutableParagraphStyle *textAlign = [[NSMutableParagraphStyle alloc] init];
//            [textAlign setBaseWritingDirection:NSWritingDirectionRightToLeft];
//            [textAlign setAlignment:NSTextAlignmentJustified];
//            [textAlign setParagraphSpacingBefore:0];
//            [textAlign setParagraphSpacing:0];
//
//            NSString *newString = [self.pStrings[i] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            [attributedString addAttribute:NSFontAttributeName
//                                     value:font
//                                     range:[[attributedString string] rangeOfString:newString]];
//            [attributedString addAttribute:NSParagraphStyleAttributeName
//                                     value:textAlign
//                                     range:[[attributedString string] rangeOfString:newString]];
//        }
//    }
    
    return attributedString;
    
}

@end
