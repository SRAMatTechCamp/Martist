//
//  YMKMapView.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import "YMKAnnotationView.h"
#import "YMKGeometry.h"
#import "YMKTypes.h"
#import "MapDelegate.h"


@class YMKUserLocation;
@class YMKOverlayView;
@class MapCtrl;
@protocol YMKMapViewDelegate;
@protocol YMKOverlay;
@protocol YMKMapLayerDelegate;
@protocol YMKMapLayer;

@interface YMKMapView : UIView <MapDelegate>{
	MapCtrl* _internal;
	id <YMKMapViewDelegate> delegate;
}

@property (nonatomic, assign) id <YMKMapViewDelegate> delegate;
@property (nonatomic) YMKMapType mapType;
- (void)setMapType:(YMKMapType)mapType MapStyle:(NSString*)mapStyle MapStyleParam:(NSArray*)mapStyleParam;
//@property (nonatomic, assign) NSString* mapStyle;
//@property (nonatomic, assign) NSArray* mapStyleParam;
@property (nonatomic) CLLocationCoordinate2D centerCoordinate;
- (void)setCenterCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated;
@property (nonatomic) YMKCoordinateRegion region;
- (void)setRegion:(YMKCoordinateRegion)region animated:(BOOL)animated;

- (YMKCoordinateRegion)regionThatFits:(YMKCoordinateRegion)region;
- (CGPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate toPointToView:(UIView *)view;
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point toCoordinateFromView:(UIView *)view;
- (CGRect)convertRegion:(YMKCoordinateRegion)region toRectToView:(UIView *)view;
- (YMKCoordinateRegion)convertRect:(CGRect)rect toRegionFromView:(UIView *)view;

@property(nonatomic, getter=isZoomEnabled) BOOL zoomEnabled;
@property(nonatomic, getter=isScrollEnabled) BOOL scrollEnabled;
@property(nonatomic, getter=isScalebarVisible) BOOL scalebarVisible;

@property (nonatomic) BOOL showsUserLocation;
@property (nonatomic, readonly) YMKUserLocation *userLocation;
@property (nonatomic, readonly, getter=isUserLocationVisible) BOOL userLocationVisible;
@property (nonatomic) BOOL userLocationMarkVisible;

@property int scalebarValign;
@property int copyrightValign;

- (void) onTerminate;
- (void) onInActive;
- (void) onActive;

- (void)addAnnotation:(id <YMKAnnotation>)annotation;
- (void)addAnnotations:(NSArray *)annotations;
- (void)removeAnnotation:(id <YMKAnnotation>)annotation;
- (void)removeAnnotations:(NSArray *)annotations;
@property (nonatomic, readonly) NSArray *annotations;
- (YMKAnnotationView *)viewForAnnotation:(id <YMKAnnotation>)annotation;
- (YMKAnnotationView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier;
- (void)selectAnnotation:(id <YMKAnnotation>)annotation animated:(BOOL)animated;
- (void)deselectAnnotation:(id <YMKAnnotation>)annotation animated:(BOOL)animated;
@property (nonatomic, copy) NSArray *selectedAnnotations;
@property (nonatomic, readonly) CGRect annotationVisibleRect;

@property (nonatomic, readonly) NSArray *overlays;
- (void)addOverlay:(id < YMKOverlay >)overlay;
- (void)addOverlays:(NSArray *)overlays;
- (void)removeOverlay:(id < YMKOverlay >)overlay;
- (void)removeOverlays:(NSArray *)overlays;
- (void)insertOverlay:(id < YMKOverlay >)overlay atIndex:(NSUInteger)index;
- (void)exchangeOverlayAtIndex:(NSUInteger)index1 withOverlayAtIndex:(NSUInteger)index2;
- (void)insertOverlay:(id < YMKOverlay >)overlay aboveOverlay:(id < YMKOverlay >)sibling;
- (void)insertOverlay:(id < YMKOverlay >)overlay belowOverlay:(id < YMKOverlay >)sibling;
- (YMKOverlayView *)viewForOverlay:(id < YMKOverlay >)overlay;

- (int*) checkRangeX:(int)x Y:(int)y;

- (id)initWithFrame:(CGRect)frame appid:(NSString*) appid;

- (id)getAttestation;

- (id<YMKMapLayer>)getMapLayerWithLocation:(CLLocationCoordinate2D)location mapLayerDelegate:(id <YMKMapLayerDelegate>)mapLayerDelegate;
- (int) getZoomlevel;
@end

@protocol YMKMapViewDelegate <NSObject>
@optional

- (void)mapView:(YMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated;
- (void)mapView:(YMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated;

- (void)mapViewWillStartLoadingMap:(YMKMapView *)mapView;
- (void)mapViewDidFinishLoadingMap:(YMKMapView *)mapView;
- (void)mapViewDidFailLoadingMap:(YMKMapView *)mapView withError:(NSError *)error;

- (YMKAnnotationView *)mapView:(YMKMapView *)mapView viewForAnnotation:(id <YMKAnnotation>)annotation;

- (YMKOverlayView*)mapView:(YMKMapView*)mapView viewForOverlay:(id <YMKOverlay>)overlay;

- (void)mapView:(YMKMapView *)mapView didAddAnnotationViews:(NSArray *)views;

- (void)mapView:(YMKMapView *)mapView annotationView:(YMKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;

- (void)mapViewWillStartLocatingUser:(YMKMapView *)mapView;

- (void)mapViewDidStopLocatingUser:(YMKMapView *)mapView;

- (void)mapView:(YMKMapView *)mapView didUpdateUserLocation:(YMKUserLocation *)userLocation;

- (void)mapView:(YMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error;

- (void)mapView:(YMKMapView *)mapView longPressWithCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)mapView:(YMKMapView *)mapView beganPressWithCoordinate:(CLLocationCoordinate2D)coordinate;
@end