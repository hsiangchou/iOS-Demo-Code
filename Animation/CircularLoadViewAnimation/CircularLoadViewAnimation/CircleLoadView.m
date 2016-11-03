//
//  CircleLoadView.m
//  CircularLoadViewAnimation
//
//  Created by ChouChris on 2016/11/2.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "CircleLoadView.h"

@implementation CircleLoadView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    self.circleRadius = 20.0;
    
    self.circlePathLayer = [CAShapeLayer layer];
    self.circlePathLayer.strokeColor = [UIColor redColor].CGColor;
    self.circlePathLayer.fillColor = [UIColor clearColor].CGColor;
    self.circlePathLayer.lineWidth = 2;

    [self.layer addSublayer:self.circlePathLayer];
    self.backgroundColor = [UIColor whiteColor];
    self.progress = 0;
}

- (CGRect)circleFrame
{
    CGRect rect = CGRectMake(0, 0, 2*self.circleRadius, 2*self.circleRadius);
    rect.origin.x = CGRectGetMidX(self.bounds) - CGRectGetMidX(rect);
    rect.origin.y = CGRectGetMidY(self.bounds) - CGRectGetMidY(rect);
    return rect;
}

- (CGPathRef)circlePath
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:[self circleFrame]];
    return path.CGPath;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.circlePathLayer.frame = self.bounds;
    self.circlePathLayer.path = [self circlePath];
}

- (void)setProgress:(CGFloat)progress
{
    if (progress > 1) 
        self.circlePathLayer.strokeEnd = 1;
    else if (progress < 0)
        self.circlePathLayer.strokeEnd = 0;
    else
        self.circlePathLayer.strokeEnd = progress;
}

//动画下载结束
- (void)reveal
{
    self.backgroundColor = [UIColor clearColor];
    self.progress = 1;
    
    [self.circlePathLayer removeAnimationForKey:@"strokeEnd"];
    [self.circlePathLayer removeFromSuperlayer];
    
    self.superview.layer.mask = self.circlePathLayer;
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat finalRadius = sqrt(center.x*center.x + center.y*center.y);
    CGFloat radiusInset = finalRadius - self.circleRadius;
    CGRect outerRect = CGRectInset([self circleFrame], -radiusInset, -radiusInset);
    CGPathRef toPath = [UIBezierPath bezierPathWithOvalInRect:outerRect].CGPath;
    
    CGPathRef fromPath = self.circlePathLayer.path;
    CGFloat fromeLineWidth = self.circlePathLayer.lineWidth;

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction commit];

    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAnimation.fromValue = [NSNumber numberWithFloat:fromeLineWidth];
    lineWidthAnimation.toValue = [NSNumber numberWithFloat:2*finalRadius];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(fromPath);
    pathAnimation.toValue = (__bridge id _Nullable)(toPath);
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 2.0;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.animations = @[lineWidthAnimation, pathAnimation];
    groupAnimation.delegate = self;
    [self.circlePathLayer addAnimation:groupAnimation forKey:@"strokeWidth"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.superview.layer.mask = nil;
}

@end
