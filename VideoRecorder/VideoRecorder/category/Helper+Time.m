//
//  Helper+Time.m
//  guimiquan
//
//  Created by Chen Rui on 11/20/14.
//  Copyright (c) 2014 Vanchu. All rights reserved.
//

#import "Helper+Time.h"

@implementation Helper (Time)

+ (void)timeSetTimeout:(float)seconds withFinishBlock:(void (^)())finishBlock {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), finishBlock);
}

+ (NSTimeInterval)timeNow {
	return [NSDate date].timeIntervalSince1970;
}

@end
