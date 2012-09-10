//
//  YMKRouteOverlayView.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>
#import "YMKMapView.h"

@interface YMKYDFManager : NSObject <YMKMapViewDelegate>{
	NSMutableArray* ydfArray;
	NSMutableArray* orverlayArray;
}

- (id) initWithUrlString:(NSString*)urlString;
- (id) initWithXmlString:(NSString*)xmlString;
- (id) initWithJsonString:(NSString*)jsonString;
- (void) showWithMapView:(YMKMapView*)mapView;
- (void) removeWithMapView:(YMKMapView*)mapView;

@end


