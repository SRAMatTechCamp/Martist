//										
//  YMKAnnotation.h													
//												
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>		
#import <CoreLocation/CoreLocation.h>	

@protocol YMKAnnotation <NSObject>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@optional

- (NSString *)title;	
- (NSString *)subtitle;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end