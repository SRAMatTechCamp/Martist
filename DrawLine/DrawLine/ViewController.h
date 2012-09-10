//
//  ViewController.h
//  DrawLine
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UIView *sampleView;
}
- (IBAction)clickLine:(id)sender;
- (IBAction)clickRect:(id)sender;
- (IBAction)clickCircle:(id)sender;
- (IBAction)clickText:(id)sender;
- (IBAction)clickStar:(id)sender;
- (IBAction)clickFont:(id)sender;
- (IBAction)clickTextShadow:(id)sender;
- (IBAction)clickTextColor:(id)sender;


@end

@interface DrawLineView : UIView 

@end
@interface DrawRect2View : UIView 

@end
@interface DrawCircleView : UIView 

@end
@interface DrawText2View : UIView 

@end
@interface DrawStarView : UIView 

@end
@interface DrawFontView : UIView 

@end
@interface DrawTextShadowView : UIView 

@end
@interface DrawTextColorView : UIView 

@end