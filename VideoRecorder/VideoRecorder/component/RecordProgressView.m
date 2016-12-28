//
//  RecordProgressView.m
//  guimiquan
//
//  Created by vanchu on 15/6/29.
//  Copyright (c) 2015年 Vanchu. All rights reserved.
//

#import "RecordProgressView.h"
#import "UIColor+Helper.h"
#import "Helper+Time.h"

@interface RecordProgressView()<CAAnimationDelegate>
{
    UIBezierPath    *_path;
    NSMutableArray  *_fragmentEnds;
    BOOL             _hasLayoutSubviews;
}
@property (strong, nonatomic) CAShapeLayer    *progressLayer;

@property (strong, nonatomic) CALayer         *backLayer;
@property (strong, nonatomic) NSMutableArray  *splitLayers;

@property (assign, nonatomic,readwrite) BOOL   backProgress;
@end

@implementation RecordProgressView

- (void)awakeFromNib{
    [super awakeFromNib];
    _hasLayoutSubviews = NO;
    _splitLayers = [NSMutableArray new];
    _fragmentEnds  = [NSMutableArray new];
    [_fragmentEnds addObject:@(0)];
    self.secondsRemained = self.maxProgressTime;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//        渲染完成之后才知道进度条长度
    if (!_hasLayoutSubviews) {
        [self drawPath];
        [self addProgressLayer];
        [self addMinRecordSignLayer];
        _hasLayoutSubviews = YES;
    }
}

- (void)startRunning{
//    如果处于准备删除状态
    if (self.backProgress == YES && _backLayer) {
        [_backLayer removeFromSuperlayer];
        _backLayer = nil;
        self.backProgress = NO;
    }
    
    CGFloat duration = self.secondsRemained;//self.maxProgressTime * (1.0f - _progressLayer.strokeEnd);
    CGFloat strokeEndFinal = 1.0f;
    
    CABasicAnimation *strokeEndAnimation = nil;
    strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = duration;
    strokeEndAnimation.fromValue = @(_progressLayer.strokeEnd);
    strokeEndAnimation.toValue = @(strokeEndFinal);
    strokeEndAnimation.autoreverses = NO;
    strokeEndAnimation.repeatCount = 0.0f;
    strokeEndAnimation.delegate = self;
    
    [_progressLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
}

- (void)stopRunning{
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    _progressLayer.strokeEnd = [_progressLayer.presentationLayer strokeEnd]+0.003;//0.003是因为此时动画还没移除，下面一行才移除
    [_progressLayer removeAnimationForKey:@"strokeEndAnimation"];
    
    if (_progressLayer.strokeEnd >=1.0f) {
        return;
    }
//    加间断点
    CGFloat currentProgress = CGRectGetWidth(self.frame) * _progressLayer.strokeEnd;

    CALayer *splitLayer = nil;
    splitLayer = [CALayer layer];
//    splitLayer.anchorPoint = CGPointMake(0, 0.5);
    splitLayer.bounds = CGRectMake(0, 0, 1, CGRectGetHeight(self.frame));
    splitLayer.position = CGPointMake(currentProgress+0.5, CGRectGetMidY(self.frame));
    splitLayer.backgroundColor = [[UIColor colorWithHex:0xf3f3f3] CGColor];
    [_progressLayer addSublayer:splitLayer];
    
    [_splitLayers addObject:splitLayer];
    
    [_fragmentEnds addObject:@(currentProgress+1)];
}

- (void)willBackProgress{
    NSInteger count = _fragmentEnds.count;
    if (count<2) {
        return;
    }
    _backProgress = YES;
    
    CGFloat endPoint = [_fragmentEnds[count-1] floatValue];
    CGFloat startPoint = [_fragmentEnds[count-2] floatValue];
    
    CALayer *backLayer = [CALayer layer];
    backLayer.bounds = CGRectMake(0, 0, (endPoint-startPoint), CGRectGetHeight(self.frame));
    backLayer.position = CGPointMake((startPoint+endPoint)/2.0f, CGRectGetMidY(self.frame));
    backLayer.backgroundColor = [[UIColor colorWithHex:0xff5e5e] CGColor];
    [_progressLayer addSublayer:backLayer];
    
    _backLayer = backLayer;
    
}

- (void)didBackProgress{
    if (!_backLayer) {
        return;
    }
    
    _backProgress = NO;
    
    CALayer *splitLayer = [_splitLayers lastObject];
    if (splitLayer) {
        [splitLayer removeFromSuperlayer];
        [_splitLayers removeLastObject];
    }
    
    [_backLayer removeFromSuperlayer];
    _backLayer = nil;
    
    [_fragmentEnds removeLastObject];
//    点转化为strokend
    CGFloat lastPoint = [[_fragmentEnds lastObject] floatValue];
    CGFloat lastStrokEnd = (lastPoint-1)/CGRectGetWidth(self.frame);
    _progressLayer.strokeEnd = lastStrokEnd;
    
}
- (void)cancelCurrentProgress{
    [_progressLayer removeAnimationForKey:@"strokeEndAnimation"];
}

#pragma mark - private func
- (void)drawPath{
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(0, CGRectGetMidY(self.frame))];
    [_path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetMidY(self.frame))];
}

- (void)addProgressLayer{
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.path = _path.CGPath;
    progressLayer.strokeColor = [[UIColor redColor] CGColor];
    progressLayer.fillColor = [[UIColor clearColor] CGColor];
    progressLayer.lineWidth = CGRectGetHeight(self.frame);
    progressLayer.strokeEnd = 0.0f;
    
    [self.layer addSublayer:progressLayer];
    
    _progressLayer = progressLayer;
}

- (void)addMinRecordSignLayer{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [[UIColor redColor] CGColor];
    layer.position = CGPointMake(CGRectGetWidth(self.frame) * self.minProgressTime/self.maxProgressTime, CGRectGetMidY(self.frame)) ;
    layer.bounds   = CGRectMake(0, 0, 1, CGRectGetHeight(self.frame));
    [self.layer addSublayer:layer];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        //        关闭隐藏动画
        [CATransaction setDisableActions:YES];
        self.progressLayer.strokeEnd = 1.0f;
        [CATransaction setDisableActions:NO];
        
        [_fragmentEnds addObject:@(CGRectGetWidth(self.frame))];
        [_splitLayers addObject:[CALayer layer]];
        
        if (_delegate && [_delegate respondsToSelector:@selector(recordProgressRunningToEnd)]) {
            [_delegate recordProgressRunningToEnd];
        }
    }
}

- (CGFloat)currentProgress{
    return [self.progressLayer.presentationLayer strokeEnd];
}

@end
