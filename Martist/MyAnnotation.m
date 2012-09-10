//
//  MyAnnotation.m
//  Martist
//
//  Created by 青井 翔平 on 12/09/11.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <YMapKit/YMapKit.h>
#import "MyAnnotation.h"
@implementation MyAnnotation
@synthesize coordinate;
@synthesize annotationTitle;
@synthesize annotationSubtitle;

//初期化処理
- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord
                           title:(NSString *)annTitle subtitle:(NSString *)annSubtitle {
    if (self=[super init]) {
        coordinate.latitude = coord.latitude;
        coordinate.longitude = coord.longitude;
        annotationTitle = annTitle;
        annotationSubtitle = annSubtitle;
    }
    return self;
}

//タイトル
- (NSString *)title
{
    return annotationTitle;
}

//サブタイトル
- (NSString *)subtitle
{
    return annotationSubtitle;
}
@end
