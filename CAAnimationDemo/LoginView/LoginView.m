//
//  LoginView.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/29.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "LoginView.h"
#import "LoginActionView.h"
#import "LoginGameView.h"
#import "LoginStatusView.h"
@interface LoginView()<LoginActionViewDelegate,LoginGameViewDelegate,LoginStatusViewDelegate>
@property (nonatomic,strong) LoginActionView *loginActionView;
@property (nonatomic,strong) LoginGameView *loginGameView;
@property (nonatomic,strong) LoginStatusView *loginStatusView;

@property (nonatomic,strong) UIView *currentView;
@end

@implementation LoginView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0. alpha:.6];
        [self setUp];
    }
    return self;
}


- (void)dealloc
{
    NSLog(@"dealloc:%@",self.class);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




#pragma mark - setUp
- (void)setUp
{
    BOOL isHasCache = NO;
    if (isHasCache) {
        [self addSubview:self.loginActionView];
        CGAffineTransform transfrom = CGAffineTransformMakeTranslation(-1000, 0);
        self.loginActionView.transform = transfrom;
        __weak typeof(self) weakSelf = self;
        [self.loginActionView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(300.f, 300.f));
        }];
        [self loginStstusViewToScreen];
    }else {
        [self loginActionViewToScreen];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


/**
 *  通行证/游戏账号添加到主屏幕
 */
- (void)loginActionViewToScreen
{
    [self addSubview:self.loginActionView];
    __weak typeof(self) weakSelf = self;
    [self.loginActionView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(300.f, 300.f));
    }];
    
    [self pushIntoMainScreen:self.loginActionView];
}

/**
 *  游戏账号登录View添加到主屏幕
 */
- (void)loginGameViewToScreen
{
    [self addSubview:self.loginGameView];
    __weak typeof(self) weakSelf = self;
    [self.loginGameView makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(300.f, 300.f));
    }];
    [self pushIntoMainScreen:self.loginGameView];
}
/**
 *  登录状态View添加到主屏幕
 */
- (void)loginStstusViewToScreen
{
    [self addSubview:self.loginStatusView];
    __weak typeof(self) weakSelf = self;
    [self.loginStatusView makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(290.f, 300.f));
    }];
    [self pushIntoMainScreen:self.loginStatusView];
}

#pragma mark - getter Method


- (LoginActionView *)loginActionView{
    
    if (!_loginActionView) {
        
        _loginActionView = [[LoginActionView alloc] init];
        CGAffineTransform transfrom = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width + 1000, 0);
        _loginActionView.transform = transfrom;
        _loginActionView.delegate = self;
    }
    return _loginActionView;
}

- (LoginGameView *)loginGameView{
    
    if (!_loginGameView) {
        
        _loginGameView = [[LoginGameView alloc] init];
        CGAffineTransform transfrom = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width + 1000, 0);
        _loginGameView.transform = transfrom;
        _loginGameView.delegate = self;
        
    }
    return _loginGameView;
}



- (LoginStatusView *)loginStatusView
{
    if (!_loginStatusView) {
        _loginStatusView = [[LoginStatusView alloc] initWithState:0];
        CGAffineTransform transfrom = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width + 1000, 0);
        _loginStatusView.transform = transfrom;
        _loginStatusView.delegate = self;
    }
    return _loginStatusView;
}


#pragma mark - Public Method
/**
 *  添加LoginView到其他View
 *
 *  @param theView 添加到的View
 */
- (void)addLogin2View:(UIView *)theView
{

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    __weak UIView *superView = theView;
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(superView);
    }];
}



#pragma mark - --Push---Pop--

/**
 *  Push进场动画
 */
- (void)pushIntoMainScreen:(UIView *)theView{

    
    __weak UIView *mainView = theView;
    self.currentView = theView;
    [UIView animateWithDuration:.5f
                     animations:^{
                         mainView.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         
                     }];

}

/**
 *  Pop出场动画--->左边出去
 */
