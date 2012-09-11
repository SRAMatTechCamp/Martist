//
//  Memorial.m
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "Memorial.h"
//#import "DBCreate.h"

@interface Memorial ()

@end

@implementation Memorial
@synthesize photo;

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
    //ここに画像を呼び出して、表示させる処理を書いた。
    //宣言はif文のなかではなく上で宣言しておく(中だと動かないときがある)
    UIImage *showedImage;
    FMResultSet *rs;
    
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        [db setShouldCacheStatements:YES];
        
        //検索した結果を返す(現在はすべて返している)
        rs = [db executeQuery:@"SELECT * FROM album"];
        
        //[rs next]により要素がある次々ループが回る
        while ([rs next]) {
            NSData *pickedImage = [[NSData alloc] initWithData:[rs dataForColumn:@"image"]];
            showedImage = [UIImage imageWithData:pickedImage];
            
            //UIImageView(photo)のメソッドを用いて
            //画像(showedImage)を表示する
            [photo setImage:showedImage];
        }
    }
     [rs close];
     [db close];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPhoto:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// カメラやアルバムから選んでもらった画像をアプリ(db)にもってくる
-(IBAction)pickfromphoto:(id)sender imagePickerController:(UIImagePickerController *)picker 
 didFinishPickingMediaWithInfo:(NSDictionary *)info {;
    
    //フォトアルバムから持ってくる設定
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    ipc.delegate = self;//デリゲートが自分自身と宣言して、いろんなメソッドが使える形にする
    
    //カメラのフォトの選択画面に遷移する
    [self presentModalViewController:ipc animated:YES];
    
    // ユーザーの選んだ画像を取得します
    NSLog(@"カメラのアルバムで画像の選択完了");
   
    //UIViewImageをコードで記述した場合
    //UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 360, 240)];
    //[photo setImage:selectedImage];
    //[self.view addSubview:photo];
    
    //データベースの構築、データの追加
    FMDatabase* db = [DBCreate dbConnect];
    NSLog(@"アルバムにデータを保存");
    if([db open]) {
        NSLog(@"open albumDB");
        [db setShouldCacheStatements:YES];
        
        // なんとなくタイムスタンプを保存
        NSDate* currentDate = [[NSDate alloc]init];
        //変換用のformatter 
        
        // NSDate型を「yyyy/MM/dd HH:mm:ss」形式の文字列として取得する
        //今の時刻を表示させる
        /*NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat  = @"yyyy/MM/dd HH:mm:ss";
        NSString *str = [df stringFromDate:[NSDate date]];
        NSLog(@"変換後の時間:%@",str);
        NSLog(@"変換前の時間%@",currentDate);*/
        
        [db executeUpdate:@"INSERT INTO album (time) values (?)",currentDate];
        [db commit];
        // select
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM album"];
        while([rs next]){
            // タイムスタンプを取得し、確認
            NSDate* rsDate = [rs dateForColumn:@"time"];
            NSLog(@"%@",rsDate);
        }
        
        //引数は文字列にキャストしてから突っ込む。
        currentDate = [NSDate date];
        [db executeUpdate:@"INSERT INTO  Album(num,name,time) VALUES (?,?,?)",@"1",@"selectedImade",currentDate];//日時を追加する
        NSLog(@"サンプルフォトデータ登録完了");
    }
    [db executeUpdate:@"vacuum"];
    [db close];

    NSLog(@"データベースへの登録設定一覧完了");
}


//取ってきた画像を画面に表示する
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        
        NSData *imagedata = [[NSData alloc] initWithData:UIImagePNGRepresentation((image))];
        
        // なんとなくタイムスタンプを保存
        NSDate* currentDate = [[NSDate alloc]init];
        
        // NSDate型を「yyyy/MM/dd HH:mm:ss」形式の文字列として取得する
        //今の時刻を表示させる
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat  = @"yyyy/MM/dd HH:mm:ss";
        NSString *str = [df stringFromDate:[NSDate date]];
        NSLog(@"変換後の時間:%@",str);
        NSLog(@"変換前の時間%@",currentDate);
        
        /*文字から数に変換する方法
        [str intValue];
         NSLog(@"変換後の時間(数値表現):%@",str);*/
        
        //挿入するsql numは勝手に数字が順に保存される
        //imageDataは画像、currentDateは保存した日時
        if([db executeUpdate:@"INSERT INTO  album(image,time) VALUES (?,?)",imagedata,currentDate]) 
            NSLog(@"データの挿入が完了しました");
    }else {
        NSLog(@"データベースが開けなかったので");
        NSLog(@"データベースに登録できませんでした");
    };
    
    //モーダルビュー(選択画面)を閉じる
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
