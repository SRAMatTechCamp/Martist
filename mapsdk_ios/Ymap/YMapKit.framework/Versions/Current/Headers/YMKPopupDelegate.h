//
//  YMKPopupDelegate.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>
#import "YMKAnnotation.h"

@protocol YMKPopupDelegate <NSObject>

-(BOOL) selectedAnnotation:(id <YMKAnnotation>)annotaion;

@end