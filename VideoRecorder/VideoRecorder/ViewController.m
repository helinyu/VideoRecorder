//
//  ViewController.m
//  VideoRecorder
//
//  Created by felix on 2016/12/26.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ViewController.h"
#import "VideoRecordViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)onRecordVideoClicked:(id)sender {
    VideoRecordViewController *VRVC = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([VideoRecordViewController class])];
    [self.navigationController pushViewController:VRVC animated:true];
//    [self presentViewController:VRVC animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
