//
//  YMKProjection.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <UIKit/UIKit.h>
#import "YMKOverlay.h"
#import "YMKGeometry.h"
#import "ItemView.h"

@protocol YMKProjection;

@interface YMKOverlayView : ItemView {
	id <YMKOverlay> _overlay;
}

- (id)initWithOverlay:(id <YMKOverlay>)overlay;

@property (nonatomic, readonly) id <YMKOverlay> overlay;

- (CGPoint)pointForMapPoint:(YMKMapPoint)mapPoint;

- (YMKMapPoint)mapPointForPoint:(CGPoint)point;

- (CGRect)rectForMapRect:(YMKMapRect)mapRect;

- (YMKMapRect)mapRectForRect:(CGRect)rect;

- (BOOL)canDrawMapRect:(YMKMapRect)mapRect zoomScale:(YMKZoomScale)zoomScale;

- (void)drawMapRect:(YMKMapRect)mapRect zoomScale:(YMKZoomScale)zoomScale inContext:(CGContextRef)context;

- (void)setNeedsDisplayInMapRect:(YMKMapRect)mapRect;

- (void)setNeedsDisplayInMapRect:(YMKMapRect)mapRect zoomScale:(YMKZoomScale)zoomScale;

- (void)drawMapRect:(YMKMapRect)mapRect zoomScale:(YMKZoomScale)zoomScale inContext:(CGContextRef)context;

- (void)didFinishLoadingTileX:(int)x tileY:(int)y tileZ:(int)z tileScale:(double)scale tileSize:(int)size mapProjection:(id < YMKProjection >) projection;
- (void)changeMapProjection:(id < YMKProjection >) projection mapFrame:(CGRect)frame;
- (void)mapMoveX:(double)x moveY:(double)y mapProjection:(id < YMKProjection >) projection;
- (void)didRemoveTileX:(int)x tileY:(int)y tileZ:(int)z mapProjection:(id < YMKProjection >) projection;
@end