//
//  UIImage+JLUtils.m
//  Hippo
//
//  Created by 전수열 on 13. 9. 15..
//  Copyright (c) 2013년 Joyfl. All rights reserved.
//

#import "UIImage+JLUtils.h"

@implementation UIImage (JLUtils)

- (UIImage *)grayScaleImage
{
    CGFloat actualWidth = self.size.width;
    CGFloat actualHeight = self.size.height;
	
    CGRect imageRect = CGRectMake(0, 0, actualWidth, actualHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
	
    CGContextRef context = CGBitmapContextCreate(nil, actualWidth, actualHeight, 8, 0, colorSpace, kCGImageAlphaNone);
    CGContextDrawImage(context, imageRect, self.CGImage);
	
    CGImageRef grayImage = CGBitmapContextCreateImage(context);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
	
    context = CGBitmapContextCreate(nil, actualWidth, actualHeight, 8, 0, nil, kCGImageAlphaOnly);
    CGContextDrawImage(context, imageRect, self.CGImage);
    CGImageRef mask = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
	
    UIImage *grayScaleImage = [UIImage imageWithCGImage:CGImageCreateWithMask(grayImage, mask) scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(grayImage);
    CGImageRelease(mask);
	
    return grayScaleImage;
}


+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)cropToRect:(CGRect)rect
{
	CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
	UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return croppedImage;
}

- (UIImage *)cropToSquare
{
	// square image
	if (self.size.width == self.size.height) {
		return self;
	}

    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = self.size.width * scale;
    CGFloat height = self.size.height * scale;

	// landscape image
	if (self.size.width > self.size.height) {
		CGRect rect = CGRectMake((width - height) / 2, 0, height, height);
		return [self cropToRect:rect];
	}

	// portrait image
	else {
		CGRect rect = CGRectMake(0, (height - width) / 2, width, width);
		return [self cropToRect:rect];
	}
}

- (UIImage *)scaleAndRotateToResolution:(NSInteger)resolution
{
	CGImageRef imgRef = self.CGImage;

	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);

	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(0, 0, width, height);

	if (width > resolution || height > resolution) {
		CGFloat ratio = width / height;
		if (ratio > 1) {
			bounds.size.width = resolution;
			bounds.size.height = bounds.size.width / ratio;
		} else {
			bounds.size.height = resolution;
			bounds.size.width = bounds.size.height * ratio;
		}
	}

	CGFloat scaleRatio = bounds.size.width / width;
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
	CGFloat boundHeight;
	UIImageOrientation orient = self.imageOrientation;
	switch(orient) {
		case UIImageOrientationUp: // EXIF = 1
			transform = CGAffineTransformIdentity;
			break;

		case UIImageOrientationUpMirrored: // EXIF = 2
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;

		case UIImageOrientationDown: // EXIF = 3
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;

		case UIImageOrientationDownMirrored: // EXIF = 4
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;

		case UIImageOrientationLeftMirrored: // EXIF = 5
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;

		case UIImageOrientationLeft: // EXIF = 6
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;

		case UIImageOrientationRightMirrored: // EXIF = 7
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;

		case UIImageOrientationRight: // EXIF = 8
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;

		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
	}

	UIGraphicsBeginImageContext(bounds.size);

	CGContextRef context = UIGraphicsGetCurrentContext();

	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -height, 0);
	} else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -height);
	}

	CGContextConcatCTM(context, transform);

	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}

@end
