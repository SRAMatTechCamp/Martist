//
//  AppDelegate.m
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/06.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "AppDelegate.h"
#import "DBCreate.h"

@implementation AppDelegate

@synthesize window = _window;

@synthesize CarFlag;
@synthesize LocationFlag;
@synthesize getStar;
@synthesize CameraFlag;
@synthesize image;
@synthesize setImage;
@synthesize imageSet;
@synthesize FocusFlag;

//アプリの初回起動時にのみ呼ばれるところ
//まずデータベースをここで作ってしまう
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"アプリが起動しました");
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* dir = [paths objectAtIndex:0];
    [dir stringByAppendingPathComponent:@"album.db"]; //  /album.dbへパスを作成
    NSLog(@"path:%@", [dir stringByAppendingPathComponent:@"album.db"]);
    
    //１回目の処理をNSUserDefualtを使用して書く。
    //定型文　覚えるぐらいの勢いで!!
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *save = [defaults objectForKey:@"save_data"];
    
    if(save == nil){
        NSLog(@"DB作成します。");
        DBCreate *create = [[DBCreate alloc] init];
        [create createDB];
        
        [defaults setObject:@"2" forKey:@"save_data"];
    }
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)setCarFlag:(BOOL)Carflag{
    CarFlag = Carflag;
}

- (void)setLocationFlag:(BOOL)Locationflag{
    LocationFlag = Locationflag;
}

-(BOOL)getCarFlag{
    return CarFlag;
}

-(BOOL)getLocationFlag{
    return LocationFlag;
}

@end
