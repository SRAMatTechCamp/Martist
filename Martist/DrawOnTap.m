//
//  DrawOnTap.m
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/06.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

//現在の機能
//ダブルタップとマルチタップの区別、タップの位置を検出する、

#import "DrawOnTap.h"
//#import <ApplicationServices/ApplicationServices.h>

@interface DrawOnTap(){
    CGPoint beginPoint;
    CGPoint endPoint;
  // __weak IBOutlet UIButton *saveBotton;
};

@end

@implementation DrawOnTap
@synthesize tapLabel;
@synthesize tap2Label;

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
	// 機能の追加
}

- (void)viewDidUnload
{
    [self setTapLabel:nil];
    [self setTap2Label:nil];
    //saveBotton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

 //シングルタップを検出し、画面に表示する
/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
    tapLabel.text = @"One Tap View!";
}*/

//ダブルタップとマルチタップの区別
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if([[touches anyObject] tapCount] == 2){
        tap2Label.text = @"Duble Tap!";
    }else if([[touches anyObject] tapCount] > 2) {
        tap2Label.text = @"Malti Tap!";
    }
}

//タップの位置を検出する
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
 
    beginPoint = [[touches anyObject] locationInView:self.view];
    endPoint = [[touches anyObject] locationInView:self.view];
    
    
    
}

// 保存するメソッド
- (IBAction)save:(id)sender {
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


// 保存完了を通知するメソッド
 /*- (void) savingImageIsFinished:(UIImage *)_image didFinishSavingWithError:(NSError *)_error contextInfo:(void *)_contextInfo{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"End"message:@"image save completed"delegate:nilcancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alert show];
    [alert release];
}*/
    

/*//タップした位置を直線で結ぶ
- (void)drawLine{
    //[super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIColor *color =UIColor.redColor;
    // 線の色を設定
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);

    //CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    //CGContextFillRect(ctx, rect);
    
    
    // 直線を描画する
    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextStrokePath(ctx);
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 200, 200);
    CGContextStrokePath(ctx);

}*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
