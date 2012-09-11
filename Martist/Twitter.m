//
//  Twitter.m
//  Martist
//
//  Created by 青井 翔平 on 12/09/11.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "Twitter.h"

@interface Twitter ()

@end

@implementation Twitter

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

- (IBAction)Send:(id)sender{
    TWTweetComposeViewController *tweet = [[TWTweetComposeViewController alloc]init];
    
    [tweet setInitialText:inputtext.text];
    
    //[tweet addImage::(UIImage)*image];
    
    [self presentViewController:tweet animated:YES completion:nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
