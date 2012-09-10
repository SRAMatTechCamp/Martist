/*
 *  YMKLabelTouchDelegate.h
 *
 *  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
 *
 */

#import <Foundation/Foundation.h>
#import "YMKLabelInfo.h"

@protocol YMKLabelTouchDelegate <NSObject>

@optional

-(void)onLabelTouchWithLabelInfo:(YMKLabelInfo*)labelInfo;

@end