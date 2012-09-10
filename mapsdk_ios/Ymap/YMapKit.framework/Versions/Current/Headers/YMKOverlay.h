//	
//  YMKOverlay.h
//	
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>
#import "YMKGeometry.h"
#import "YMKAnnotation.h"

@protocol YMKOverlay <YMKAnnotation>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) YMKMapRect boundingMapRect;
@optional

- (BOOL)intersectsMapRect:(YMKMapRect)mapRect;

@end
