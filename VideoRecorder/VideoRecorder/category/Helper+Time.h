//
//  Helper+Time.h
//  guimiquan
//
//  Created by Chen Rui on 11/20/14.
//  Copyright (c) 2014 Vanchu. All rights reserved.
//

#import "Helper.h"

@interface Helper (Time)

+ (void)timeSetTimeout:(float)seconds withFinishBlock:(void (^)())finishBlock;
+ (NSTimeInterval)timeNow;

@end
