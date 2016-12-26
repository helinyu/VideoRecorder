//
//  VideoRecordViewController.m
//  VideoRecorder
//
//  Created by felix on 2016/12/26.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "VideoRecordViewController.h"
#import "VideoRecordService.h"

@interface VideoRecordViewController ()
@property (strong, nonatomic) VideoRecordService* vrService;

@property (weak, nonatomic) IBOutlet UIImageView *takeVideoImage;
@property (weak, nonatomic) IBOutlet UIView *videoRecordPlaygroundView;

@end

@implementation VideoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _vrService = [VideoRecordService new];
    [_vrService configureOverWholeView:self.videoRecordPlaygroundView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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

- (IBAction)onTapTakeVideoClicked:(id)sender {
    _takeVideoImage.highlighted = true;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
