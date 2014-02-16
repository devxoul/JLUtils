//
//  JLUtils.h
//  Hippo
//
//  Created by 전수열 on 13. 9. 15..
//  Copyright (c) 2013년 Joyfl. All rights reserved.
//

#import "UIImage+JLUtils.h"
#import "UIButton+JLUtils.h"
#import "UIColor+JLUtils.h"
#import "UIImage+JLUtils.h"
#import "UILabel+JLUtils.h"
#import "UIView+JLUtils.h"
#import "NSDictionary+JLUtils.h"
#import "NSDate+JLUtils.h"
#import "NSURLComponents+JLUtils.h"
#import "UIFont+JLUtils.h"
#import "NSString+JLUtils.h"
#import "MKMapView+JLUtils.h"

#define VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define LANGUAGE [[NSLocale preferredLanguages] objectAtIndex:0]

#define UIScreenWidth	[UIScreen mainScreen].bounds.size.width
#define UIScreenHeight	[UIScreen mainScreen].bounds.size.height

#define IPHONE5	(BOOL)( UIScreenHeight == 568.0 )

#define L(key) NSLocalizedString(key, nil)


@interface JLUtils : NSObject

+ (void)traceSubviews:(UIView *)view;

/**
 * https://gist.github.com/snikch/3661188
 */
+ (UIViewController *)topViewController;

@end