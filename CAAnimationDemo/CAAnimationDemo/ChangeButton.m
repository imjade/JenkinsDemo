//
//  ChangeButton.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/28.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "ChangeButton.h"
#define LINEHEIGHT 10.f
#define LINEWIDTH 50.f

//big
static const CGFloat Raduis = 50.0f;
static const CGFloat lineWidth = 50.0f;
static const CGFloat lineGapHeight = 10.0f;
static const CGFloat lineHeight = 8.0f;

static const CGFloat kStep1Duration = 0.5;
static const CGFloat kStep2Duration = 0.5;
static const CGFloat kStep3Duration = 5.0;
static const CGFloat kStep4Duration = 5.0;

#define kTopY       Raduis - lineGapHeight
#define kCenterY    kTopY + lineGapHeight + lineHeight
#define kBottomY    kCenterY + lineGapHeight + lineHeight
#define Radians(x)  (M_PI * (x) / 180.0)

@interface ChangeButton()
@property (nonatomic,strong) CAShapeLayer *lineLayer1;
@property (nonatomic,strong) CAShapeLayer *lineLayer2;
@property (nonatomic,strong) CAShapeLayer *lineLayer3;
@end

@implementation ChangeButton



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lineLayer1.frame = CGRectMake((CGRectGetWidth(self.frame) - LINEWIDTH)/2, 30, LINEWIDTH, LINEHEIGHT);
//    self.lineLayer2.frame = CGRectMake((CGRectGetWidth(self.frame) - LINEWIDTH)/2, CGRectGetMaxY(self.lineLayer1.frame) + 10.f,LINEWIDTH , LINEHEIGHT);
    self.lineLayer3.frame = CGRectMake((CGRectGetWidth(self.frame) - LINEWIDTH)/2, CGRectGetMaxY(self.lineLayer2.frame) + 10.f, LINEWIDTH, LINEHEIGHT);
}


#pragma mark - setter

- (CALayer *)lineLayer1
{
    
    if (!_lineLayer1) {
        _lineLayer1 = [CAShapeLayer new];
        _lineLayer1.borderWidth = LINEHEIGHT;
        _lineLayer1.borderColor = [UIColor orangeColor].CGColor;
        _lineLayer1.cornerRadius = LINEHEIGHT/2;
        _lineLayer1.masksToBounds = YES;
        [self.layer addSublayer:_lineLayer1];
    }
    return _lineLayer1;
}

- (CALayer *)lineLayer2
{
    
    if (!_lineLayer2) {
        _lineLayer2 = [CAShapeLayer new];
        _lineLayer2.lineWidth = lineWidth;
        _lineLayer2.strokeColor = [UIColor whiteColor].CGColor;
        _lineLayer2.fillColor = [UIColor clearColor].CGColor;
        _lineLayer2.contentsScale = [UIScreen mainScreen].scale;
        _lineLayer2.lineCap = kCALineCapRound;
        
        CGFloat startOrginX = (self.center.x - lineWidth)/2;
        CGFloat endOrginX = (self.center.x + lineWidth)/2;
        CGMutablePathRef solidChangeLinePath = CGPathCreateMutable();
        CGPathMoveToPoint(solidChangeLinePath, NULL, startOrginX, kCenterY);
        CGPathAddLineToPoint(solidChangeLinePath, NULL, startOrginX, kCenterY);
        [self.lineLayer2 setPath:solidChangeLinePath];
        CGPathRelease(solidChangeLinePath);
        
//        _lineLayer2.borderWidth = LINEHEIGHT;
//        _lineLayer2.cornerRadius = LINEHEIGHT/2;
//        _lineLayer2.masksToBounds = YES;
//        _lineLayer1.strokeStart = 1.f;
//        _lineLayer2.borderColor = [UIColor orangeColor].CGColor;
        [self.layer addSublayer:_lineLayer2];
    }
    return _lineLayer2;
}

- (CALayer *)lineLayer3
{
    
    if (!_lineLayer3) {
        _lineLayer3 = [CAShapeLayer new];
        _lineLayer3.borderWidth = LINEHEIGHT;
        _lineLayer3.cornerRadius = LINEHEIGHT/2;
        _lineLayer3.masksToBounds = YES;
        _lineLayer3.borderColor = [UIColor orangeColor].CGColor;
        [self.layer addSublayer:_lineLayer3];
    }
    return _lineLayer3;
}

#pragma mark - setter

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self animateStep1];
    }
}

#pragma mark - Aimate Method
const CGFloat kStep1Durtion = 2.f;
- (void)animateStep1
{
    self.lineLayer2.strokeEnd = 0.4;
    //1>.缩小长度动画
    CABasicAnimation *stokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    stokeAnimation.fromValue = [NSNumber numberWithFloat:1.f];
    stokeAnimation.toValue = [NSNumber numberWithFloat:0.4f];

    
    //2>.左位移动画
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    positionAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    positionAnimation.toValue = [NSNumber numberWithFloat:-10.f];

    //3>.组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:stokeAnimation,positionAnimation, nil];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animationGroup.duration = kStep1Durtion;
    animationGroup.delegate = self;
    animationGroup.removedOnCompletion = YES;
    
    [animationGroup setValue:@"AnimationStep1" forKey:@"animationName"];
    [self.lineLayer2 addAnimation:animationGroup forKey:nil];
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"AnimationName"] isEqualToString:@"AnimationStep1"]) {
        
    }else if ([[anim valueForKey:@"AnimationName"] isEqualToString:@"AnimationStep2"]) {
        
    }
}

@end
