//
//  NextViewController.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/25.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "NextViewController.h"
#import "AnimateButton.h"
#import "ChangeButton.h"
#import "ChangeAnimateView.h"
@interface NextViewController ()
@property (nonatomic,strong) AnimateButton *loginButton;
@property (nonatomic,strong) ChangeButton *changeButton;
@property (nonatomic,strong) ChangeAnimateView *changeAnimateView;
@property (nonatomic,assign) BOOL hasAnimation;
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initlizerUI];
}

#pragma mark - init
/**
 *  初始化界面
 */
- (void)initlizerUI
{
    [self.view addSubview:self.loginButton];
    
    __weak UIView *superView = self.view;
    [self.loginButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-50);
        make.size.mas_equalTo(CGSizeMake(300, 50));
    }];
    
    [self.view addSubview:self.changeAnimateView];
    [self.changeAnimateView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.top.offset(100.f);
        make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.view.frame), 120.f));
    }];
    
}

#pragma mark - setter
/**
 *  登录按钮
 *
 *  @return <#return value description#>
 */
- (AnimateButton *)loginButton
{
    
    if (!_loginButton) {
        _loginButton = [[AnimateButton alloc] init];
        _loginButton.backgroundColor = [UIColor colorWithRed:0.f/255 green:199.f/255 blue:95.f/255 alpha:1.f];
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        
        [_loginButton addTarget:self
                         action:@selector(loginButtonClick:)
               forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.cornerRadius = 6.f;
        _loginButton.layer.masksToBounds = YES;
    }
    return _loginButton;
}

- (ChangeButton *)changeButton
{
    if (!_changeButton) {
        _changeButton = [ChangeButton buttonWithType:UIButtonTypeCustom];
        _changeButton.backgroundColor = [UIColor grayColor];
        [_changeButton addTarget:self
                          action:@selector(selectChangeButton:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeButton;
}

- (UIView *)changeAnimateView
{
 
    if (!_changeAnimateView) {
        _changeAnimateView = [[ChangeAnimateView alloc] init];
        _changeAnimateView.backgroundColor = [UIColor orangeColor];
    }
    return _changeAnimateView;
}

#pragma mark - Event Mothod
/**
 *  点击登录按钮
 *
 *  @param sender <#sender description#>
 */
- (void)loginButtonClick:(UIButton *)sender
{
    
    sender.selected = !sender.selected;
    [self animateButtonWithHasUnfold:sender.selected
                           theButton:sender];
    
    [self.changeAnimateView startAnimation];
}

- (void)selectChangeButton:(UIButton *)sender
{
    sender.selected = YES;
}

#pragma mark - Private Mothod
/**
 *  展开和折叠按钮
 *
 *  @param hasUnfold 是否展开按钮
 *  @param theButton 要做动画的按钮
 */
- (void)animateButtonWithHasUnfold:(BOOL)hasUnfold
                         theButton:(UIButton *)theButton
{
 
    if (hasUnfold) {
        [self.loginButton startAnimation];
    }else {
        [self.loginButton stopAnimation];
    }
    
    CGFloat buttonWith = hasUnfold?50.f:300.f;
    [theButton updateConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(buttonWith, 50));
    }];
    _loginButton.layer.cornerRadius = hasUnfold?buttonWith/2.f:6.f;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.2f
                          delay:0.f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [weakSelf.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                     }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
