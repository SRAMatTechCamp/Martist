//
//  SQLiteDB.h
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/10.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//




#import "FMDatabase.h"
//#import <Foundation/Foundation.h>

@interface SQLiteDB : NSObject
-(id)dbdelete;
-(void)createDB;
-(void)deleteDB;
+(id)dbConnect;
//+(id)getMax;
//-(NSDictionary *)getMax:(NSDictionary *)tempDic;

//+(id)getMaxConnect;
//-(NSDictionary *)getMaxConnect:(NSString *)fb_id:(NSString *)friendstring;
//-(void)defaultCard;
//+(id)dbcheck;

-(void)addPhotoData;
-(void)printPhotoData;

@end
