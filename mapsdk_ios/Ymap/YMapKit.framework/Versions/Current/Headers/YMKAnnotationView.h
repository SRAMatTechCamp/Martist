//	
//  YMKAnnotationView.h
//
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//	
#import <UIKit/UIKit.h>
#import "YMKAnnotation.h"
#import "ItemView.h"
@class TabView;

@interface YMKAnnotationView : ItemView{
	TabView* _tabView;
	NSString *reuseIdentifier;
	id <YMKAnnotation> annotation;
	UIImage *image;
	CGPoint centerOffset;
	CGPoint calloutOffset;
	CGPoint centerOffsetShadow;
	BOOL enabled;
	BOOL highlighted;
	BOOL selected;
	BOOL canShowCallout;
	UIView *leftCalloutAccessoryView;
	UIView *rightCalloutAccessoryView;
	UIImageView *shadowView;
	BOOL _popBackVisible;
}

- (id)initWithAnnotation:(id <YMKAnnotation>)wkannotation reuseIdentifier:(NSString *)_reuseIdentifier;
	
@property (nonatomic, readonly) NSString *reuseIdentifier;
- (void)prepareForReuse;
	
@property (nonatomic, retain) id <YMKAnnotation> annotation;
	
@property (nonatomic,retain) UIImage *image;

@property (nonatomic) CGPoint centerOffset;

@property (nonatomic) CGPoint calloutOffset;

@property (nonatomic, getter=isEnabled) BOOL enabled;

@property (nonatomic, getter=isHighlighted) BOOL highlighted;
	
@property (nonatomic, getter=isSelected) BOOL selected;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@property (nonatomic) BOOL canShowCallout;

@property (retain, nonatomic) UIView *leftCalloutAccessoryView;

@property (retain, nonatomic) UIView *rightCalloutAccessoryView;

- (void)setImageShadow:(UIImage*)imageShadow withCenterOffset:(CGPoint)offset;

@property BOOL popBackVisible;

@end