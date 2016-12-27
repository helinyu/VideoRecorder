//
//  PreviewVideoViewController.m
//  VideoRecorder
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "PreviewVideoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PreviewVideoViewController ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation PreviewVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.navigationController) {
        self.navigationItem.title = @"录制视频预览";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
