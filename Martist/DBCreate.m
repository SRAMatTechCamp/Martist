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


+(id)dbConnect{
    //敵キャラステータスのデータベース
    NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* dir = [paths objectAtIndex:0];
    FMDatabase* db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"enemy.db"]];
    
    [db open];
    
    return db;
}

//アプリの初回起動時にDBの作成
-(void)createDB{
    NSLog(@"createDB");
    //以下はSQLiteの仕組みについて
    FMDatabase* db = [DBCreate dbConnect];
    //敵情報データベース
    //id, life, attack, defense, imagePath
    if([db open]) {
        [db setShouldCacheStatements:YES];
        NSString* sql = @"CREATE TABLE enemy (id INTEGER PRIMARY KEY, life INTEGER, attack INTEGER, defense INTEGER, imagePath TEXT);";
        [db executeUpdate:sql];
        [db executeUpdate:@"vacuum"];//DBの整理整頓？
        [db close];
        NSLog(@"DB作成完了");
    }
}

//DBの削除
-(void)deleteDB{
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        [db setShouldCacheStatements:YES];
        NSString* sql = @"DELETE FROM enemy";
        [db executeUpdate:sql];
        [db executeUpdate:@"vacuum"];
        [db close];
        NSLog(@"データベース削除完了");
    }
}

//敵データを追加する
-(void)addEnemyData{
    FMDatabase* db = [DBCreate dbConnect];
    
    if([db open]) {
        NSLog(@"open???");
        [db setShouldCacheStatements:YES];
        
        //TODO 引数は文字列にキャストしてから突っ込む。
        [db executeUpdate:@"INSERT INTO enemy (life,attack,defense,imagePath) VALUES (?,?,?,?)",@"50",@"10",@"10",@"shoboon.png"];
        [db executeUpdate:@"INSERT INTO enemy (life,attack,defense,imagePath) VALUES (?,?,?,?)",@"100",@"20",@"20",@"shoboon2.png"];
        NSLog(@"敵データ登録完了");
    }
    [db executeUpdate:@"vacuum"];
    [db close];
}

-(void)printEnemyData{
    FMDatabase* db = [DBCreate dbConnect];
    if([db open]){
        NSLog(@"open");
        [db setShouldCacheStatements:YES];
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM enemy"];
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
}

@end
