//
//  YMKRouteOverlay.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>
#import "YMKGeometry.h"
#import "YMKOverlay.h"

#define TRAFFIC_CAR 0
#define TRAFFIC_WALK 1
 
@protocol YMKRouteNodeInfo;
@protocol YMKRouteOverlayDelegate;

@interface YMKRouteOverlay : NSObject <YMKOverlay> {
	NSString* _startTitle;
	NSString* _goalTitle;
	id routeData;
	id routeSearch;
	id <YMKRouteOverlayDelegate> delegate;
}		

@property CGFloat distance;
@property CGFloat time;
@property (nonatomic, readonly) NSUInteger pointCount;
@property (nonatomic, readonly) NSUInteger nodeInfoCount;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) YMKMapRect boundingMapRect;
@property (nonatomic, assign) id <YMKRouteOverlayDelegate> delegate;

+(YMKRouteOverlay*)routeWithYdfXmlString:(NSString*)ydf;
+(YMKRouteOverlay*)routeWithYdfJsonString:(NSString*)ydf;
+(YMKRouteOverlay*)routeWithYdfJsonString:(NSString*)ydf StartPos:(CLLocationCoordinate2D)sp withGoalPos:(CLLocationCoordinate2D)gp;

-(id)initWithAppid:(NSString *)appid;
-(void)setRouteStartPos:(CLLocationCoordinate2D)sp withGoalPos:(CLLocationCoordinate2D)gp withTraffic:(int)traffic;
-(BOOL)search;
-(id <YMKRouteNodeInfo>)getRouteNodeInfoWithIndex:(int)index;
-(BOOL)intersectsMapRect:(YMKMapRect)mapRect;
-(CLLocationCoordinate2D*)points;
-(id) getData;
-(void)setStartTitle:(NSString*)title;
-(void)setGoalTitle:(NSString*)title;
-(NSString*)getStartTitle;
-(NSString*)getGoalTitle;
@end

@protocol YMKRouteOverlayDelegate <NSObject>
@optional
-(void)finishRouteSearch:(YMKRouteOverlay*)routeOverlay;
-(void)errorRouteSearch:(YMKRouteOverlay*)routeOverlay withError:(int)error;
@end