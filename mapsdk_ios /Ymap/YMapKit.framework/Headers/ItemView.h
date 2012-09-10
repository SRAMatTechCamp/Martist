//
//  ItemView.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <UIKit/UIKit.h>
@class MapDoc;

#define ITEM_ICON 1
#define ITEM_TAB 2
#define ITEM_POLYLINE 3
#define ITEM_USER 100
#define MIN_LEVEL 1
#define TAB_LEVEL 100
#define ICON_LEVEL 1000
#define POLYLINE_LEVEL 10000
#define LABEL_LEVEL 50000
#define MAX_LEVEL 100000
#define ACT_TABDRAW	1
#define STATE_OFF 0
#define STATE_ON 1

@interface ItemView : UIView {
	int state;
	id item;		
	int actflag;
	
	double dx;
	double dy;
}
@property (nonatomic, readonly) id item;

- (void)resetPos:(CGRect)frame :(id)md;

- (id)hitItem:(CGPoint)point;

- (void) move:(double)x :(double)y;

- (int)timerEvent:(NSTimer *)sender;

- (int)getLevel;

- (int)getItemType;

- (void)resetState;

@end
