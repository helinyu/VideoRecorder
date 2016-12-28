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
#import "RecordProgressView.h"
#import "VideoRecordViewController.h"

@class VideoRecordService;

typedef NS_ENUM(NSUInteger, RecordStatus) {
    RecordStatusbegan = 1,
    RecordStatusRecording = 1 << 1,
    RecordStatusPause = 1 << 2,
    RecordStatusEnd = 1 << 3,
};

@protocol VideoRecordServiceDelegate <NSObject>

- (void)viewRecordSerivce:(VideoRecordService*)service withRecordStatus:(RecordStatus)status;

@end

@interface VideoRecordService : NSObject
- (instancetype)initWithDelegate:(id<VideoRecordServiceDelegate>)recordServiceDelegate;

@property (weak,nonatomic) id<VideoRecordServiceDelegate> recordServiceDelegate;

- (void)configureOverWholeView:(UIView *)view ;

- (void)configureOverView:(UIView *)view withViewFrame:(CGRect)rect;

//录制内容
- (void)performRecording;

//停止录制
- (void)performStopRecord;

@end
