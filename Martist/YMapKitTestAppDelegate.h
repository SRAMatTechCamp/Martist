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
#import <Foundation/Foundation.h>
#import "MyAnnotation.h"

#define MIDTOWN_LAT 35.6657214
#define MIDTOWN_LON 139.7310058

//YMKMapViewDelegateを追加
@interface YMapKitTestAppDelegate : UIViewController <YMKRouteOverlayDelegate, UIApplicationDelegate, YMKMapViewDelegate,YMKLabelTouchDelegate,YMKAnnotation> {
    UIWindow *window;
    YMKMapView *map; //YMKMapViewインスタンス用ポインタ
    int judgeStatement;
    CGPoint pickPos;    
    YMKRouteOverlay *routerOverLay_before;
    MyAnnotation *removeAnnotation;
    MyAnnotation *beforeAnnotation;
    MyAnnotation *before2Annotation;
    CLLocationCoordinate2D st_point;
    CLLocationCoordinate2D gl_point;
    NSString *annotationTitle;
    NSString *annotationSubtitle;
    
    __weak IBOutlet UIButton *saveBotton;
    __weak IBOutlet UIButton *searchBotton;
    __weak IBOutlet UIButton *drawBotton;
}

@property (nonatomic, readwrite) CLLocationCoordinate2D st_point;
@property (nonatomic, readwrite) CLLocationCoordinate2D gl_point;
@property (nonatomic, readwrite) NSString *annotationTitle;
@property (nonatomic, readwrite) NSString *annotationSubtitle;
@property (nonatomic, retain) IBOutlet UIWindow *window;
//保存するメソッド
- (IBAction)saveToAlbum:(id)sender;
- (void)savingImageIsFinished:(UIImage*)image
    didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo;
- (UIImage*)resizedImage:(UIImage *)img ;

- (IBAction)tappin:(id)sender;

- (IBAction)routing:(id)sender;

- (IBAction)removeroute:(id)sender;

- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord title:(NSString *)annTitle subtitle:(NSString *)annSubtitle;
- (NSString *)title;

- (NSString *)subtitle;

@end

