#import "YMapKitTestAppDelegate.h"
//画面を保存するのに必要
#import <QuartzCore/QuartzCore.h>
#import "MyAnnotation.h"
#import "AppDelegate.h"
#import "Memorial.h"



@implementation YMapKitTestAppDelegate
@synthesize window;
@synthesize st_point;
@synthesize gl_point;
@synthesize mapShowed;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    mapShowed = NO;
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    app.CarFlag = false;
    app.LocationFlag = false;
    app.getStar = false;
    app.CameraFlag = false;
    app.imageSet = false;
    app.setImage = false;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getLocationThread) userInfo:nil repeats:YES];
    }

- (void)viewDidUnload
{
    saveBotton = nil;
    searchBotton = nil;
    drawBotton = nil;
    pinOrMap = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//　１個前のルート削除メソッド
- (IBAction)removeroute:(id)sender{
    
    [map removeOverlay:routerOverLay_before];
    
}

// 検索するメソッド

-(IBAction)tappin:(id)sender {
    if(map.userInteractionEnabled){
        map.userInteractionEnabled = NO;
        [pinOrMap setTitle:@"ピン" forState:UIControlStateNormal];
    }else{
        map.userInteractionEnabled = YES;
        [pinOrMap setTitle:@"マップ" forState:UIControlStateNormal];
    }
}

- (IBAction)routing:(id)sender{
    //YMKRouteOverlayを作成
    YMKRouteOverlay* routeOrverlay = [[[YMKRouteOverlay alloc] initWithAppid:@"GTEGfaGxg67NbTJpzBxvZEE8bo6JBalSvNQQJVrrSEtfj6XZbnjh9_Agwmyqqdc-"] init];
    //YMKRouteOverlayDelegateを設定
    routeOrverlay.delegate = self;
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    //出発地、目的地、移動手段を設定
    if(app.CarFlag){
        [routeOrverlay setRouteStartPos:st_point withGoalPos:gl_point withTraffic:TRAFFIC_CAR];
    }else{
        [routeOrverlay setRouteStartPos:st_point withGoalPos:gl_point withTraffic:TRAFFIC_WALK];
    }
    

    [routeOrverlay search];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    pickPos = [touch locationInView:self.view];
    NSLog(@"OK");
    
    NSLog(@"x=%f",pickPos.x);
    NSLog(@"y=%f",pickPos.y);
    gl_point = st_point;
    st_point = [map convertPoint:pickPos toCoordinateFromView:nil];
    NSLog(@"%f",st_point.latitude);
    NSLog(@"%f",st_point.longitude);
    //MyAnnotationの初期化
    MyAnnotation* myAnnotation = [[MyAnnotation alloc] initWithLocationCoordinate:st_point title:[[NSString alloc] initWithString:@"節点"] subtitle:[[NSString alloc] initWithString:@"節点"]];
    //AnnotationをYMKMapViewに追加
    removeAnnotation = before2Annotation;
    before2Annotation = beforeAnnotation;
    beforeAnnotation = myAnnotation;
    [map removeAnnotation:removeAnnotation];
    [map addAnnotation:myAnnotation];
}

// データベースに保存するメソッド
//現在はDBに保存しているが、設定でカメラへ保存も選択できる
- (IBAction)saveToAlbum:(id)sender {
    UIImage* image;
  
    //地図部分だけの画像
    UIImage* mapImage; 
    
    // UIView のサイズの画像コンテキストを開始します。
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    // 開始した画像コンテキストを取得します。
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // UIView の内容を、開始した画像コンテキストへ書き出させます。
    [self.view.layer renderInContext:context];
    
    // 画像コンテキストから画像を生成します。
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //reImage = [self resizedImage:image];
    
    // 画像コンテキストを終了します。
    UIGraphicsEndImageContext();
    
    
    
    
    //データベースへのデータの保存
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        //mapの範囲を作成しきりとったものを代入
        CGRect map_rect = CGRectMake(0, 0, 320, 373);
        mapImage = [self makeUIImageFromUIView:map withRect:map_rect];
        
        NSData *imagedata = [[NSData alloc] initWithData:UIImagePNGRepresentation((mapImage))];
        
        // なんとなくタイムスタンプを保存
        NSDate* currentDate = [[NSDate alloc]init];
        
        //挿入するsql numは勝手に数字が順に保存される
        //imageDataは画像、currentDateは保存した日時
        if([db executeUpdate:@"INSERT INTO  album(image,time) VALUES (?,?)",imagedata,currentDate]) 
        NSLog(@"マップからDBへの挿入が完了しました");
        
        // Alertを表示する
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存されました" message:@"設定でカメラにも保存できます" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    }else {
        NSLog(@"データベースが開けなかったので");
        NSLog(@"データベースに登録できませんでした");
    };
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if(app.CameraFlag == TRUE){
        //image_af = [self resizedImage:image];
        
        //UIImage *image = [[self.view] UIImage];
        SEL sel = @selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:);
        
        UIImageWriteToSavedPhotosAlbum(image, self, sel, NULL);
        
        self.view.frame = CGRectMake(0, 0, 320, 480);
    }
    
    //カメラへ保存する部分
    /*image_af = [self resizedImage:image];
    
    //UIImage *image = [[self.view] UIImage];
    SEL sel = @selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:);

    UIImageWriteToSavedPhotosAlbum(image_af, self, sel, NULL);*/

    //self.view.frame = CGRectMake(0, 0, 320, 480);
    
}

