//
//  DeviceState.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@protocol DeviceStateDelegate
- (void) StateChanged;
@end

@interface DeviceState : NSObject <UIAccelerometerDelegate, CLLocationManagerDelegate> {
	float inclination;
	float azimuth;	

	CLLocationManager* locationManager;
	UIAccelerometer* accelerometerManager;
	UIAccelerationValue rollingX, rollingZ;
	
	id<DeviceStateDelegate> delegate;
}
@property (nonatomic,readonly) float inclination;
@property (nonatomic, readonly) float azimuth;
@property (nonatomic, retain) id<DeviceStateDelegate> delegate;

@end
