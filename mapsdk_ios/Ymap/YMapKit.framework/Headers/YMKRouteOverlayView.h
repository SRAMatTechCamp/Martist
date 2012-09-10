//
//  YMKRouteOverlayView.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>
#import "YMKOverlayView.h"
#import "YMKAnnotationView.h"

@class YMKRouteOverlay;

@interface YMKRouteOverlayView : YMKOverlayView {
	NSArray *items;
	YMKAnnotationView* _startPinView;
	YMKAnnotationView* _goalPinView;	
	BOOL _startPinVisible;
	BOOL _goalPinVisible;
	BOOL _routePinVisible;	
}

@property (nonatomic, readonly) YMKRouteOverlay* routeOverlay;
@property(nonatomic) BOOL startPinVisible;
@property(nonatomic) BOOL goalPinVisible;
@property(nonatomic) BOOL routePinVisible;

- (id)initWithRouteOverlay:(YMKRouteOverlay*)overlay;

@end
