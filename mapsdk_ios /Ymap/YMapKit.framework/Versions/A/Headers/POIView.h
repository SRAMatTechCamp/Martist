//
//  POIView.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationMgr.h"

@protocol POIViewDelegate;

@interface POIView : UIView {
	NavigationMgr* naviMgr;
	id<POIViewDelegate> delegate;
}
@property (nonatomic, retain) NavigationMgr* naviMgr;
@property (nonatomic, retain) id<POIViewDelegate> delegate;
- (void) updateLocation;
@end

@protocol POIViewDelegate
- (void) poiView:(POIView*)poiView onPick:(int)index;
@end