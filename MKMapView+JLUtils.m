//
//  MKMapView+JLUtils.m
//  MyFoodList
//
//  Created by 전수열 on 2014. 2. 17..
//  Copyright (c) 2014년 MyFoodList. All rights reserved.
//

#import "MKMapView+JLUtils.h"

@implementation MKMapView (JLUtils)

- (void)setRegionToVisibleAllAnnotations
{
    [self setRegionToVisibleAllAnnotationsWithScale:1.5];
}

- (void)setRegionToVisibleAllAnnotationsWithScale:(CGFloat)scale
{
    NSArray *annotations = self.annotations;

    CLLocationDegrees minLatitude = [annotations[0] coordinate].latitude;
    CLLocationDegrees minLongitude = [annotations[0] coordinate].longitude;
    CLLocationDegrees maxLatitude = minLatitude;
    CLLocationDegrees maxLongitude = minLongitude;

    for (id<MKAnnotation> annotation in annotations) {
        minLongitude = MIN(minLongitude, annotation.coordinate.longitude);
        minLatitude = MIN(minLatitude, annotation.coordinate.latitude);
        maxLongitude = MAX(maxLongitude, annotation.coordinate.longitude);
        maxLatitude = MAX(maxLatitude, annotation.coordinate.latitude);
    }

    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((maxLatitude + minLatitude) / 2.0,
                                                               (maxLongitude + minLongitude) / 2.0);
    MKCoordinateSpan span = MKCoordinateSpanMake((maxLatitude - minLatitude) * scale,
                                                 (maxLongitude - minLongitude) * scale);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self setRegion:region animated:YES];
}

@end
