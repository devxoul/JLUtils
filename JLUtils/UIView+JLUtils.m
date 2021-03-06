//
//  UIView+JLAnimations.m
//  Dish by.me
//
//  Created by 전수열 on 13. 4. 25..
//  Copyright (c) 2013년 Joyfl. All rights reserved.
//

#import "UIView+JLUtils.h"

@implementation UIView (JLUtils)

- (CGPoint)position
{
	return self.frame.origin;
}

- (void)setPosition:(CGPoint)position
{
	CGRect frame = self.frame;
	frame.origin = position;
	self.frame = frame;
}

- (CGFloat)rightBound
{
	return self.position.x + self.bounds.size.width;
}

- (CGFloat)bottomBound
{
	return self.position.y + self.bounds.size.height;
}

- (void)shakeCount:(NSInteger)count radius:(CGFloat)radius duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void(^)(void))completion
{
	[UIView animateWithDuration:duration animations:^{
		self.transform = CGAffineTransformMakeTranslation( -radius, 0 );
		
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:duration animations:^{
			self.transform = CGAffineTransformMakeTranslation( radius, 0 );
			
		} completion:^(BOOL finished) {
			if( count > 1 )
			{
				[self shakeCount:count - 1 radius:radius duration:duration delay:0 completion:completion];
			}
			else
			{
				[UIView animateWithDuration:duration * 0.5 animations:^{
					self.transform = CGAffineTransformMakeTranslation( 0, 0 );
					
				} completion:^(BOOL finished) {
					self.transform = CGAffineTransformIdentity;
					if( completion )
					{
						completion();
					}
				}];
			}
		}];
	}];
}

- (UIImage *)screenshot
{
	if( UIGraphicsBeginImageContextWithOptions != NULL ) {
		UIGraphicsBeginImageContextWithOptions( self.frame.size, NO, 0.0 );
	} else {
		UIGraphicsBeginImageContext( self.frame.size );
	}
	
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return screenshot;
}


- (UIView *)firstResponder
{
    if( [self isFirstResponder] ) {
        return self;
	}
	
    for( UIView *subview in self.subviews ) {
        UIView * firstResponder = [subview firstResponder];
		if( firstResponder ) {
			return firstResponder;
		}
    }
	
    return nil;
}

@end
