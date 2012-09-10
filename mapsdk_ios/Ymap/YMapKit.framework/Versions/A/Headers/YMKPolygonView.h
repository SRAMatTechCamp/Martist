//
//  YMKPolygonView.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <UIKit/UIKit.h>
#import "YMKOverlayPathView.h"
#import "YMKPolygon.h"

@interface YMKPolygonView : YMKOverlayPathView {
	YMKPolygon *_polygon;
}

@property (nonatomic, readonly) YMKPolygon *polygon;
- (id)initWithPolygon:(YMKPolygon *)polygon;

@end
