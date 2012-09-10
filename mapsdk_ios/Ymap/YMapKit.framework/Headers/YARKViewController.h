//
//  YARKViewController.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "EAGLView.h"
#import <CoreLocation/CoreLocation.h>
#import "ARPoint.h"
#import "NavigationMgr.h"
#import "SubmapView.h"
#import "POIView.h"

@interface YARKViewController : UIViewController <NavigationMgrDelegate, YMKMapViewDelegate, POIViewDelegate> {	
	NavigationMgr* nm;
	UIImagePickerController *cameraController;
	
	EAGLView *ar_overlayView;
	EAGLContext *context;
	BOOL animating;
	NSInteger animationFrameInterval;
	CADisplayLink *displayLink;
	SubmapView* submap;
	UIImage* gpsIcon;
	
	int arrowA;
	int arrowR;
	int arrowG;
	int arrowB;
	POIView* poiView;
	
	BOOL _visible;
}

- (void) setCurrentPos:(CLLocation*)loc;
@property (nonatomic, readonly) float inclination;
@property (nonatomic, readonly) float azimuth;

@property (nonatomic) int arrowA;
@property (nonatomic) int arrowR;
@property (nonatomic) int arrowG;
@property (nonatomic) int arrowB;

- (int) addPOI:(double) lat :(double) lon :(UIImage*) icon :(int) x :(int) y;
- (void) removePOI:(int) index;
- (void) clearPOI;
- (void) setDestination:(int) index;
- (void) setRoute:(NSArray*) route;
- (void) setRoute:(CLLocationCoordinate2D*) route Count:(int) cnt;
+ (BOOL) arViewControllerAvailable;
- (BOOL) hide;
- (void) addView:(UIView*)value;
@end
