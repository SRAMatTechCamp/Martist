//
//  DBCreate.h
//  ThanksApp
//
//  Created by 航平 河合 on 12/05/08.
//  Copyright (c) 2012年 Doshisha.univ. All rights reserved.
//

//#import <Foundation/Foundation.h>
//#import "AppDelegate.h"
#import "FMDatabase.h"

@interface DBCreate : NSObject

+(id)dbConnect;
-(void)createDB;
-(void)deleteDB;
-(id)dbdelete;
//+(id)getMax;
//-(NSDictionary *)getMax:(NSDictionary *)tempDic;

//+(id)getMaxConnect;
//-(NSDictionary *)getMaxConnect:(NSString *)fb_id:(NSString *)friendstring;
//-(void)defaultCard;
//+(id)dbcheck;


-(void)addAlbumData:(UIImage *)img;
//-(void)printEnemyData;
@end
