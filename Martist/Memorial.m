//
//  Memorial.m
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "Memorial.h"

@interface Memorial ()
//@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

@end

@implementation Memorial
@synthesize warningLabel;
@synthesize Twitter;
@synthesize photo;

UIImage *showedImage;

//主キー(num)を識別するための数字
int key;
int key_max;//現在の写真の枚数を保存
int delete_num=0;//削除する場所把握用


NSData *image_key1; 



NSData *pickedImage ;
//NSDataからNSStirngへの変換
NSString *pickedString;
//NSStringからnNSIntegerへの変換
NSInteger pickednum;



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


//初めて画面が呼ばれたときに呼ばれる
- (void)viewDidLoad
{
    //はじめに画面が呼ばれたときに初期化
    key = 1;
    NSLog(@"初期のkey:%d",key);
  
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPhoto:nil];
    [self setTwitter:nil];
    [self setWarningLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


//タブ:Memorialが選択されるたびに呼ばれる
//写真があれば、現在は毎回１枚目がされるようになっている
- (void)viewWillAppear:(BOOL)animated{
    
    //ここに画像を呼び出して、表示させる処理を書いた。
    //宣言はif文のなかではなく上で宣言しておく(中だと動かないときがある)
    FMResultSet *rs;
    FMDatabase* db = [DBCreate dbConnect];
    
    //データベースがあるとき
    if([db open]){
        [db setShouldCacheStatements:YES];
        
        //検索した結果を返す(現在はすべて返している)
        rs = [db executeQuery:@"SELECT * FROM album"];
        
        key_max = [self countAll];
        NSLog(@"現在の写真の数:%d",key_max);
        
        if(key >=1){
        //一番はじめにある画像が選択されている
        for (int i=0; i < key; i++) {
        if([rs next]){
            NSData *pickedImage = [[NSData alloc] initWithData:[rs dataForColumn:@"image"]];
            showedImage = [UIImage imageWithData:pickedImage];
            uploadImage = showedImage;
            [photo setImage:showedImage];
            
            NSLog(@"写真の番号:%d",key);
            
            //画像が表示されるときにはwarningLabelを隠す
            [warningLabel setHidden:YES];
        }else {
            uploadImage = showedImage;
            [photo setImage:showedImage];
        }
        }
        }
    }
    [rs close];
    [db close];
    
    NSLog(@"タブ:メモリアルが選択されました１");
    NSLog(@"表示された画像の番号:%d",key);
}



//現在のデータベースの行数を返す
-(int) countAll {
    NSString* sql1 = [NSString stringWithFormat:@"select count(*) as count from album"];
    FMDatabase* db = [DBCreate dbConnect];
    
    if(![db open]) {
        return 0;
    }
    [db setShouldCacheStatements:YES];
    
    FMResultSet* rs = nil;
    rs = [db executeQuery:sql1];
    
    int count = 0;
    if ([rs next]) {
        // just print out what we've got in a number of formats.
        count = [rs intForColumn:@"count"];
    }
    
    [rs close];
    [db close];
    
    return count;
}

//Twitterへ投稿できる
- (IBAction)Send:(id)sender{
    TWTweetComposeViewController *tweet = [[TWTweetComposeViewController alloc]init];
    
    [tweet setInitialText:@"ここにメッセージを入力してください     #Martist"];
    
    [tweet addImage:uploadImage];
    
    [self presentViewController:tweet animated:YES completion:nil];
    
}

//指定したデータをDBから削除する
//削除する場所の指定がまだ甘い
-(IBAction)deletePhotoData:(id)sender{
    if(delete_num ==0)
        delete_num = key;
    
    delete_num = key;
    NSLog(@"現在削除したい画像の位置%d",delete_num);
    
    //データベースを開く
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        //delete_num番目にあるデータを削除する
        [self deleteId:pickednum];
        
        NSLog(@"%d番目のデータを削除しました",delete_num);
        UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:@"写真を削除しました"  message: nil delegate:self  cancelButtonTitle:nil  otherButtonTitles:@"OK",nil];  
        [alert show];
        uploadImage = showedImage_key;
         [photo setImage:showedImage_key];
        
        /*if(key_max <= delete_num)
            delete_num = */
        
    
    }else {
        NSLog(@"データベースが開けなかったので");
        NSLog(@"データベースに登録できませんでした");
    }
}


//番号指定でデータの消去
-(void)deleteId:(int)recordId {

    NSString* sql = @"delete from album where num = ?";
    
    FMDatabase* db = [DBCreate dbConnect];
    
    if(![db open]) {
        return;
    }
    [db setShouldCacheStatements:YES];
    
    [db executeUpdate:sql, [NSNumber numberWithInt:recordId]];
    
    [db close];
}



