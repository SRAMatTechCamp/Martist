//
//  Setting.h
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Setting : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *HowToGo;
@property (weak, nonatomic) IBOutlet UIButton *getLocation;

- (IBAction)changeHowToGo:(id)sender;

- (IBAction)changeGetLocation:(id)sender;

@end
