//
//  ViewController.m
//  CircularLoadViewAnimation
//
//  Created by ChouChris on 2016/11/2.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.img = [[imageView alloc]initWithFrame:CGRectInset(self.view.bounds, 20, 250)];
    [self.view addSubview:self.img];
    
}


@end
