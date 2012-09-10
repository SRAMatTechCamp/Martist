//	
//  graphicUtil.h
//	
//  Copyright (C) 2012 Yahoo Japan Corporation. All Rights Reserved.
//
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

void drawRectangle(float x, float y, float width, float height, int red, int green, int blue, int alpha);
void drawTriangle(const float x1, const float y1, const float x2, const float y2, const float x3, const float y3, float r, float g, float b, float a);