#import "YMapKitTestAppDelegate.h"

@implementation YMapKitTestAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)viewDidLoad{
    
    //YMKMapViewのインスタンスを作成
    map = [[YMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 320) appid:@"GTEGfaGxg67NbTJpzBxvZEE8bo6JBalSvNQQJVrrSEtfj6XZbnjh9_Agwmyqqdc-" ];
    
    //地図のタイプを指定 標準の地図を指定
    map.mapType = YMKMapTypeStandard;
    
    //YMKMapViewを追加
    //[window addSubview:map];
    [self.view addSubview:map];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(180, 400, 20, 20)];
    [label setText:@"あいうえお"];
    [window addSubview:label];
    
    //YMKMapViewDelegateを登録
    map.delegate = self;
    
    
    //地図の位置と縮尺を設定
    CLLocationCoordinate2D center;
    center.latitude = 35.6657214;
    center.longitude = 139.7310058;
    
/*    map.region = YMKCoordinateRegionMake(center, YMKCoordinateSpanMake(0.002, 0.002));
    
    CLLocationCoordinate2D sp;
    sp.longitude = 139.7310058;
    sp.latitude = 35.6657214;
    CLLocationCoordinate2D gp;
    gp.longitude = 139.7454106;
    gp.latitude = 35.6586308;
    CLLocationCoordinate2D fp;
    fp.longitude = 139.7660840;
    fp.latitude = 35.6813822;
    
    
    //YMKRouteOverlayを作成
    YMKRouteOverlay* routeOrverlay = [[[YMKRouteOverlay alloc] initWithAppid:@"GTEGfaGxg67NbTJpzBxvZEE8bo6JBalSvNQQJVrrSEtfj6XZbnjh9_Agwmyqqdc-"] init];
    //YMKRouteOverlayDelegateを設定
    routeOrverlay.delegate = self;
    
    
    //出発地ピンの吹き出し設定
    [routeOrverlay setStartTitle:@"東京ミッドタウン"];
    
    [routeOrverlay setGoalTitle:@"大阪駅"];
    //出発地、目的地、移動手段を設定
    [routeOrverlay setRouteStartPos:sp withGoalPos:gp withTraffic:TRAFFIC_WALK];
    [routeOrverlay search];
    
    
    CGPoint point = CGPointMake(200, 300);
    CGPoint point2;
    CLLocationCoordinate2D xp;
    xp = [map convertPoint:point toCoordinateFromView:nil];
    point2 = [map convertCoordinate:sp toPointToView:nil];
    NSLog(@"%f", xp.latitude);
    NSLog(@"%f", point2.x);*/
}



//ルート検索が正常に終了した場合
-(void)finishRouteSearch:(YMKRouteOverlay*)routeOverlay
{
    //YMKRouteOverlayをYMKMapViewに追加
    //[map addOverlay:routeOverlay];
    if( routerOverLay_before ) {
        NSLog(@"yes");
        [map insertOverlay:routeOverlay aboveOverlay:routerOverLay_before];
    }
    else {
        NSLog(@"no");
        [map addOverlay:routeOverlay];
        NSInteger count;
        count = [routeOverlay nodeInfoCount];
        NSLog(@"%d",count);
    }
    routerOverLay_before = routeOverlay;
}
//ルート検索が正常に終了しなかった場合
-(void)errorRouteSearch:(YMKRouteOverlay*)routeOverlay withError:(int)error
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"エラー" message:@"ルート検索エラー"
                                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
