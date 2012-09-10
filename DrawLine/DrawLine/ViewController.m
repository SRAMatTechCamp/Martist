//
//  ViewController.m
//  DrawLine
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)clickLine:(id)sender
{
    DrawLineView *_view = [[DrawLineView alloc] initWithFrame:sampleView.bounds];
    _view.frame = sampleView.frame;
    [self.view addSubview:_view];
}
- (IBAction)clickRect:(id)sender
{
    DrawRect2View *view = [[DrawRect2View alloc] initWithFrame:sampleView.bounds];
    view.frame = sampleView.frame;
    [self.view addSubview:view];
    
}
- (IBAction)clickCircle:(id)sender
{
    DrawCircleView *view = [[DrawCircleView alloc] initWithFrame:sampleView.bounds];
    view.frame = sampleView.frame;
    [self.view addSubview:view];
}
- (IBAction)clickText:(id)sender
{
    DrawText2View *view = [[DrawText2View alloc] initWithFrame:sampleView.bounds];
    view.frame = sampleView.frame;
    [self.view addSubview:view];
    
}
- (IBAction)clickStar:(id)sender
{
    DrawStarView *view = [[DrawStarView alloc] initWithFrame:sampleView.bounds];
    view.frame = sampleView.frame;
    [self.view addSubview:view];
    
}
- (IBAction)clickFont:(id)sender
{
    DrawFontView *view = [[DrawFontView alloc] initWithFrame:sampleView.bounds];
    view.frame = sampleView.frame;
    [self.view addSubview:view];
    
}
- (IBAction)clickTextShadow:(id)sender
{
    DrawTextShadowView *view = [[DrawTextShadowView alloc] initWithFrame:sampleView.bounds];
    view.frame = sampleView.frame;
    [self.view addSubview:view];
    
}
- (IBAction)clickTextColor:(id)sender
{
    DrawTextColorView *view = [[DrawTextColorView alloc] initWithFrame:sampleView.bounds];
    view.frame = sampleView.frame;
    [self.view addSubview:view];
    
}


@end

@implementation DrawLineView
- (void)drawRect:(CGRect)rect  
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(ctx, rect);
    // 直線を描画する
    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextMoveToPoint(ctx, rect.size.width, 0);
    CGContextAddLineToPoint(ctx, 0, rect.size.height);
    CGContextStrokePath(ctx);
}
@end

@implementation DrawRect2View
- (void)drawRect:(CGRect)rect  
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(ctx, rect);
    
    // 四角を描画する
    CGContextSetRGBFillColor(ctx, 0.0, 1.0, 0.0, 1.0);
    CGContextFillRect(ctx, CGRectMake(0, 0, rect.size.width/2, rect.size.height/2 ));
    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
    CGContextStrokeRect(ctx, CGRectMake(rect.size.width/2, rect.size.height/2, rect.size.width/2, rect.size.height/2 ));
}
@end

@implementation DrawCircleView
- (void)drawRect:(CGRect)rect  
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(ctx, rect);
    
    // 円を描画する
    CGContextSetRGBFillColor(ctx, 0.0, 1.0, 0.0, 1.0);
    CGContextFillEllipseInRect(ctx, CGRectMake(0,0, rect.size.width/2, rect.size.height/2));
    CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
    CGContextStrokeEllipseInRect(ctx, CGRectMake(rect.size.width/2, rect.size.height/2, rect.size.width/2, rect.size.height/2));
}
@end

@implementation DrawText2View
- (void)drawRect:(CGRect)rect  
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(ctx, rect);
    
    // 文字を表示する
    NSString *s = @"masuda tomoaki";
    // CGContextSetRGBStrokeColor(ctx, 1.0, 0.0, 0.0, 1.0);
    [[UIColor blackColor] set];
    [s drawAtPoint:CGPointMake(10,50) withFont:[UIFont systemFontOfSize:20]];
    [[UIColor redColor] set];
    [s drawAtPoint:CGPointMake(10,80) withFont:[UIFont fontWithName:@"Times New Roman" size:20]];
}
@end

@implementation DrawStarView
- (void)drawRect:(CGRect)rect  
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(ctx, rect);
    
    CGPoint center = { rect.size.height/2, rect.size.width/2 };
    CGPoint pt[5];
    for ( int i=0; i<5; i++ ) {
        pt[i].x = center.x + 100 * cos(i*M_PI*2.0/5.0*2.0 + M_PI/2.0);
        pt[i].y = center.y - 100 * sin(i*M_PI*2.0/5.0*2.0 + M_PI/2.0);
    }
    
    CGContextSetRGBFillColor(ctx, 1.0, 0.0, 0.0, 1.0);
    CGContextMoveToPoint(ctx, pt[0].x, pt[0].y );
    for ( int i=0; i<5; i++ ) {
        CGContextAddLineToPoint(ctx, pt[i].x, pt[i].y );
    }
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}
@end

@implementation DrawFontView
- (void)drawRect:(CGRect)rect  
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(ctx, rect);
    
    // 文字を表示する
    NSString *s = @"masuda tomoaki";
    [[UIColor blackColor] set];
    [s drawAtPoint:CGPointMake(10,50) withFont:[UIFont fontWithName:@"Times New Roman" size:30]];
    [[UIColor redColor] set];
    [s drawInRect:CGRectMake(10, 80, 100, 20) withFont:[UIFont fontWithName:@"Times New Roman" size:30]];
    
}
@end

@implementation DrawTextShadowView
- (void)drawRect:(CGRect)rect  
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(ctx, rect);
    
    // 文字に影をつける
    NSString *s = @"masuda tomoaki";
    [[UIColor blackColor] set];
    [s drawAtPoint:CGPointMake(10,50) withFont:[UIFont systemFontOfSize:30]];
    CGContextSetShadow(ctx, CGSizeMake(4,4), 6);
    [s drawAtPoint:CGPointMake(10,90) withFont:[UIFont systemFontOfSize:30]];
    CGContextSetShadow( ctx, CGSizeMake(0,0), 0 );
    [s drawAtPoint:CGPointMake(10,140) withFont:[UIFont systemFontOfSize:30]];
}
@end

@implementation DrawTextColorView
- (void)drawRect:(CGRect)rect  
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(ctx, rect);
    
    // 文字に色をつける
    NSString *s = @"masuda tomoaki";
    [[UIColor blackColor] set];
    [s drawAtPoint:CGPointMake(10,50) withFont:[UIFont systemFontOfSize:30]];
    [[UIColor redColor] set];
    [s drawAtPoint:CGPointMake(10,100) withFont:[UIFont systemFontOfSize:30]];
    [[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0] set];
    [s drawAtPoint:CGPointMake(10,150) withFont:[UIFont systemFontOfSize:30]];
}
@end