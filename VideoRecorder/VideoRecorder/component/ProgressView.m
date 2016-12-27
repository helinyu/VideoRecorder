//
//  ProgressView.m
//  VideoRecorder
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView()
@property (assign, nonatomic) NSLayoutConstraint *widthLayoutConstraint;
@property (assign, nonatomic)  float progressRate;

@property (strong, nonatomic) NSMutableArray *cacheLayers;

@end

@implementation ProgressView

- (void)setWholeTime:(NSTimeInterval)wholeTime {
    if (_screenWidth <= 0) {
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
    }
    _progressRate = _screenWidth / _progressRate;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)startRunning {
    
}

- (void)stopRunning {
    
}

- (void)endRunning {
    
}

@end
