//
//  YMKMultiPoint.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//

#import <Foundation/Foundation.h>
#import "YMKGeometry.h"
#import "YMKShape.h"

@interface YMKMultiPoint : YMKShape {
@protected
	NSUInteger pointCount;
	YMKMapPoint *_points;
	
	NSUInteger globalPointCount;
	YMKMapPoint *_globalPoints;	
	
	CLLocationCoordinate2D *_coordinates;
	NSUInteger coordsCount;
	NSUInteger zoomlevel;
	float magnify;
}

@property (nonatomic, readonly) NSUInteger pointCount;
@property (nonatomic, readonly) YMKMapPoint *points;
@property (nonatomic, readonly) NSUInteger globalPointCount;
@property (nonatomic, readonly) YMKMapPoint *globalPoints;
@property (nonatomic, readonly) CLLocationCoordinate2D *coordinates;
@property (nonatomic, readonly) NSUInteger coordsCount;
@property (nonatomic) NSUInteger zoomlevel;
@property (nonatomic) float magnify;

- (void)getCoordinates:(CLLocationCoordinate2D *)coords range:(NSRange)range;
- (void)setCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count;
- (void)setPoints:(YMKMapPoint *)points count:(NSUInteger)count;
-  (void)setGlobalPoints:(YMKMapPoint *)points count:(NSUInteger)count;
- (void)addCoordinate:(CLLocationCoordinate2D)coord;
@end
