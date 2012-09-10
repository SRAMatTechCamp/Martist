/*
 *  YMKUserLocation.h
 *
 *  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
 *
 */

#import <Foundation/Foundation.h>
#import "YMKAnnotation.h"

@class CLLocation;
@class UserLocationAnnotation;

@interface YMKUserLocation : NSObject <YMKAnnotation> {
	UserLocationAnnotation* _internal;
}
- (id) initWithInternal:(UserLocationAnnotation*)usrLocAnnotation;
@property (readonly, nonatomic, getter=isUpdating) BOOL updating;
@property (readonly, nonatomic) CLLocation *location;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *subtitle;

@end