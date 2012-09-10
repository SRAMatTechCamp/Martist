//
//  YMKProjection.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@protocol YMKProjection <NSObject>

- (CGPoint)convertCoordinate:(CLLocationCoordinate2D)coordinate;
- (CLLocationCoordinate2D)convertPoint:(CGPoint)point;
- (BOOL)convertToTileViewPoint:(CGRect*)pRect tileX:(int)x tileY:(int)y tileZ:(int)z;
- (CGPoint)viewPointForMapViewPoint:(CGPoint)point toView:(UIView*)view;
@end
