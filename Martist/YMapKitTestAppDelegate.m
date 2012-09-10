#import "YMapKitTestAppDelegate.h"
//画面を保存するのに必要
//#import <QuartzCore/QuartzCore.h>

@interface YMapKitTestAppDelegate (){
}
@end

@implementation YMapKitTestAppDelegate
@synthesize window;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad{

//YMKMapViewのインスタンスを作成
map = [[YMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 375) appid:@"GTEGfaGxg67NbTJpzBxvZEE8bo6JBalSvNQQJVrrSEtfj6XZbnjh9_Agwmyqqdc-" ];

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

- (void)viewDidUnload
{
    saveBotton = nil;
    searchBotton = nil;
    drawBotton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// 保存するメソッド
- (IBAction)saveToAlbum:(id)sender {
    UIImage* image;
    UIImage* image_af;
    
    NSLog(@"保存が完了しました1");
    // UIView のサイズの画像コンテキストを開始します。
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    // 開始した画像コンテキストを取得します。
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // UIView の内容を、開始した画像コンテキストへ書き出させます。
    [self.view.layer renderInContext:context];
    
    // 画像コンテキストから画像を生成します。
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 画像コンテキストを終了します。
    UIGraphicsEndImageContext();
    
    NSLog(@"保存が完了しました2");
    
    image_af = [self resizedImage:image];
    
    //UIImage *image = [[self.view] UIImage];
    SEL sel = @selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:);
    UIImageWriteToSavedPhotosAlbum(image_af, self, sel, NULL);
    NSLog(@"保存が完了しました3");
}

// 保存が完了したら呼ばれるメソッド
-(void)savingImageIsFinished:(UIImage*)image
    didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    NSLog(@"保存が完了しました");
    
    // Alertを表示する
    // UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"保存しました" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] autorelease];
    //[alert show];
}


//画像をリサイズするメソッド
- (UIImage*)resizedImage:(UIImage *)img 
{
    //CGFloat widthRatio  = size.width  / img.size.width;
    //CGFloat heightRatio = size.height / img.size.height;
    //CGFloat ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio;
    CGSize resizedSize = CGSizeMake(320, 375);
    
    UIGraphicsBeginImageContext(resizedSize);
    
    [img drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [window makeKeyAndVisible];
    
    return YES;
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





// 例えば、カメラやアルバムから選んでもらった画像を扱います
/*- (void) imagePickerController:(UIImagePickerController *)picker 
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // ユーザーの選んだ（または撮影した）画像を取得します
    UIImage *aImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // JPEGのデータとしてNSDataを作成します
    // ここのUIImageJPEGRepresentationがミソです
    NSData *data = UIImageJPEGRepresentation(aImage, 0.8f);
    
    // 保存するディレクトリを指定します
    // ここではデータを保存する為に一般的に使われるDocumentsディレクトリ
    NSString *path = [NSStringstringWithFormat:@"%@/sample.jpg",
                      [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];
    
    
    // NSDataのwriteToFileメソッドを使ってファイルに書き込みます
    // atomically=YESの場合、同名のファイルがあったら、まずは別名で作成して、その後、ファイルの上書きを行います
    if ([data writeToFile:path atomically:YES]) {
        NSLog(@"save OK");
    } else {
        NSLog(@"save NG");
    }
}*/



@end
