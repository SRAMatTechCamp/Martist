//
//  Setting.m
//  Martist
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "Setting.h"
#import "AppDelegate.h"

@interface Setting ()

@end

@implementation Setting
@synthesize getLocation;
@synthesize HowToGo;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setHowToGo:nil];
    [self setGetLocation:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)changeHowToGo:(id)sender{
    if([[HowToGo currentTitle] isEqualToString:@"ルート：徒歩"]){
        [HowToGo setTitle:@"ルート：車" forState:UIControlStateNormal];
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [app setCarFlag:TRUE];
    }else{
        [HowToGo setTitle:@"ルート：徒歩" forState:UIControlStateNormal];
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [app setCarFlag:FALSE];
    }
}

- (IBAction)changeGetLocation:(id)sender{
    if([[getLocation currentTitle] isEqualToString:@"現在地取得：なし"]){
        [getLocation setTitle:@"現在地取得：あり" forState:UIControlStateNormal];
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [app setLocationFlag:TRUE];
    }else{
        [getLocation setTitle:@"現在地取得：なし" forState:UIControlStateNormal];
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [app setLocationFlag:FALSE];
    }
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
