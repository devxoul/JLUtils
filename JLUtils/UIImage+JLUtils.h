//
//  UIImage+JLUtils.h
//  Hippo
//
//  Created by 전수열 on 13. 9. 15..
//  Copyright (c) 2013년 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JLUtils)

@property (nonatomic, readonly) UIImage *grayScaleImage;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)cropToRect:(CGRect)rect;
- (UIImage *)cropToSquare;

- (UIImage *)scaleAndRotateToResolution:(NSInteger)resolution;

@end
