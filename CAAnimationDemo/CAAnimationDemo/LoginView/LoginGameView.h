//
//  LoginGameView.h
//  CAAnimationDemo
//
//  Created by Jade on 16/3/30.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginGameView;
@protocol LoginGameViewDelegate <NSObject>
/**
 *  其他方式登录
 *
 *  @param loginGameView <#loginGameView description#>
 */
- (void)didSelectOtherLogin:(LoginGameView *)loginGameView;
/**
 *  选择登陆
 *
 *  @param loginGameView <#loginGameView description#>
 */
- (void)didSelectLogin:(LoginGameView *)loginGameView;
@end

@interface LoginGameView : UIView
@property (nonatomic,assign) id<LoginGameViewDelegate> delegate;
@end
