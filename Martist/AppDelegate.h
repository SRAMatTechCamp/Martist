//
//  AppDelegate.h
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/06.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (nonatomic, assign) BOOL CarFlag;
@property (nonatomic, assign) BOOL CameraFlag;
@property (nonatomic, assign) BOOL LocationFlag;
@property (nonatomic, assign) BOOL getStar;
@property (nonatomic, assign) BOOL setImage;
@property (nonatomic, assign) BOOL imageSet;
@property (nonatomic, retain) UIImage *image;
@property (strong, nonatomic) UIWindow *window;

@end
