//
//  LoginStatusView.h
//  CAAnimationDemo
//
//  Created by Jade on 16/3/31.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginStatusView;
@protocol LoginStatusViewDelegate <NSObject>

/**
 *  其他方式登录
 *
 *  @param loginStautsView <#loginStautsView description#>
 */
- (void)didSwitchOhterLogin:(LoginStatusView *)loginStautsView;

@end

@interface LoginStatusView : UIView
@property (nonatomic,assign) id<LoginStatusViewDelegate> delegate;
- (instancetype)initWithState:(NSInteger)state;
@end
