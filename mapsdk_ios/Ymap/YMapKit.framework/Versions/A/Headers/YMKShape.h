//
//  YMKShape.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//

#import <Foundation/Foundation.h>
#import "YMKAnnotation.h"

@interface YMKShape : NSObject <YMKAnnotation> {
	NSString *_title;
	NSString *_subtitle;
	CLLocationCoordinate2D coordinate;
}

@property (copy) NSString *subtitle;
@property (copy) NSString *title;

@end
