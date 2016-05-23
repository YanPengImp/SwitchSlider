//
//  MySliderSwitch.h
//  niaoRen
//
//  Created by MAC OS on 16/4/26.
//  Copyright © 2016年 Chengdu CZM out information co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Cancel)(void);

@protocol MySliderSwitchDelegate <NSObject>

- (void)didSelectAtIndex:(NSInteger)index;

@end

@interface MySliderSwitch : UIView

//背景
@property (nonatomic, strong) UIImageView *backGrondImg;
//上方label
@property (nonatomic, strong) UILabel *upLabel;
//下方label
@property (nonatomic, strong) UILabel *downLabel;
//滑动按钮
@property (nonatomic, strong) UIImageView *button;
@property (nonatomic, assign) id <MySliderSwitchDelegate> delegate;
//是否记录中
@property (nonatomic, assign) BOOL isRecored;
//点击了取消block
@property (nonatomic, copy) Cancel cancel;
//保存上一次的frame
@property (nonatomic, assign) CGRect lastFrame;

- (void)cancelClick;

@end
