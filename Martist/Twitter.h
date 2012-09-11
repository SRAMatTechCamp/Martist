//
//  Twitter.h
//  Martist
//
//  Created by 青井 翔平 on 12/09/11.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>

@interface Twitter : UIViewController{
    UITextView *inputtext;
}

@property (nonatomic, strong) IBOutlet UITextView *inputtext;

- (IBAction)Send:(id)sender;

@end
