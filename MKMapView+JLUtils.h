//
//  MKMapView+JLUtils.h
//  MyFoodList
//
//  Created by 전수열 on 2014. 2. 17..
//  Copyright (c) 2014년 MyFoodList. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (JLUtils)

- (void)setRegionToVisibleAllAnnotations;
- (void)setRegionToVisibleAllAnnotationsWithScale:(CGFloat)scale;

@end
