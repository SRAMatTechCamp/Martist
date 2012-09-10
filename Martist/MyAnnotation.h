//
//  MyAnnotation.h
//  Martist
//
//  Created by 青井 翔平 on 12/09/11.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <YMapKit/YMapKit.h>
#import <Foundation/Foundation.h>

@interface MyAnnotation : NSObject <YMKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *annotationTitle;
    NSString *annotationSubtitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *annotationTitle;
@property (nonatomic, retain) NSString *annotationSubtitle;

- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord
                           title:(NSString *)annTitle subtitle:(NSString *)annSubtitle;
- (NSString *)title;
- (NSString *)subtitle;
@end
