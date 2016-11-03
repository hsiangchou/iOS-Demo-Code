//
//  CircleLoadView.h
//  CircularLoadViewAnimation
//
//  Created by ChouChris on 2016/11/2.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLoadView : UIView<CAAnimationDelegate>

@property (nonatomic, strong)CAShapeLayer *circlePathLayer;
@property (nonatomic, assign)CGFloat circleRadius;
//下载进度
@property (nonatomic, assign)CGFloat progress;

//动画下载结束
- (void)reveal;

@end
