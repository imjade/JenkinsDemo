//
//  AnimateButton.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/25.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "AnimateButton.h"
@interface AnimateButton()
@property (nonatomic,strong) CAShapeLayer *cicleShapeLayer;
@property (nonatomic,weak) NSTimer *timer;
@end
const CGFloat duration = 1.2f;
@implementation AnimateButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (CAShapeLayer *)cicleShapeLayer
{
    
    
    if (!_cicleShapeLayer) {
        //创建出CAShapeLayer
        _cicleShapeLayer = [CAShapeLayer layer];
        _cicleShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
        //设置线条的宽度和颜色
        _cicleShapeLayer.lineWidth = 1.0f;
        _cicleShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _cicleShapeLayer.strokeEnd = _cicleShapeLayer.strokeStart = 0.f;
       //创建出圆形贝塞尔曲线
        [self.layer addSublayer:_cicleShapeLayer];
        
    }
    return _cicleShapeLayer;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:
                                CGRectMake((self.frame.size.width - self.frame.size.height/2)/2
                                           , (self.frame.size.height - self.frame.size.height/2)/2
                                           , self.frame.size.height/2
                                           , self.frame.size.height/2)];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    _cicleShapeLayer.path = circlePath.CGPath;
    
}

#pragma mark - Event Method
/**
 *  开始动画
 */
- (void)startAnimation
{

    [self addAnimate];
    if (_timer) {
        [_timer invalidate];
    }
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval: duration
                                                       target: self
                                                     selector: @selector(addAnimate)
                                                     userInfo: nil
                                                      repeats: YES];
    _timer = timer;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.15
                     animations:^{
                         weakSelf.cicleShapeLayer.opacity = 1.f;
                         [weakSelf setTitleColor:[UIColor colorWithWhite:1 alpha:0]
                                        forState:UIControlStateNormal];
                     }];
}
/**
 *  停止动画
 */
- (void)stopAnimation
{
    
    if (_timer) {
        [_timer invalidate];
    }
    [self.cicleShapeLayer removeAllAnimations];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.15
                     animations:^{
                         self.cicleShapeLayer.opacity = 0.f;
                         [weakSelf setTitleColor:[UIColor colorWithWhite:1 alpha:1]
                                        forState:UIControlStateNormal];
                     }];

}


#pragma mark - Private Method
- (void)addAnimate
{

    CABasicAnimation * endAnimation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    endAnimation.fromValue = @0;
    endAnimation.toValue = @1;
    endAnimation.duration = duration;
    endAnimation.removedOnCompletion = YES;
    [self.cicleShapeLayer addAnimation: endAnimation forKey: @"end"];
    
    CABasicAnimation * startAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    startAnimation.beginTime = CACurrentMediaTime() + duration / 2;
    startAnimation.fromValue = @0;
    startAnimation.toValue = @1;
    startAnimation.removedOnCompletion = YES;
    startAnimation.duration = duration / 2;
    [self.cicleShapeLayer addAnimation: startAnimation forKey: @"start"];
    
}

@end
