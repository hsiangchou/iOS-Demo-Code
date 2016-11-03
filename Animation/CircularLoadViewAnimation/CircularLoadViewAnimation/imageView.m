//
//  imageView.m
//  CircularLoadViewAnimation
//
//  Created by ChouChris on 2016/11/2.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "imageView.h"

@implementation imageView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CircleLoadView *circleView = [[CircleLoadView alloc]initWithFrame:self.bounds];
        circleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
        [self addSubview:circleView];
        
        [self sd_setImageWithURL:[NSURL URLWithString:@"http://www.raywenderlich.com/wp-content/uploads/2015/02/mac-glasses.jpeg"]
                placeholderImage:nil
                         options:SDWebImageProgressiveDownload
                        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            CGFloat value = (CGFloat)receivedSize / (CGFloat)expectedSize;
                            NSLog(@"%f", value);
                            circleView.progress = value;
        }
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           NSLog(@"download the picture!");
                           [circleView reveal];
        }];
        
    }
    return self;
}

@end
