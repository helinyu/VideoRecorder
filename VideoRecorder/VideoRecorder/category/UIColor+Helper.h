//
//  UIColor+Helper.h
//  guimiquan
//
//  Created by Chen Rui on 11/13/14.
//  Copyright (c) 2014 Vanchu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB16(v) [UIColor colorWithRed:((float)((v & 0xFF0000) >> 16))/255.0 green:((float)((v & 0xFF00) >> 8))/255.0 blue:((float)(v & 0xFF))/255.0 alpha:1.0]
#define RGB16A(v,a) [UIColor colorWithRed:((float)((v & 0xFF0000) >> 16))/255.0 green:((float)((v & 0xFF00) >> 8))/255.0 blue:((float)(v & 0xFF))/255.0 alpha:a]

@interface UIColor (Helper)

+ (UIColor *)colorWithHex:(NSInteger)hex;
+ (UIColor *)colorWithHex:(NSInteger)hex andAlpha:(float)alpha;

@end
