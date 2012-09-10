//
//  SubmapView.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <UIKit/UIKit.h>
#import <YMapKit/YMapKit.h>
#import "NavigationMgr.h"
#import "GpsAnnotation.h"

@interface SubmapView : YMKMapView {
	NavigationMgr* nm;

	YMKPolyline* route;
	GpsAnnotation* gpsAnnotation;
	
	UIImageView* gpsIcon;
}
@property (nonatomic, retain) NavigationMgr* nm;
- (void) updateLocation;
- (void) makeRoute:(CLLocationCoordinate2D*)coords Count:(int)count;

@end
