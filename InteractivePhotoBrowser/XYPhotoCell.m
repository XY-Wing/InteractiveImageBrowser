//
//  XYPhoto.m
//  InteractivePhotoBrowser
//
//  Created by Xue Yang on 2017/5/2.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

#import "XYPhotoCell.h"

@implementation XYPhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI
{
    _imageV = [[UIImageView alloc] init];
    _imageV.contentMode = UIViewContentModeScaleAspectFill;
    _imageV.clipsToBounds = YES;
    [self.contentView addSubview:_imageV];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageV.frame = self.contentView.bounds;
}
@end
