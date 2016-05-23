//
//  MySliderSwitch.m
//  niaoRen
//
//  Created by MAC OS on 16/4/26.
//  Copyright © 2016年 Chengdu CZM out information co., LTD. All rights reserved.
//

#import "MySliderSwitch.h"

#define OFFSET 3

@interface MySliderSwitch () {
    CGPoint beginPoint;
    CGRect moveFrame;
}

@end

@implementation MySliderSwitch

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        img.image = [UIImage imageNamed:@"guiji_21.png"];
        img.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        [self addSubview:img];
        
        self.backGrondImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 10, frame.size.height - 10)];
        self.backGrondImg.image = [UIImage imageNamed:@"guiji_11"];
        self.backGrondImg.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        [self addSubview:self.backGrondImg];
        
        _upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height / 2)];
        _upLabel.font = [UIFont systemFontOfSize:9];
        _upLabel.text = @" 记录中";
        _upLabel.textColor = [UIColor whiteColor];
        _upLabel.textAlignment = NSTextAlignmentCenter;
        _upLabel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height  / 4 + 1);
        _upLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *upTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upTapAction)];
        [_upLabel addGestureRecognizer:upTap];
        [self addSubview:_upLabel];
        
        _downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 2, frame.size.width, frame.size.height / 2)];
        _downLabel.font = [UIFont systemFontOfSize:9];
        _downLabel.numberOfLines = 2;
        _downLabel.text = @" 开始\n 记录";
        _downLabel.textColor = [UIColor whiteColor];
        _downLabel.textAlignment = NSTextAlignmentCenter;
        _downLabel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height * 3 / 4 - 2);
        _downLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *downTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downTapAction)];
        [_downLabel addGestureRecognizer:downTap];
        
        [self addSubview:_downLabel];
        
        _button = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 12, frame.size.width - 12)];
        _button.image = [UIImage imageNamed:@"guiji_22"];
        
        _button.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 4 + OFFSET);
        _button.userInteractionEnabled = YES;

        [self addSubview:_button];
    }
    
    return self;
}

- (void)downTapAction {
    
    if (_isRecored) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        [_button setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height * 3 / 4 - OFFSET)];
    }completion:^(BOOL finished) {
//        _backGrondImg.image = [UIImage imageNamed:@"guiji_00"];
        [self.delegate didSelectAtIndex:1];
    }];
}

- (void)upTapAction {
    if (!_isRecored) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        [_button setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 4 + OFFSET)];
    }completion:^(BOOL finished) {
//        _backGrondImg.image = [UIImage imageNamed:@"guiji_11"];
        [self.delegate didSelectAtIndex:0];
    }];

}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSEnumerator *reverseE = [self.subviews reverseObjectEnumerator];
    UIView *iSubView;
    
    while ((iSubView = [reverseE nextObject])) {
        
        UIView *viewWasHit = [iSubView hitTest:[self convertPoint:point toView:iSubView] withEvent:event];
        if(viewWasHit) {
            return viewWasHit;
        }
        
    }
    return [super hitTest:point withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _lastFrame = [_button frame];
    beginPoint = [[touches anyObject] locationInView:_button];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    moveFrame = [_button frame];
    
    moveFrame.origin.y = pt.y;
    
    if ((moveFrame.origin.y > 0) && (moveFrame.origin.y < self.frame.size.height - moveFrame.size.height)) {
        
        if (moveFrame.origin.y < self.frame.size.height / 4 + OFFSET) {
            [UIView animateWithDuration:0.5 animations:^{
                [_button setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 4 + OFFSET)];
            }completion:^(BOOL finished) {
                
            }];
        }
        if (moveFrame.origin.y > self.frame.size.height  / 4 + OFFSET) {
            [UIView animateWithDuration:0.5 animations:^{
                [_button setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height * 3 / 4 - OFFSET)];
            }completion:^(BOOL finished) {

            }];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_button.center.y == self.frame.size.height / 4 + OFFSET) {
        if (!_isRecored) {
            return;
        }
        [self.delegate didSelectAtIndex:0];

    }
    if (_button.center.y == self.frame.size.height * 3 / 4 - OFFSET) {
        if (_isRecored) {
            return;
        }
        [self.delegate didSelectAtIndex:1];

    }
}

- (void)cancelClick {
    [UIView animateWithDuration:0.5 animations:^{
        [_button setFrame:_lastFrame];
    } completion:^(BOOL finished) {
        if (_button.center.y == self.frame.size.height * 3 / 4 - OFFSET) {
            _backGrondImg.image = [UIImage imageNamed:@"guiji_00"];
        }
        if (_button.center.y == self.frame.size.height  / 4 + OFFSET) {
            _backGrondImg.image = [UIImage imageNamed:@"guiji_11"];
        }
    }];
}

#pragma  mark 废弃

- (void)finishDragButton:(UIButton *)button withEvent:(UIEvent *)event {
    NSLog(@"%@",NSStringFromCGRect(button.frame));
    CGFloat diff1 = fabs(button.center.y - self.frame.size.height / 4);
    CGFloat diff2 = fabs(button.center.y - self.frame.size.height * 3 / 4);
    if (diff1 == diff2) {
        [UIView animateWithDuration:0.5 animations:^{
            [button setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 4)];
        }completion:^(BOOL finished) {
            
        }];
    }
    if (diff1 > diff2) {
        [UIView animateWithDuration:0.5 animations:^{
            [button setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height * 3 / 4)];
        }completion:^(BOOL finished) {
            
        }];
    }
    if (diff1 < diff2) {
        [UIView animateWithDuration:0.5 animations:^{
            [button setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 4)];
        }completion:^(BOOL finished) {
            
        }];
    }
}

- (void)dragButton:(UIButton *)button withEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:button] anyObject];
    
    // get delta
    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    CGFloat delta_y = location.y - previousLocation.y;
    
    // move button on Y axis
    button.center = CGPointMake(button.center.x ,
                                button.center.y +delta_y);
    if (button.frame.origin.y > self.frame.size.height / 4) {
        [button setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height * 3 / 4)];
        [self.delegate didSelectAtIndex:1];
    }
    if (button.frame.origin.y < self.frame.size.height / 4) {
        [button setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height  / 4)];
        [self.delegate didSelectAtIndex:0];
    }
    
}

@end
