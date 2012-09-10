//
//  ViewController.m
//  DrawRainbow
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

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

/*- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // 背景色を透明に
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}*/

/**
 * UIViewを描画する時に呼ばれる
 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // ６色
    UIColor *colors[6] = {
        UIColor.redColor,
        UIColor.orangeColor,
        UIColor.yellowColor,
        UIColor.greenColor,
        UIColor.blueColor,
        UIColor.purpleColor,
    };
    
    CGRect r = self.bounds;
    int width = 20;
    int offset = 10;
    
    // コンテキストをゲット
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 線の幅を設定
    CGContextSetLineWidth(context, width);
    for (int i = 0; i < 6; i++) {
        // 線の色を設定
        CGContextSetStrokeColorWithColor(context, colors[i].CGColor);
        // 書き出し位置に移動
        CGContextMoveToPoint(context, offset, r.size.height);
        // 弧の位置を設定
        CGContextAddArcToPoint(context, offset, offset, r.size.width, offset, r.size.width - offset);
        // パスを描画
        CGContextStrokePath(context);
        offset += width;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
