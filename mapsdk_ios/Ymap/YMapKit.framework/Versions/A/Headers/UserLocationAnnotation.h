//
//  UserLocationAnnotation.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//

#import <Foundation/Foundation.h>
#import "YMKAnnotation.h"

@interface UserLocationAnnotation : NSObject <YMKAnnotation> {
	CLLocationCoordinate2D coordinate;
	CLLocationDistance altitude;
	CLLocationAccuracy horizontalAccuracy;
	CLLocationAccuracy verticalAccuracy;
	NSDate* timestamp;
	NSString *_title;
	NSString *_subtitle;
}
- (id)initWithLocation:(CLLocation*)loc title:(NSString *)title subtitle:(NSString *)subtitle; 
- (NSString *)title;  
- (NSString *)subtitle; 
@property  (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (readonly) CLLocationDistance altitude;
@property (readonly) CLLocationAccuracy horizontalAccuracy;
@property (readonly) CLLocationAccuracy verticalAccuracy;
@property (readonly) NSDate* timestamp;
- (void)setTitle:(NSString*)value;
- (void)setSubTitle:(NSString*)value;
- (void) setLocation:(CLLocation*)loc;
@end
