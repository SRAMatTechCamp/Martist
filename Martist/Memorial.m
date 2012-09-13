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
@synthesize Twitter;
@synthesize photo;

int now_num = 1;
UIImage *showedImage;

//主キー(num)を識別するための数字
int key;
int key_max=100;//現在の写真の枚数を保存
NSData *image_key;
UIImage *showedImage_key;



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
    //はじめに画面が呼ばれたときに初期化
    key = 1;
    NSLog(@"初期のkey:%d",key);
    
    //ここに画像を呼び出して、表示させる処理を書いた。
    //宣言はif文のなかではなく上で宣言しておく(中だと動かないときがある)
    FMResultSet *rs;
    
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        [db setShouldCacheStatements:YES];
        
        //検索した結果を返す(現在はすべて返している)
        rs = [db executeQuery:@"SELECT * FROM album"];
        
        //一番はじめにある画像が選択されている
        [rs next];
        NSData *pickedImage = [[NSData alloc] initWithData:[rs dataForColumn:@"image"]];
        showedImage = [UIImage imageWithData:pickedImage];
            
        //UIImageView(photo)のメソッドを用いて
        //画像(showedImage)を表示する
        [photo setImage:showedImage];
        
    
            /*//画像を読み込む
             showedImage = [UIImage imageNamed:@"error 1.png"];
        }*/
        
        //[rs next]により要素がある次々ループが回る
        /*[rs next];
        pickedImage = [[NSData alloc] initWithData:[rs dataForColumn:@"image"]];
        showedImage = [UIImage imageWithData:pickedImage];
        uploadImage = showedImage;*/
        
        //UIImageView(photo)のメソッドを用いて
        //画像(showedImage)を表示する
        [photo setImage:showedImage];
        NSLog(@"初期の画像の番号:%d",key);

        
        //[rs next]により要素がある次々ループが回る
        /*while ([rs next]) {
         NSData *pickedImage = [[NSData alloc] initWithData:[rs dataForColumn:@"image"]];
         showedImage = [UIImage imageWithData:pickedImage];
         
         //UIImageView(photo)のメソッドを用いて
         //画像(showedImage)を表示する
         [photo setImage:showedImage];
         }*/
        
    }
     [rs close];
     [db close];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPhoto:nil];
    [self setTwitter:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// カメラやアルバムから選んでもらった画像をアプリ(db)にもってくる
//現在は機能として取込んでいない
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
        
        [db executeUpdate:@"INSERT INTO album (time) values (?)",currentDate];
        NSLog(@"サンプルフォトデータ登録完了");
        [db commit];
        // select
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM album"];
        while([rs next]){
            // タイムスタンプを取得し、確認
            NSDate* rsDate = [rs dateForColumn:@"time"];
            NSLog(@"%@",rsDate);
        }
        
        //引数は文字列にキャストしてから突っ込む。
        /*currentDate = [NSDate date];
        [db executeUpdate:@"INSERT INTO  Album(num,name,time) VALUES (?,?,?)",@"1",@"selectedImade",currentDate];//日時を追加する*/
    }
    [db executeUpdate:@"vacuum"];
    [db close];

    NSLog(@"データベースへの登録設定一覧完了");
}

//Twitterへ投稿できる
- (IBAction)Send:(id)sender{
    TWTweetComposeViewController *tweet = [[TWTweetComposeViewController alloc]init];
    
    [tweet setInitialText:@"ここにメッセージを入力してください"];
    
    [tweet addImage:uploadImage];
    
    [self presentViewController:tweet animated:YES completion:nil];
    
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


//指定したデータをDBから削除する
-(IBAction)deletePhotoData:(id)sender{
    
    //ボタンが読み込まれるたびに値が加算されていく
    //now_num +=1;
    
    //データベースを開く
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        //データを削除する
        if(now_num <=  5){
        //[db executeUpdate:@"DELETE FROM  album WHERE num = ? ",denum]; 
        //[db executeUpdate:@"DELETE FROM  album WHERE num = 1 "]; 
          //  [db executeUpdate:@"DELETE FROM  album WHERE num = 2 "]; 
            //NSLog(@"%d番目のデータの削除が完了",now_num); 
        }
    }else {
        NSLog(@"データベースが開けなかったので");
        NSLog(@"データベースに登録できませんでした");
    };
}


//次の写真を表示する
-(IBAction)moveAfterPhoto:(id)sender{
    
    //データベースを開く
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        //写真遷移過程のイメージ
        //@データベースコネクト
        //現在の写真をimageで取得する
        //ある→その写真の表示
        //ない→ないことを通知する(あとで実装)
        //keyによるDB制御
        FMResultSet *rs_key;;
        rs_key = [db executeQuery:@"SELECT * FROM album"];
        [rs_key next];
        
        //データベースの最大値を超える場合の処理を付け加える
        
        //keyの回数分だけループを回す
        for (int i=0; i<key; i++) {
        if( [rs_key next] ){
            image_key = [[NSData alloc] initWithData:[rs_key dataForColumn:@"image"]];
            showedImage_key = [UIImage imageWithData:image_key];
        }else {
            NSLog(@"次の画像がありません");
            key_max =key;
        }
        }
        
         [photo setImage:showedImage_key];
        
        //最後の画像のときにはkeyを増加させない
        if(key != key_max){
        key++;
        NSLog(@"現在のkey:%d",key);
        //ここを画面に表示させる
        NSLog(@"次の画面が表示されました");
        }
        
        NSLog(@"表示された画像の番号:%d",key);
    }else {
        NSLog(@"データベースが開けなかったので");
        NSLog(@"データベースに登録できませんでした");
    };
}


//前の写真を表示される
-(IBAction)moveBeforePhoto:(id)sender{
    
    //データベースを開く
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        NSLog(@"現在のkey:%d",key);
        //keyによるDB制御
        FMResultSet *rs_key;;
        rs_key = [db executeQuery:@"SELECT * FROM album"];
        [rs_key next];
        
        //前のkeyの画像が存在するとき
        if(key > 1){
            //keyの回数分だけループを回す
            key--;
            for (int i=0; i<key-1; i++) {
               if(key == 1) {
                    NSLog(@"前の画像がありません");}
                else if( [rs_key next] ){
                    image_key = [[NSData alloc] initWithData:[rs_key dataForColumn:@"image"]];
                    showedImage_key = [UIImage imageWithData:image_key];
                    NSLog(@"表示された画像の番号:%d",key);
                    NSLog(@"前の画面が表示されました");
                }
                }
        }else if(key<=1){
            image_key = [[NSData alloc] initWithData:[rs_key dataForColumn:@"image"]];
            showedImage_key = [UIImage imageWithData:image_key];
            key = 1;
        }
        
        
        
        [photo setImage:showedImage_key];
        
    }else {
        NSLog(@"データベースが開けなかったので");
        NSLog(@"データベースに登録できませんでした");
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
