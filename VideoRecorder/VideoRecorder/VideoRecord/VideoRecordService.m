//
//  VideoRecord.m
//  VideoRecorder
//
//  Created by felix on 2016/12/26.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "VideoRecordService.h"



@interface VideoRecordService ()<AVCaptureFileOutputRecordingDelegate>

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureMovieFileOutput * captureMovieFileOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (strong, nonatomic) NSMutableArray *recordTimes;

@end

@implementation VideoRecordService

- (instancetype)initWithDelegate:(id<VideoRecordServiceDelegate>)recordServiceDelegate{
   self = [self init];
    if (self) {
        self.recordServiceDelegate = recordServiceDelegate;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _recordTimes = [NSMutableArray new];
        
        //初始化会话
        _captureSession = [AVCaptureSession new];
        if ([_captureSession canSetSessionPreset:AVCaptureSessionPresetMedium]) {
            [_captureSession setSessionPreset:AVCaptureSessionPresetMedium];
        }

        //获取摄像头
        AVCaptureDevice *videoCaptureDevice = [self _getCameraDeviceWithPosition:AVCaptureDevicePositionBack];
        if (!videoCaptureDevice) {
            videoCaptureDevice = [self _getCameraDeviceWithPosition:AVCaptureDevicePositionFront];
        }
        if (!videoCaptureDevice) {
            NSLog(@"摄像头不可以使用，请设置");
            return nil;
        }
        
        // 添加视频摄像头 输入
        NSError *error = nil;
        AVCaptureDeviceInput *videoCaptureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:videoCaptureDevice error:&error];
        if (!videoCaptureDeviceInput) {
            NSLog(@"添加视屏的摄像头失败");
            return nil;
        }
        
        //添加音频输入设备
        AVCaptureDevice *audioCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        if (!audioCaptureDevice) {
            NSLog(@"获取音频视频出现了错误");
            return nil;
        }
        
        // 添加音频输入 设备
       AVCaptureDeviceInput* audioCaptureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioCaptureDevice error:&error];
        if (error) {
            NSLog(@"配置音频设备输入出现错误");
            return nil;
        }
        
        //添加输出 设备 --- 配置输出设备
        _captureMovieFileOutput = [AVCaptureMovieFileOutput new];
        if ([_captureSession canAddInput:videoCaptureDeviceInput]) {
            [_captureSession addInput:videoCaptureDeviceInput];
            [_captureSession addInput:audioCaptureDeviceInput];
            AVCaptureConnection *captureConnection = [_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
            if ([captureConnection isVideoStabilizationSupported]) {
                captureConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
            }
        }
        
        // 将输出设备添加到会话中
        if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
            [_captureSession addOutput:_captureMovieFileOutput];
        }
        
        self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];

        [_captureSession startRunning];
        
    }
    return self;
}

- (AVCaptureDevice *)_getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

- (void)configureOverWholeView:(UIView *)view {
    [self configureOverView:view withViewFrame:CGRectZero];
}

- (void)configureOverView:(UIView *)view withViewFrame:(CGRect)rect {
    CGRectEqualToRect(rect,CGRectZero)?(self.captureVideoPreviewLayer.frame = view.bounds):(self.captureVideoPreviewLayer.frame = rect);
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [view.layer addSublayer:self.captureVideoPreviewLayer];
}

- (void)dealloc{
    _captureSession = nil;
    _captureMovieFileOutput = nil;
    [_captureSession stopRunning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)performRecording {
    NSString *outputFielPath=[NSTemporaryDirectory() stringByAppendingString:@"test.mp4"];
    NSLog(@"save path is :%@",outputFielPath);
    NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
    [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
    
    if (_recordTimes.count > 0) {
        // 刻录状态
        if ([self.recordServiceDelegate respondsToSelector:@selector(viewRecordSerivce:withRecordStatus:)]) {
            [self.recordServiceDelegate viewRecordSerivce:self withRecordStatus:RecordStatusRecording];
        }
    }else {
        if ([self.recordServiceDelegate respondsToSelector:@selector(viewRecordSerivce:withRecordStatus:)]) {
            [self.recordServiceDelegate viewRecordSerivce:self withRecordStatus:RecordStatusbegan];
        }
    }
    
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    [_recordTimes addObject:@(currentTime)];

}

- (void)performStopRecord {
    if ([self.recordServiceDelegate respondsToSelector:@selector(viewRecordSerivce:withRecordStatus:)]) {
        [self.recordServiceDelegate viewRecordSerivce:self withRecordStatus:RecordStatusPause];
    }
    [self.captureMovieFileOutput stopRecording];
}

#pragma mark -- delegate

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections {
    NSLog(@"didStartRecordingToOutputFileAtURL");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error {
    NSLog(@"didFinishRecordingToOutputFileAtURL");
}

@end
