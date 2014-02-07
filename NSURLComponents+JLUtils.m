//
//  NSURLComponents+JLUtils.m
//  Ment
//
//  Created by 전수열 on 2014. 2. 7..
//  Copyright (c) 2014년 Joyfl. All rights reserved.
//

#import "NSURLComponents+JLUtils.h"

@implementation NSURLComponents (JLUtils)

- (NSDictionary *)queryParameters
{
    NSMutableDictionary *queryParameters = [NSMutableDictionary dictionary];
    NSArray *params = [self.query componentsSeparatedByString:@"&"];
    for( NSString *param in params ) {
        NSArray *keyValue = [param componentsSeparatedByString:@"="];
        [queryParameters setObject:keyValue[1] forKey:keyValue[0]];
    }
    return [NSDictionary dictionaryWithDictionary:queryParameters];
}

- (void)setQueryParameters:(NSDictionary *)queryParameters
{
    NSMutableString *query = [NSMutableString string];
    for( NSString *key in queryParameters ) {
        [query appendString:key];
        [query appendString:@"="];
        [query appendString:queryParameters[key]];
    }
    self.query = [NSString stringWithString:query];
}

@end
