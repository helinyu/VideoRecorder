//
//  RecordProgressView.h
//  guimiquan
//
//  Created by vanchu on 15/6/29.
//  Copyright (c) 2015年 Vanchu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol   RecordProgressViewDelegate<NSObject>
@required
- (void)recordProgressRunningToEnd;
@end

@interface RecordProgressView : UIView

// 标示下一步点击回退按钮是否的确回退
@property (assign, nonatomic, readonly)   BOOL  backProgress;
@property (assign, nonatomic)          CGFloat  maxProgressTime;
@property (assign, nonatomic)          CGFloat  minProgressTime;
@property (assign, nonatomic)          CGFloat  secondsRemained;
/**
 @brief 当前进度，0.0f~1.0f
*/
@property (assign, nonatomic, readonly)CGFloat  currentProgress;

@property (weak, nonatomic) id<RecordProgressViewDelegate> delegate;


- (void)startRunning;
- (void)stopRunning;
- (void)willBackProgress;
- (void)didBackProgress;
- (void)cancelCurrentProgress;
@end
