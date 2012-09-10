//
//  DrawOnMap.m
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "DrawOnMap.h"

@interface DrawOnMap ()
//@property (weak, nonatomic) IBOutlet UIButton *saveBotton;
@end

@implementation DrawOnMap
//@synthesize saveBotton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //画面の大きさを調べた
    CGRect r = [[UIScreen mainScreen] bounds];
    CGFloat w = r.size.width;
    CGFloat h = r.size.height;
    NSLog(@"画面の横幅は%f",w);
    NSLog(@"画面の高さは%f",h);
}

- (void)viewDidUnload
{
   // [self setSaveBotton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// 保存するメソッド
/*- (IBAction)saveToAlbum:(id)sender {
    UIImage* image;
    UIImage* image_af;
    
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
    
    //image_af = [resizedImage:image];
    
    //UIImage *image = [[self.view] UIImage];
    SEL sel = @selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:);
    UIImageWriteToSavedPhotosAlbum(image, self, sel, NULL);
}

// 保存が完了したら呼ばれるメソッド
-(void)savingImageIsFinished:(UIImage*)image
    didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    NSLog(@"保存が完了しました");
    
    // Alertを表示する
   // UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:@"保存しました" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] autorelease];
    //[alert show];
}*/


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



//トリプルタップを検出し、画面を保存する
/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if([[touches anyObject] tapCount] == 3){
    UIImage* image;
    
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
    
    //UIImage *image = [[self.view] UIImage];
    SEL sel = @selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:);
    UIImageWriteToSavedPhotosAlbum(image, self, sel, NULL);
}
}*/




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