// 保存が完了したら呼ばれるメソッド
-(void)savingImageIsFinished:(UIImage*)image
    didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    NSLog(@"保存が完了しました");
    
    // Alertを表示する
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存されました" message:@"設定でカメラにも保存できます" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

/** UIViewの一部をUIImageとして取得
 * @param view 対象のUIImage
 * @param rect 切り出したい位置とサイズ
 *
 * @return 対象のUIImage
 */
-(UIImage *)makeUIImageFromUIView:(UIView *)view
                         withRect:(CGRect)rect
{
    
    // オフスクリーン（見えない描画領域）を作成
    CGSize size = CGSizeMake( rect.size.width , rect.size.height );
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0); 
    // (補足：サイズ , NO:透過有 , 0.0:自動スケール　です）
    // オフスクリーン（見えない領域）描画よりグラフィックスコンテキスト取得
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 切り取り開始位置に合わせ
    // 左にpoint.x、上にpoint.y移動させるAffine変換を作成します。
    CGPoint point = rect.origin;
    CGAffineTransform affineMoveLeftTop
    = CGAffineTransformMakeTranslation(
                                       -(int)point.x ,
                                       -(int)point.y );
    // Affine変換を使用する為、コンテキストに設定
    CGContextConcatCTM( context , affineMoveLeftTop );
    
    // Viewの移動返還後のイメージをオフスクリーンに貼付けます。
    // （※　オフスクリーンからはみ出た領域は削除されるようです。 ）
    [(CALayer*)view.layer renderInContext:context];
    
    
    // オフスクリーンの内容をUIImageとして取り出します。
    // (autoreleaseと思います)
    UIImage *cnvImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // オフスクリーンを破棄します。
    UIGraphicsEndImageContext();
    
    return cnvImg;
    
}

//現在地取得
- (void) getLocationThread {
    
    [map removeAnnotation:beforeMyPoint];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if(mapShowed == TRUE && app.LocationFlag == TRUE){
        NSLog(@"OK");
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    }
    
    if(app.getStar == TRUE){
        [NSThread detachNewThreadSelector:@selector(putStarThread) toTarget:self withObject:nil];
        app.getStar = FALSE;
    }
    if(app.setImage == TRUE && app.imageSet == FALSE){
        UIImage *img = app.image;
        imgview = [[UIImageView alloc] initWithImage:img];
        imgview.alpha = 0.4;
        [self.view addSubview:imgview];
        if(app.image != nil){
            NSLog(@"aaaaaaa");
            app.imageSet = TRUE;
        }
    }else if(app.setImage == FALSE){
        [imgview removeFromSuperview];
    }
 
}

- (void) putStarThread{
    CLLocationCoordinate2D center = [map centerCoordinate];
    NSLog(@"%f",center.latitude);
    CLLocationCoordinate2D coors[6];
    coors[0].latitude = center.latitude + 0.0053236;
    coors[0].longitude = center.longitude + 0.0068044;
    coors[1].latitude = center.latitude - 0.0065854;
    coors[1].longitude = center.longitude - 0.0006276;
    coors[2].latitude = center.latitude + 0.0045286;
    coors[2].longitude = center.longitude - 0.0062666;
    coors[3].latitude = center.latitude - 0.0027264;
    coors[3].longitude =  center.longitude + 0.0060964;
    coors[4].latitude = center.latitude - 0.0035404;
    coors[4].longitude = center.longitude - 0.0060066;
    coors[5].latitude = center.latitude + 0.0053236;
    coors[5].longitude =  center.longitude + 0.0068044;
    YMKPolyline *line = [YMKPolyline polylineWithCoordinates:coors count:6];
    //YMKPolylineをYMKMapViewに追加
    [map addOverlay:line];
}

