//
//  TestViewController1.h
//  ChangeViewByAnimation
//
//  Created by 三浦 蘭斗 on 12/09/07.
//  Copyright (c) 2012年 神戸大学. All rights reserved.
//

#import "TestViewController2.h"

@interface TestViewController1 : UIViewController 

//アラート表示用ボタンのアウトレットも忘れずに
- (IBAction)alertTest;

//アラート表示
- (IBAction)alertTest{
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"画面遷移テスト"
                          message:@"TestViewController2に¥n画面遷移します"
                          delegate:self 
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

//ボタン押下時の処理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //遷移先ViewControllerクラスのインスタンス生成
    TestViewController2 *testVC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"testVC2"];//手順1で付けた名前
    
    switch (buttonIndex) {
        case 0://押したボタンがCancelなら何もしない
            break;
            
        case 1://押したボタンがOKなら画面遷移
            [self presentModalViewController:testVC2 animated:YES ];
            break;
            
    }
}