//次の写真を表示する
-(IBAction)moveAfterPhoto:(id)sender{
    
    
    delete_num = key;
   
    NSLog(@"画像遷移前のkey:%d",key);
    NSLog(@"画像遷移前のkey_max:%d",key_max);
    
    key_max = [self countAll];
    NSLog(@"現在の写真の数:%d",key_max);
    
    //遷移の分岐イメージ
     //次の画像がある → 表示する
     //次の画像がない → alert(警告)を出す。次の画像は表示しない。
    
    //画像が表示されるときにはwarningLabelを隠す
    [warningLabel setHidden:YES];
    
    //データベースを開く
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        FMResultSet *rs_key;;
        rs_key = [db executeQuery:@"SELECT * FROM album"];
        [rs_key next];
        
        //現在表示している写真が最後の写真でないとき
        if(key_max >= key){
        //keyの回数分だけループを回す
        for (int i = 0; i < key; i++) {
            //次があれば表示される
        if( [rs_key next] ){
            image_key = [[NSData alloc] initWithData:[rs_key dataForColumn:@"image"]];
            showedImage_key = [UIImage imageWithData:image_key];
            uploadImage = showedImage_key;
            [photo setImage:showedImage_key];
        }
        }
            image_key1 = [[NSData alloc] initWithData:[rs_key dataForColumn:@"num"]];
            pickedString = [[NSString alloc] initWithData:image_key1 encoding:NSUTF8StringEncoding];
            //NSStringからnNSIntegerへの変換
            pickednum=[pickedString intValue];
            
            NSLog(@"現在の写真のnum:%d",pickednum);
     //NSLog(@"次の画像があるので遷移します");
    }
            
        if(key_max == 0){
            //写真が保存されていないときにはwarningLabelを表示する
            [warningLabel setHidden:NO];
        }else if(key_max == 1){//次の画像がないかつ写真が1枚のみ
            UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:@"次の画像がありません"  message: nil delegate:self  cancelButtonTitle:nil  otherButtonTitles:@"OK",nil];  
            [alert show];
            
            //画像が表示されるときにはwarningLabelを隠す
            [warningLabel setHidden:YES];
        }else if(key_max == key){
            UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:@"次の画像がありません"  message: nil delegate:self  cancelButtonTitle:nil  otherButtonTitles:@"OK",nil];  
            [alert show];
            NSLog(@"最後の画像です");
            
            [warningLabel setHidden:YES];
            
        }
        
        [warningLabel setHidden:YES];
        
        if(key_max == 0){
            UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:@"次の画像がありません"  message: nil delegate:self  cancelButtonTitle:nil  otherButtonTitles:@"OK",nil];  
            [alert show];
            [warningLabel setHidden:NO];
            
        }else if(key != key_max){//最後の画像のときにはkeyを増加させない
        key++;
        NSLog(@"現在のkey:%d",key);
        //ここを画面に表示させる
        NSLog(@"次の画面が表示されました");
        }
        
        
        NSLog(@"表示された画像の番号:%d",key);
        
    }else {
        NSLog(@"データベースが開けなかったので");
        NSLog(@"データベースに登録できませんでした");
    }
}

//前の写真を表示される
//一番前の画像が表示されないので直す
-(IBAction)moveBeforePhoto:(id)sender{
    
    key--;
    
    //削除後に前の画像が削除されるときよう
    delete_num = key - 1;
    
    [warningLabel setHidden:YES];
    //データベースを開く
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        //keyによるDB制御
        FMResultSet *rs_key;;
        rs_key = [db executeQuery:@"SELECT * FROM album"];
        [rs_key next];
        
        key_max = [self countAll];
        NSLog(@"現在の写真の数:%d",key_max);
        
        //2枚目以降にいるとき
        if(key > 1){
            //keyの回数分だけループを回す
            for (int i=0; i<key-1; i++) {
                  if( [rs_key next] ){
                    image_key = [[NSData alloc] initWithData:[rs_key dataForColumn:@"image"]];
                    showedImage_key = [UIImage imageWithData:image_key];
                      uploadImage = showedImage_key;
                   [photo setImage:showedImage_key];
                      
                      image_key1 = [[NSData alloc] initWithData:[rs_key dataForColumn:@"num"]];
                      
                }
                }
            pickedString = [[NSString alloc] initWithData:image_key1 encoding:NSUTF8StringEncoding];
            //NSStringからnNSIntegerへの変換
            pickednum=[pickedString intValue];
            NSLog(@"現在の写真のnum:%d",pickednum);
            
            NSLog(@"表示された画像の番号:%d",key);
           // NSLog(@"前の画面が表示されました");
        }else if(key ==1){
            image_key = [[NSData alloc] initWithData:[rs_key dataForColumn:@"image"]];
            showedImage_key = [UIImage imageWithData:image_key];
            uploadImage = showedImage_key;
            [photo setImage:showedImage_key];
            
            image_key1 = [[NSData alloc] initWithData:[rs_key dataForColumn:@"num"]];
            
            pickedString = [[NSString alloc] initWithData:image_key1 encoding:NSUTF8StringEncoding];
            //NSStringからnNSIntegerへの変換
            pickednum=[pickedString intValue];
            
            NSLog(@"現在の写真のnum:%d",pickednum);
        }else if(key < 1){
            image_key = [[NSData alloc] initWithData:[rs_key dataForColumn:@"image"]];
            showedImage_key = [UIImage imageWithData:image_key];
            uploadImage = showedImage_key;
            [photo setImage:showedImage_key];
            
            image_key1 = [[NSData alloc] initWithData:[rs_key dataForColumn:@"num"]];
            
            pickedString = [[NSString alloc] initWithData:image_key1 encoding:NSUTF8StringEncoding];
            //NSStringからnNSIntegerへの変換
            pickednum=[pickedString intValue];
            
             NSLog(@"現在の写真のnum:%d",pickednum);
            
            UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:@"前の画像がありません"  message: nil delegate:self  cancelButtonTitle:nil  otherButtonTitles:@"OK",nil];  
                [alert show];
            key=1;
        }
        
        if(key_max == 0){
            /*UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:@"次の画像がありません"  message: nil delegate:self  cancelButtonTitle:nil  otherButtonTitles:@"OK",nil];  
            [alert show];*/
            [warningLabel setHidden:NO];
        }
    }else {
        NSLog(@"データベースが開けなかったので");
        NSLog(@"データベースに登録できませんでした");
    }
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


//カメラから取ってきた画像を画面に表示する
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



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
