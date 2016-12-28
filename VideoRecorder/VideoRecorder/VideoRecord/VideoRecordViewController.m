//
//  VideoRecordViewController.m
//  VideoRecorder
//
//  Created by felix on 2016/12/26.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "VideoRecordViewController.h"


@interface VideoRecordViewController ()<VideoRecordServiceDelegate,RecordProgressViewDelegate>
{
    CGFloat             _secondsRecorded;
    CGFloat             _secondsMax;
    NSTimer              *_timer;
}
@property (strong, nonatomic) VideoRecordService* vrService;

@property (weak, nonatomic) IBOutlet UIImageView *takeVideoImage;
@property (weak, nonatomic) IBOutlet UIView *videoRecordPlaygroundView;
@property (weak, nonatomic) IBOutlet RecordProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *choiceBtn;

@property (strong, nonatomic) NSTimer *progressTimer;
@property (assign, nonatomic) NSTimeInterval beginTime;
@property (assign, nonatomic) NSTimeInterval endTime;

@end

@implementation VideoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _secondsMax = 20.0f;
    
    _vrService = [[VideoRecordService alloc] initWithDelegate:self];
    [_vrService configureOverWholeView:self.videoRecordPlaygroundView];
    
    self.progressView.maxProgressTime = _secondsMax;
    self.progressView.minProgressTime = 2.0f;
    self.progressView.delegate = self;

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _choiceBtn.selected = false;
    _takeVideoImage.image = [UIImage imageNamed:@"btn_common_videorecorder_record"];
    [[UIApplication sharedApplication] setStatusBarHidden:true];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:true];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:false];
    }
}

// ios 10 上的方法 ,通过重写
- (BOOL)prefersStatusBarHidden{
    return true;
}

- (IBAction)onLongPressClicked:(id)sender {
    
    UIGestureRecognizer *gesture = sender;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始");
        [_vrService performRecording];
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"结束");
        [_vrService performStopRecord];
    }
}

- (IBAction)onDeleteVideoClicked:(id)sender {
    NSLog(@"delete");
}

- (IBAction)onChoiceVideoClicked:(id)sender {
    NSLog(@"choice video");
    _choiceBtn.selected = true;
    PreviewVideoViewController *pvVC = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([PreviewVideoViewController class])];
    [self.navigationController pushViewController:pvVC animated:true];
}

#pragma mark -- videoRecordServiceDelegate

- (void)viewRecordSerivce:(VideoRecordService*)service withRecordStatus:(RecordStatus)status {
    
    switch (status) {
        case RecordStatusbegan:
        {
            _takeVideoImage.image = [UIImage imageNamed:@"btn_common_videorecorder_record_select"];
            _beginTime = [[NSDate date] timeIntervalSince1970];
        }
            break;
        case RecordStatusRecording:
        {
            _takeVideoImage.image = [UIImage imageNamed:@"btn_common_videorecorder_record_select"];
            _beginTime = [[NSDate date] timeIntervalSince1970];
        }
            break;
        case RecordStatusPause:
        {
            _takeVideoImage.image = [UIImage imageNamed:@"btn_common_videorecorder_record"];
            [_progressTimer invalidate];
            _progressTimer = nil;
            _endTime = [[NSDate date] timeIntervalSince1970];
        }
            break;
        case RecordStatusEnd:
        {
            [_progressTimer invalidate];
            _progressTimer = nil;
            _endTime = [[NSDate date] timeIntervalSince1970];
        }
            break;
        default:
            break;
    }
}


#pragma mark -- delegate

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections {
    NSLog(@"didStartRecordingToOutputFileAtURL");
    
    [self.progressView startRunning];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error {
    NSLog(@"didFinishRecordingToOutputFileAtURL");
    
    [self.progressView stopRunning];
}

#pragma mark -- progressView delegate 
- (void)recordProgressRunningToEnd {
    NSLog(@"progress running to end");
    
    [self.progressView stopRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
