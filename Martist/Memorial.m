//
//  Memorial.m
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "Memorial.h"

@interface Memorial ()

@end

@implementation Memorial

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



// カメラやアルバムから選んでもらった画像をアプリにもってくる
/*- (void) imagePickerController:(UIImagePickerController *)picker 
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // ユーザーの選んだ（または撮影した）画像を取得します
    UIImage *aImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // JPEGのデータとしてNSDataを作成します
    // ここのUIImageJPEGRepresentationがミソです
    NSData *data = UIImageJPEGRepresentation(aImage, 0.8f);
    
    // 保存するディレクトリを指定します
    // ここではデータを保存する為に一般的に使われるDocumentsディレクトリ
    //実際にはSQLiteを用いてデータベースに保存する
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