//画像をリサイズするメソッド
- (UIImage*)resizedImage:(UIImage *)img
{
    CGSize resizedSize = CGSizeMake(320, 375);
    
    UIGraphicsBeginImageContext(resizedSize);
    
    [img drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

- (UIImage*)resizedImageNew:(UIImage *)img size:(CGSize)size
{
    CGFloat widthRatio  = size.width  / img.size.width;
    CGFloat heightRatio = size.height / img.size.height;
    CGFloat ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio;
    CGSize resizedSize = CGSizeMake(img.size.width*ratio, img.size.height*ratio);
    
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
        //[map insertOverlay:routeOverlay aboveOverlay:routerOverLay_before];
        [map addOverlay:routeOverlay];
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"線が書けません" message:@"ピンを二つおいてください"
                                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

//overlay追加イベント
- (YMKOverlayView*)mapView:(YMKMapView *)mapView viewForOverlay:(id <YMKOverlay>)overlay
{
    //追加されたoverlayがYMKRouteOverlayか確認
    if([overlay isKindOfClass:[YMKRouteOverlay class]] ){
        
        //YMKRouteOverlayViewを作成
        YMKRouteOverlayView* wkYMKOverlayView = (YMKRouteOverlayView*)[[YMKRouteOverlayView alloc] initWithRouteOverlay:overlay];
        //出発地ピンを非表示
        wkYMKOverlayView.startPinVisible = NO;
        //目的地ピンを非表示
        wkYMKOverlayView.goalPinVisible = NO;
        //経由点ピンを非表示
        wkYMKOverlayView.routePinVisible = NO;
        
        
        return wkYMKOverlayView;
    }
    
    //追加されたoverlayがYMKPolylineか確認
    YMKPolyline* line = (YMKPolyline*)overlay;
    if([line isKindOfClass:[YMKPolyline class]] ){
        //YMKPolylineViewを作成
        YMKPolylineView*  wkYMKPolylineView = [[YMKPolylineView alloc] initWithOverlay:overlay];
        //ラインの色を青に設定
        wkYMKPolylineView.strokeColor =  [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.1];
        wkYMKPolylineView.fillColor =  [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3];
        //ラインの太さ
        wkYMKPolylineView.lineWidth = 20;
        return wkYMKPolylineView;
    }
    
    return nil;
}


//Annotation追加イベント
- (YMKAnnotationView*)mapView:(YMKMapView *)mapView viewForAnnotation:(MyAnnotation*)annotation{
    //追加されたAnnotationがMyAnnotationか確認
    if( [annotation isKindOfClass:[MyAnnotation class]] && annotation.coordinate.latitude == beforeMyPoint.coordinate.latitude && annotation.coordinate.longitude && beforeMyPoint.coordinate.longitude){
        //YMKPinAnnotationViewを作成
        YMKPinAnnotationView *pin = [[YMKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"Pin"];
        //アイコンイメージの変更
        pin.image=[UIImage imageNamed:@"compass48@2x.png"];
        //アイコンのイメージのどこを基準点にするか設定
        CGPoint centerOffset;
        centerOffset.x=15;
        centerOffset.y=15;
        [pin setCenterOffset:centerOffset];
        return pin;
    }
    return nil;
}
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [locationManager stopUpdatingLocation];    
    if(mapShowed == FALSE){
        mapShowed = TRUE;
        //YMKMapViewのインスタンスを作成
        map = [[YMKMapView alloc] initWithFrame:CGRectMake(0, 39, 320, 375) appid:@"GTEGfaGxg67NbTJpzBxvZEE8bo6JBalSvNQQJVrrSEtfj6XZbnjh9_Agwmyqqdc-" ];
        
        //地図のタイプを指定 標準の地図を指定
        map.mapType = YMKMapTypeStandard;
        
        
        //YMKMapViewDelegateを登録
        map.delegate = self;
        
        
        //地図の位置と縮尺を設定
        CLLocationCoordinate2D center;
        center.latitude = newLocation.coordinate.latitude;
        center.longitude = newLocation.coordinate.longitude;
        
        map.region = YMKCoordinateRegionMake(center, YMKCoordinateSpanMake(0.01, 0.01));
        
        [self.view addSubview:map];
        
        
    }else if(mapShowed == TRUE){
                   NSLog(@"nok");  
        CLLocationCoordinate2D center;
        center.latitude = newLocation.coordinate.latitude;
        center.longitude = newLocation.coordinate.longitude;
        MyAnnotation* myPoint = [[MyAnnotation alloc] initWithLocationCoordinate:center title:[[NSString alloc] initWithString:@"節点"] subtitle:[[NSString alloc] initWithString:@"節点"]];
        beforeMyPoint = myPoint;
        [map addAnnotation:myPoint];
    }    
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
