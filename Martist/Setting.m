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
@synthesize writeStar;
@synthesize saveToCamera;
@synthesize getImageAddress;
@synthesize putImage;
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
    [self setWriteStar:nil];
    [self setSaveToCamera:nil];
    [self setGetImageAddress:nil];
    [self setPutImage:nil];
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

- (IBAction)setStar:(id)sender{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    app.getStar = TRUE;
}

- (IBAction)saveCamera:(id)sender{
    if([[saveToCamera currentTitle] isEqualToString:@"カメラロールに保存：なし"]){
        [saveToCamera setTitle:@"カメラロールに保存：あり" forState:UIControlStateNormal];
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        app.CameraFlag = TRUE;
    }else{
        [saveToCamera setTitle:@"カメラロールに保存：なし" forState:UIControlStateNormal];
        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        app.CameraFlag = FALSE;
    }
    
}

- (IBAction)getImgAdress:(id)sender{
    if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ){
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [ipc setDelegate:self];
        [ipc setAllowsEditing:YES];
        [self presentModalViewController:ipc animated:YES];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    [self dismissModalViewControllerAnimated:YES];
    
    [picker dismissModalViewControllerAnimated:YES];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    app.image = image;
    
    NSURL *url = [editingInfo objectForKey:UIImagePickerControllerReferenceURL];
    
    [getImageAddress setTitle:@"画像選択中" forState:UIControlStateNormal];
    
	NSLog(@"query : %@", [url query]);
    
}

- (IBAction)putImg:(id)sender{
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if(putImage.on == TRUE){
        NSLog(@"aaaaa");
        app.setImage = TRUE;
        app.imageSet = FALSE;
    }else{
        app.setImage = FALSE;
    }
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
