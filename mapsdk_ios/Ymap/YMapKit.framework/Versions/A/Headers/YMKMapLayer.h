//
//  YMKMapLayer.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>
#import "YMKTypes.h"
#import "YMKGeometry.h"

@protocol YMKMapLayer <NSObject> 
@optional
	-(BOOL)existsWithMapType:(YMKMapType)mapType withSpan:(YMKCoordinateSpan)span;
	-(YMKCoordinateSpan)getMinSpanWithMapType:(YMKMapType)mapType;
	-(YMKCoordinateSpan)getMaxSpanWithMapType:(YMKMapType)mapType;
@end