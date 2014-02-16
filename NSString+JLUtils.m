//
//  NSString+JLUtils.m
//  MyFoodList
//
//  Created by 전수열 on 2014. 2. 16..
//  Copyright (c) 2014년 MyFoodList. All rights reserved.
//

#import "NSString+JLUtils.h"

@implementation NSString (JLUtils)

- (BOOL)contains:(NSString *)aString
{
    return [self rangeOfString:aString].location != NSNotFound;
}

@end
