//										
//  MapDelegate.h													
//												
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>		
#import <CoreLocation/CoreLocation.h>	
#import "YMKOverlay.h"

@class MapCtrl;
@class YMKAnnotationView;
@class YMKCircle;
@class YMKOverlayView;
@class YMKUserLocation;

@protocol MapDelegate <NSObject>
- (void)layerChanged;
- (void)mapWillMoveAnimated:(BOOL)animated;
- (void)mapMovedAnimated:(BOOL)animated;
- (void)handleTapWithPos: (CGPoint)p;
- (void)handleTapWithData: (id)data;
- (void)layerListChanged;
- (void)didFinishLoadingMap;
- (void)didFailLoadingMapWithError:(NSError *)error;
- (YMKAnnotationView*)mapView:(MapCtrl*)mapView viewForAnnotation:(id <YMKAnnotation>)annotation;
- (YMKOverlayView*)mapView:(MapCtrl*)mapView viewForOverlay:(id <YMKOverlay>)overlay;
- (void)mapView:(MapCtrl*)mapView annotationView:(YMKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;

- (void)mapViewWillStartLocatingUser:(MapCtrl *)mapView;
- (void)mapViewDidStopLocatingUser:(MapCtrl *)mapView;
- (void)mapView:(MapCtrl *)mapView didUpdateUserLocation:(YMKUserLocation *)userLocation;
- (void)mapView:(MapCtrl *)mapView didFailToLocateUserWithError:(NSError *)error;
- (void)mapView:(MapCtrl *)mapView longPressWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)handleBeganTapWithPos:(CLLocationCoordinate2D)coordinate;
@end				