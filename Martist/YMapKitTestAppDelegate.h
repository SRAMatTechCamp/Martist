//
//  YMapKitTestAppDelegate.h
//  Martist
//
//  Created by 青井 翔平 on 12/09/10.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>//画面保存に必要なフレームワーク//画面保存に必要なフレームワーク//画面保存に必要なフレームワーク
#import <YMapKit/YMapKit.h> //YMapKit.frameworkのヘッダーファイルをインポート

#define MIDTOWN_LAT 35.6657214
#define MIDTOWN_LON 139.7310058

//YMKMapViewDelegateを追加
@interface YMapKitTestAppDelegate : UIViewController <YMKRouteOverlayDelegate, UIApplicationDelegate, YMKMapViewDelegate,YMKLabelTouchDelegate> {
    UIWindow *window;
    YMKMapView *map; //YMKMapViewインスタンス用ポインタ
    
    YMKRouteOverlay *routerOverLay_before;
    
    __weak IBOutlet UIButton *saveBotton;
    __weak IBOutlet UIButton *searchBotton;
    __weak IBOutlet UIButton *drawBotton;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//保存するメソッド
- (IBAction)saveToAlbum:(id)sender;
-(void)savingImageIsFinished:(UIImage*)image
    didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo;
- (UIImage*)resizedImage:(UIImage *)img ;

@end

