/*
 *  YMKGeometry.h
 *
 *  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
 *
 */

#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>

#import <UIKit/UIKit.h>


typedef struct {
    CLLocationDegrees latitudeDelta;
    CLLocationDegrees longitudeDelta;
} YMKCoordinateSpan;

typedef struct {
	CLLocationCoordinate2D center;
	YMKCoordinateSpan span;
} YMKCoordinateRegion;


UIKIT_STATIC_INLINE YMKCoordinateSpan YMKCoordinateSpanMake(CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta)
{
    YMKCoordinateSpan span;
    span.latitudeDelta = latitudeDelta;
    span.longitudeDelta = longitudeDelta;
    return span;
}

UIKIT_STATIC_INLINE YMKCoordinateRegion YMKCoordinateRegionMake(CLLocationCoordinate2D centerCoordinate, YMKCoordinateSpan span)
{
	YMKCoordinateRegion region;
	region.center = centerCoordinate;
	region.span = span;
	return region;
}

UIKIT_EXTERN YMKCoordinateRegion YMKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D centerCoordinate, CLLocationDistance latitudinalMeters, CLLocationDistance longitudinalMeters);

//4.0
typedef struct {
	double x;
	double y;
} YMKMapPoint;

typedef struct {
	double width;
	double height;
} YMKMapSize;

typedef struct {
	YMKMapPoint origin;
	YMKMapSize size;
} YMKMapRect;

typedef double YMKZoomScale;

