//
//  DBCreate.m
//  ThanksApp
//
//  Created by 航平 河合 on 12/05/08.
//  Copyright (c) 2012年 Doshisha.univ. All rights reserved.
//

#import "DBCreate.h"
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@implementation DBCreate


 //フォトアルバムのデータベース
+(id)dbConnect{
    NSLog(@"dbConnect");
    NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* dir = [paths objectAtIndex:0];
    FMDatabase* db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"album.db"]];
    
    NSLog(@"oepning");
    [db open];
    NSLog(@"opened");
    return db;
}

//アプリの初回起動時にDBの作成
-(void)createDB{
    NSLog(@"DB作成開始");
    //以下はSQLiteの仕組みについて
    FMDatabase* db = [DBCreate dbConnect];
    //敵情報データベース
    //キーはnumとTime(番号と保存日時、写真の形式String型)
    if([db open]) {
        [db setShouldCacheStatements:YES];
        NSString* sql = @"CREATE TABLE album (num INTEGER PRIMARY KEY AUTOINCREMENT,image BLOB,time TEXT);";
        if([db executeUpdate:sql]){
            NSLog(@"DB作成完了");
            [db executeUpdate:@"vacuum"];//DBの整理整頓？
        }else{
            NSLog(@"execute失敗");
        }
        [db close];
    }
}

//DBの削除
-(void)deleteDB{
    NSLog(@"deleteDB");
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        [db setShouldCacheStatements:YES];
        NSString* sql = @"DELETE FROM album";
        [db executeUpdate:sql];
        [db executeUpdate:@"vacuum"];
        [db close];
        NSLog(@"データベース削除完了");
    }
}

//フォトアルバムへのデータの追加
-(void)addAlbumData:(UIImage *)image{
    NSLog(@"addAlubumData");
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]) {
        NSLog(@"open albumDB");
        [db setShouldCacheStatements:YES];
        
        
        
        // なんとなくタイムスタンプを保存
        NSDate* currentDate = [NSDate date];
        [db executeUpdate:@"INSERT INTO album (time) values (?)",currentDate];
        [db commit];
        // select
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM album"];
        while([rs next]){
            // タイムスタンプを取得し、確認
            NSDate* rsDate = [rs dateForColumn:@"time"];
            NSLog(@"%@",rsDate);
        }
        
        //TODO 引数は文字列にキャストしてから突っ込む。
         currentDate = [NSDate date];
        [db executeUpdate:@"INSERT INTO  Album(num,name,time) VALUES (?,?,?)",@"1",@"shoboon.png",@"currentDate "];//日時を追加する
        //[db executeUpdate:@"INSERT INTO enemy (life,attack,defense,imagePath) VALUES (?,?,?,?)",@"100",@"20",@"20",@"shoboon2.png"];
        NSLog(@"サンプルフォトデータ登録完了");
    }
    [db executeUpdate:@"vacuum"];
    [db close];
}


/*-(void)printAlbumData{
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        NSLog(@"open");
        [db setShouldCacheStatements:YES];
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Album"];
//            NSLog(@"life = %d, attack = %d",[rs intForColumn:@"life"], [rs intForColumn:@"attack"]);
        while ([rs next]) {
            NSLog(@"----------------------------");
            //ここでデータを展開
            NSLog(@"%@", [rs stringForColumn:@"defense"]);
            NSLog(@"%d",[rs intForColumn:@"attack"]);
            NSLog(@"%d",[rs intForColumn:@"life"]);
            NSLog(@"----------------------------");
        }
        [rs close];
        [db close];
    }else{
        NSLog(@"cannnot open");
    }
}*/

@end
