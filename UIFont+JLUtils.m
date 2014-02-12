//
//  UIFont+JLUtils.m
//  MyFoodList
//
//  Created by 전수열 on 2014. 2. 12..
//  Copyright (c) 2014년 MyFoodList. All rights reserved.
//

#import "UIFont+JLUtils.h"

@implementation UIFont (JLUtils)

+ (UIFont *)mediumSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize];
}

+ (UIFont *)lightSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
}

+ (UIFont *)ultraLightSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:fontSize];
}

@end
