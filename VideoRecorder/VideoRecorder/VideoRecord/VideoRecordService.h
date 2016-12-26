//
//  VideoRecord.h
//  VideoRecorder
//
//  Created by felix on 2016/12/26.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoRecordService : NSObject

- (void)configureOverWholeView:(UIView *)view ;

- (void)configureOverView:(UIView *)view withViewFrame:(CGRect)rect;

@end
