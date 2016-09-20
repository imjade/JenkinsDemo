//
//  LoginActionView.h
//  CAAnimationDemo
//
//  Created by Jade on 16/3/30.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginActionView;
@protocol LoginActionViewDelegate <NSObject>

/**
 *  平台账号登录成功-跳转到游戏账号登陆
 *
 *  @param loginActionView <#loginActionView description#>
 */
- (void)didLoginPlatformAccount:(LoginActionView *)loginActionView;

/**
 *  游戏账号登录成功-跳转到登录中
 *
 *  @param loginActionView <#loginActionView description#>
 */
- (void)didLoginGameAccount:(LoginActionView *)loginActionView;


@end

@interface LoginActionView : UIView
@property (nonatomic,assign) id<LoginActionViewDelegate> delegate;

@end
