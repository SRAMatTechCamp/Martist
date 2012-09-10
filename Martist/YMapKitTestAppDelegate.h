//
//  YMapKitTestAppDelegate.h
//  Martist
//
//  Created by 青井 翔平 on 12/09/10.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YMapKit/YMapKit.h> //YMapKit.frameworkのヘッダーファイルをインポー


#define MIDTOWN_LAT 35.6657214
#define MIDTOWN_LON 139.7310058

//YMKMapViewDelegateを追加
@interface YMapKitTestAppDelegate : UIViewController <YMKRouteOverlayDelegate, UIApplicationDelegate, YMKMapViewDelegate,YMKLabelTouchDelegate> {
    UIWindow *window;
    YMKMapView *map; //YMKMapViewインスタンス用ポインタ
    
    
    YMKRouteOverlay *routerOverLay_before;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;
@end

