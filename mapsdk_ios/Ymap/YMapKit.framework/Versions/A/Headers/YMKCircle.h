//
//  YMKCircle.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>
#import "YMKShape.h"
#import "YMKGeometry.h"
#import "YMKOverlay.h"

@interface YMKCircle : YMKShape <YMKOverlay>{
	CLLocationCoordinate2D _coordinate;
	CLLocationDistance _radius;	
	YMKMapRect _boundingMapRect;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) CLLocationDistance radius;
@property (nonatomic, readonly) YMKMapRect boundingMapRect;

+ (YMKCircle *)circleWithCenterCoordinate:(CLLocationCoordinate2D)coord radius:(CLLocationDistance)radius;
+ (YMKCircle *)circleWithMapRect:(YMKMapRect)mapRect;

@end
