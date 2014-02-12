//
//  UILabel+JLUtils.m
//  Hippo
//
//  Created by 전수열 on 13. 9. 11..
//  Copyright (c) 2013년 Joyfl. All rights reserved.
//

#import "UILabel+JLUtils.h"
#import <objc/runtime.h>

@implementation UILabel (JLUtils)

- (id)initWithPosition:(CGPoint)position maxWidth:(CGFloat)maxWidth
{
	return self = [self initWithFrame:CGRectMake(position.x, position.y, self.maxWidth = maxWidth, 0)];
}

- (void)sizeToFit
{
    if( !self.maxWidth ) {
        [super sizeToFit];
    } else {
        CGSize size = [self sizeThatFits:CGSizeMake(self.maxWidth, 0)];
        if( size.width > self.maxWidth ) {
            size.width = self.maxWidth;
        }
        CGRect frame = self.frame;
        frame.size = size;
        self.frame = frame;
    }
}

- (CGFloat)maxWidth
{
	return [objc_getAssociatedObject( self, @"maxWidth" ) floatValue];
}

- (void)setMaxWidth:(CGFloat)maxWidth
{
	objc_setAssociatedObject( self, @"maxWidth", [NSNumber numberWithFloat:maxWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

@end