- (void)pop2Left:(UIView *)theView
   stopAnimation:(StopAnimation)stopAnimation{
    
    __weak UIView *mainView = theView;
    [UIView animateWithDuration:.5f
                     animations:^{
                         CGAffineTransform transfrom = CGAffineTransformMakeTranslation(-1000, 0);
                         mainView.transform = transfrom;
                     } completion:^(BOOL finished) {
                         if (stopAnimation && finished) {
                             stopAnimation();
                         }
                     }];
}

/**
 *  Pop出场动画--->右边出去
 */
- (void)pop2Right:(UIView *)theView
    stopAnimation:(StopAnimation)stopAnimation{
    
    __weak UIView *mainView = theView;
    [UIView animateWithDuration:.5f
                     animations:^{
                         CGAffineTransform transfrom = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width + 1000, 0);
                         mainView.transform = transfrom;
                     } completion:^(BOOL finished) {
                         if (stopAnimation && finished) {
                             stopAnimation();
                         }
                     }];
}
#pragma mark - ======Delegate Bengin====
#pragma mark - LoginActionViewDelegate
/**
 *  平台账号登录成功-跳转到游戏账号登陆
 *
 *  @param loginActionView <#loginActionView description#>
 */
- (void)didLoginPlatformAccount:(LoginActionView *)loginActionView
{
    [self pop2Left:self.loginActionView stopAnimation:^{
        
    }];
    
    [self loginGameViewToScreen];
}

/**
 *  游戏账号登录成功-跳转到登录中
 *
 *  @param loginActionView <#loginActionView description#>
 */
- (void)didLoginGameAccount:(LoginActionView *)loginActionView
{
    [self pop2Left:self.loginActionView stopAnimation:^{
        
    }];
    
    [self loginStstusViewToScreen];
}

#pragma mark - LoginGameViewDelegate
/**
 *  其他方式登录-切换到主界面
 *
 *  @param loginGameView <#loginGameView description#>
 */
- (void)didSelectOtherLogin:(LoginGameView *)loginGameView{
    
    [self pop2Right:self.loginGameView stopAnimation:^{
        [self.loginGameView removeFromSuperview];
        self.loginGameView = nil;
    }];
    
    [self pushIntoMainScreen:self.loginActionView];
}

/**
 *  游戏账号登录成功-跳转到登录中
 *
 *  @param loginGameView <#loginGameView description#>
 */
- (void)didSelectLogin:(LoginGameView *)loginGameView {
    
    [self pop2Left:self.loginGameView stopAnimation:^{
        [self.loginGameView removeFromSuperview];
        self.loginGameView = nil;
    }];
    
    [self loginStstusViewToScreen];
    
}

#pragma mark - LoginStatusViewDelegate
/**
 *  其他方式登录
 *
 *  @param loginStautsView <#loginStautsView description#>
 */
- (void)didSwitchOhterLogin:(LoginStatusView *)loginStautsView{
    
    [self pop2Right:self.loginStatusView stopAnimation:^{
        [self.loginStatusView removeFromSuperview];
        self.loginStatusView = nil;
    }];
    
    [self pushIntoMainScreen:self.loginActionView];
}


#pragma mark - =====Delegate End====


/**
 *  键盘弹起
 *
 *  @param aNotification <#aNotification description#>
 */
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyboardFrame = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSNumber *duration = [aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curv = [aNotification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGRect frame = self.currentView.frame;
    
    frame.origin.y = CGRectGetHeight(self.frame) - (CGRectGetHeight(keyboardFrame) + 240.f);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration.integerValue];
    [UIView setAnimationCurve:curv.integerValue];
    
    self.currentView.frame = frame;
    [UIView commitAnimations];
}

/**
 *  键盘隐藏
 *
 *  @param aNotification <#aNotification description#>
 */
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSNumber *duration = [aNotification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curv = [aNotification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration.integerValue];
    [UIView setAnimationCurve:curv.integerValue];
    self.currentView.center = self.center;
    [UIView commitAnimations];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    [self removeFromSuperview];
}




@end


