//
//  Tutorial.h
//  Martist
//
//  Created by 青井 翔平 on 12/09/14.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tutorial : UIViewController{
    int count;
    UIImageView *img01;
    UIImageView *img02;
    UIImageView *img03;
    UIImageView *img04;
    UIImageView *img05;
}
@property (weak, nonatomic) IBOutlet UIButton *start;

- (IBAction)start:(id)sender;

@end
