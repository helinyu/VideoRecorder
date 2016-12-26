//
//  NSObject+Screen.m
//  VideoRecorder
//
//  Created by felix on 2016/12/26.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "NSObject+Screen.h"

#define ScreenRect [[UIScreen mainScreen] bounds]

@implementation NSObject (Screen)

+ (BOOL)isIphone7 {

    if ((ScreenRect.size.width == 375)&&(ScreenRect.size.height == 667)) {
        return true;
    }
    return false;
}

@end
