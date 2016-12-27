//
//  FLImage.h
//  VideoRecorder
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageViewStatus) {
    ImageViewStatusDefault = 1,
    ImageViewStatusSelected = 1 < 1
};

IB_DESIGNABLE
@interface FLImageView : UIImageView
@property (assign, nonatomic) IBInspectable ImageViewStatus status;
@property (strong, nonatomic) IBInspectable UIImage * defaultImage;
@property (strong, nonatomic) IBInspectable UIImage *selectedImage;
@end
