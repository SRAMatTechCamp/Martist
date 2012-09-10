//
//  Vector2D.h
//
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <Foundation/Foundation.h>

@interface Vector2D : NSObject {
	float x;
	float y;
}
- (id) initWithX:(float)X Y:(float)Y;
- (float)getSquareLength;
- (Vector2D*)unitVector;
- (float)dotProduct:(Vector2D*)a;
@property (nonatomic) float x;
@property (nonatomic) float y;
@end