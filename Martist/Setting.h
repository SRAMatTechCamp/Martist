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
@property (weak, nonatomic) IBOutlet UIButton *writeStar;
@property (weak, nonatomic) IBOutlet UIButton *saveToCamera;
@property (weak, nonatomic) IBOutlet UIButton *getImageAddress;
@property (weak, nonatomic) IBOutlet UISwitch *putImage;
@property (weak, nonatomic) IBOutlet UISwitch *focusMe;

- (IBAction)changeHowToGo:(id)sender;

- (IBAction)changeGetLocation:(id)sender;

- (IBAction)setStar:(id)sender;

- (IBAction)saveCamera:(id)sender;

- (IBAction)getImgAdress:(id)sender;

- (IBAction)putImg:(id)sender;

- (IBAction)focusMe:(id)sender;

@end
