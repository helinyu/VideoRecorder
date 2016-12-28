//
//  UIColor+Helper.m
//  guimiquan
//
//  Created by Chen Rui on 11/13/14.
//  Copyright (c) 2014 Vanchu. All rights reserved.
//

#import "UIColor+Helper.h"

@implementation UIColor (Helper)

+ (UIColor *)colorWithHex:(NSInteger)hex {
	return [UIColor colorWithHex:hex andAlpha:1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)hex andAlpha:(float)alpha {
	return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
						   green:((float)((hex & 0xFF00) >> 8)) / 255.0
							blue:((float)(hex & 0xFF)) / 255.0
						   alpha:alpha];
}

@end
