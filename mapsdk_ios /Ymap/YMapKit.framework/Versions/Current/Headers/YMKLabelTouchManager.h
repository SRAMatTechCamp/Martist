/*
 *  YMKLabelTouchManager.h
 *
 *  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
 *
 */
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>	
#import "YMKMapView.h"

@protocol YMKLabelTouchDelegate;
@class LabelTouchView;
@class LabelTouchOverlay;

@interface YMKLabelTouchManager : NSObject <YMKMapViewDelegate> {
	YMKMapView* _mapView;
	LabelTouchOverlay* _labelTouchOverlay;
	LabelTouchView* _labelTouchView;
	id <YMKLabelTouchDelegate> delegate;
	NSURLConnection *_con;
	NSMutableData* _data;
	int tx;
	int ty;
	double per;
	NSString* labelTouchUrl;
}

@property (nonatomic, assign) id <YMKLabelTouchDelegate> delegate;
- (id) initWithMapView:(YMKMapView*)mapView;
- (void) queryLabel:(CLLocationCoordinate2D)coordinate;
- (void) queryLabelWithPoint:(CGPoint)point;
- (void) remove;
@end