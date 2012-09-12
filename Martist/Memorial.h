//
//  Memorial.h
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBCreate.h"
#import <Twitter/Twitter.h>


//デリゲート用の記述
@interface Memorial : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    UIImage *uploadImage;
}
@property (weak, nonatomic) IBOutlet


UIImageView *photo;
@property (nonatomic, strong) IBOutlet UITextView *inputtext;

- (IBAction)Send:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Twitter;
@end
