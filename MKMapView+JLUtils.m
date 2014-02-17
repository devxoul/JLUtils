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
    if (!annotations.count || (annotations.count == 1 && annotations[0] == self.userLocation)) {
        return;
    }

    CLLocationDegrees minLatitude, minLongitude, maxLatitude, maxLongitude;

    // set default value
    for (id<MKAnnotation> annotation in annotations) {
        if (annotation == self.userLocation) {
            continue;
        }
        minLatitude = annotation.coordinate.latitude;
        minLongitude = annotation.coordinate.longitude;
        maxLatitude = minLatitude;
        maxLongitude = minLongitude;
        break;
    }

    for (id<MKAnnotation> annotation in annotations) {
        if (annotation == self.userLocation) {
            continue;
        }
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
