//
//  ProgressView.h
//  VideoRecorder
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProgressView : UIView

@property (assign, nonatomic) NSTimeInterval wholeTime;
@property (assign, nonatomic) CGFloat screenWidth;

- (void)startRunning;
- (void)stopRunning;
- (void)endRunning;

@end
