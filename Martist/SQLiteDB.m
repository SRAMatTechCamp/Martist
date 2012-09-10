//
//  SQLiteDB.m
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/10.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "SQLiteDB.h"

@implementation SQLiteDB
NSInteger number = 0;

+(id)dbConnect{
    //お絵描きフォトのデータベース
    NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* dir = [paths objectAtIndex:0];
    FMDatabase* db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"Album.db"]];//変更する必要あるところ?
    
    [db open];
    
    return db;
}

//アプリの初回起動時にDBの作成
-(void)createDB{
    NSLog(@"createDB");
    //以下はSQLiteの仕組みについて
    FMDatabase* db = [SQLiteDB dbConnect];
    
    //お絵描きフォトのデータベース(Album)
    //キーは番号、保存日時(No、Time)
    if([db open]) {
        [db setShouldCacheStatements:YES];
        NSString* sql = @"CREATE TABLE Album (No INTEGER PRIMARY KEY, Time REAL);";
        [db executeUpdate:sql];
        [db executeUpdate:@"vacuum"];//DBの整理整頓？
        [db close];
        NSLog(@"DB作成完了");
    }
}

//DBの削除
-(void)deleteDB{
    FMDatabase* db = [SQLiteDB dbConnect];
    if([db open]){
        [db setShouldCacheStatements:YES];
        NSString* sql = @"DELETE FROM Album";
        [db executeUpdate:sql];
        [db executeUpdate:@"vacuum"];
        [db close];
        NSLog(@"データベース削除完了");
    }
}

//お絵描きフォトを追加する
-(void)addPhotoData{
    FMDatabase* db = [SQLiteDB dbConnect];
    
    if([db open]) {
        NSLog(@"open Photo Album!!!");
        [db setShouldCacheStatements:YES];
        
        //引数は文字列にキャストしてから突っ込む。
        number += 1;
        NSString *num = [NSString stringWithFormat:@"%d", number];
        [db executeUpdate:@"INSERT INTO Album (No,imagePath) VALUES (?,?)",num,@"shoboon.png"];
        //[db executeUpdate:@"INSERT INTO enemy (life,attack,defense,imagePath) VALUES (?,?,?,?)",@"100",@"20",@"20",@"shoboon2.png"];
        NSLog(@"Albumへの登録完了!!!");
    }
    [db executeUpdate:@"vacuum"];
    [db close];
}


//登録された画像データの表示
-(void)printPhotoData{
    FMDatabase* db = [SQLiteDB dbConnect];
    if([db open]){
        NSLog(@"open");
        [db setShouldCacheStatements:YES];
        
        //データベースdbから条件に合うものをrsに代入して保存
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM Album"];
        NSLog(@"life = %d, attack = %d",[rs intForColumn:@"No"], [rs stringForColumn:@"Time"]);
        while ([rs next]) {
            NSLog(@"----------------------------");
            //ここでデータを展開
            NSLog(@"%d",[rs intForColumn:@"No"]);
            NSLog(@"%@", [rs stringForColumn:@"Time"]);
            NSLog(@"----------------------------");
        }
        [rs close];
        [db close];
    }else{
        NSLog(@"cannnot open");
    }
}

@end
