//
//  Tutorial.m
//  Martist
//
//  Created by 青井 翔平 on 12/09/14.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "Tutorial.h"

@interface Tutorial ()

@end

@implementation Tutorial
@synthesize start;

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
    [self setStart:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated{
    if(count == 0){
        [img01 removeFromSuperview];
        [img02 removeFromSuperview];
        [img03 removeFromSuperview];
        [img04 removeFromSuperview];
        [img05 removeFromSuperview];
    }
}

- (IBAction)start:(id)sender{
    count = 1;
    UIImage *img = [UIImage imageNamed:@"tu01.png"];
    img01 = [[UIImageView alloc] initWithImage:img];
    img01.userInteractionEnabled = TRUE;
    img01.frame =  CGRectMake(0, 0, 320, 410);
    [self.view addSubview:img01];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%d",count);
    UIImage *img;
    if(count == 1){
        img = [UIImage imageNamed:@"tu02.png"];
        img02 = [[UIImageView alloc] initWithImage:img];
        img02.frame =  CGRectMake(0, 0, 320, 410);
        img02.userInteractionEnabled = TRUE;
        [self.view addSubview:img02];
        count++;
    }else if(count == 2){
        img = [UIImage imageNamed:@"tu03.png"];
        img03 = [[UIImageView alloc] initWithImage:img];
        img03.frame =  CGRectMake(0, 0, 320, 410);
        [self.view addSubview:img03];
        count++;
    }else if(count == 3){
        img = [UIImage imageNamed:@"tu04.png"];
        img04 = [[UIImageView alloc] initWithImage:img];
        img04.frame =  CGRectMake(0, 0, 320, 410);
        [self.view addSubview:img04];
        count++;
    }else if(count == 4){
        img = [UIImage imageNamed:@"tu05.png"];
        img05 = [[UIImageView alloc] initWithImage:img];
        img05.frame =  CGRectMake(0, 0, 320, 410);
        [self.view addSubview:img05];
        count = 0;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
