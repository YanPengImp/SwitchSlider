//
//  ViewController.m
//  SwitchSliderDemo
//
//  Created by MAC OS on 16/5/23.
//  Copyright © 2016年 niaoren information technology co., LTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <MySliderSwitchDelegate,UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mySlider];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (MySliderSwitch *)mySlider {
    if (!_mySlider) {
        _mySlider = [[MySliderSwitch alloc] initWithFrame:CGRectMake(0, 0, 70, 120)];
        _mySlider.center = self.view.center;
        _mySlider.delegate = self;
        _mySlider.isRecored = NO;
    }
    
    return _mySlider;
}

#pragma mark MySliderSwitchDelegate

- (void)didSelectAtIndex:(NSInteger)index {
    if (index == 0) {
        _mySlider.backGrondImg.image = [UIImage imageNamed:@"guiji_11"];
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否结束记录轨迹！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        
        alertView.tag = 2;
        
        [alertView show];
        
    }
    if (index == 1) {
        _mySlider.backGrondImg.image = [UIImage imageNamed:@"guiji_00"];
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否开始记录轨迹！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        
        alertView.tag = 1;
        
        [alertView show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        [_mySlider cancelClick];
        return;
    }
    _mySlider.isRecored = alertView.tag > 1 ? NO : YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
