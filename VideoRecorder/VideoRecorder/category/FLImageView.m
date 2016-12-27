//
//  FLImage.m
//  VideoRecorder
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "FLImageView.h"

@implementation FLImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _status = ImageViewStatusDefault;
    }
    return self;
}

- (void)setDefaultImage:(UIImage *)defaultImage {
    self.image = defaultImage;
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    self.image = selectedImage;
}

- (void)setStatus:(ImageViewStatus)status {
    switch (status) {
        case ImageViewStatusDefault:
            self.image = self.defaultImage;
            break;
        case ImageViewStatusSelected:
            self.image = self.selectedImage;
            break;
        default:
            break;
    }
}

- (ImageViewStatus)getStatus:(ImageViewStatus)status {
    switch (status) {
        case ImageViewStatusDefault:
        {
            self.image = self.defaultImage;
            return ImageViewStatusDefault;
        }
            break;
        case ImageViewStatusSelected:
        {
            self.image = self.selectedImage;
            return ImageViewStatusSelected;
        }
            break;
        default:
            break;
    }
}
@end
