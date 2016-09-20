//
//  LoginStatusView.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/31.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "LoginStatusView.h"
@interface LoginStatusView()
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic,strong) UILabel *accountLabel;
@property (nonatomic,strong) UIButton *swichButton;
@property (nonatomic,assign) NSInteger state;
@end

@implementation LoginStatusView
- (instancetype)initWithState:(NSInteger)state
{
    
    self = [super init];
    if (self) {
        self.state = state;
        self.backgroundColor = [UIColor colorWithRed:228/255.f green:228/255.f blue:228/255.f alpha:1];
        self.layer.cornerRadius = 4.f;
        self.layer.masksToBounds = YES;
        [self setUp];
    }
    return self;
}

#pragma mark - setUp

- (void)setUp{
    
    [self addSubview:self.topView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.accountLabel];
    [self addSubview:self.statusLabel];
    [self addSubview:self.swichButton];
    [self addConstraints];
    self.swichButton.hidden = self.state;
}
/**
 *  添加约束
 */
- (void)addConstraints
{
    __weak typeof(self) weakSelf = self;
    [self.topView makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mas_left);
        make.top.mas_equalTo(weakSelf.mas_top);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(weakSelf.height).multipliedBy(0.2);
    }];
    
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.topView.bottom).offset(10);
        make.centerX.offset(0);
        make.width.mas_equalTo(weakSelf.width).multipliedBy(0.9);
        make.height.mas_equalTo(weakSelf.height).multipliedBy(0.18);
    }];
    
    [self.accountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.bottom);
        make.centerX.offset(0);
        make.width.mas_equalTo(weakSelf.titleLabel.width);
        make.height.mas_equalTo(0);
        if (weakSelf.state == 1) {
            make.top.mas_equalTo(weakSelf.titleLabel.bottom).offset(10);
            make.height.mas_equalTo(weakSelf.titleLabel.height);
        }
    }];
    
    [self.statusLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(weakSelf.accountLabel.bottom).offset(10);
        make.height.width.mas_equalTo(weakSelf.titleLabel);
    }];
    
    [self.swichButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(weakSelf.statusLabel.bottom).offset(20);
        make.width.mas_equalTo(weakSelf.statusLabel.width);
        make.height.mas_equalTo(weakSelf.statusLabel.height);
    }];
}

#pragma mark - setter
- (UIView *)topView{
    
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}


- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.text = @"欢迎登录";
        _titleLabel.backgroundColor = [UIColor orangeColor];
    }
    return _titleLabel;
}

- (UILabel *)accountLabel
{
    if (!_accountLabel) {
        _accountLabel = [UILabel new];
        _accountLabel.textAlignment = NSTextAlignmentCenter;
        _accountLabel.font = [UIFont systemFontOfSize:15.f];
        _accountLabel.text = @"Xp1234567";
        _accountLabel.backgroundColor = [UIColor orangeColor];
    }
    return _accountLabel;
}

- (UILabel *)statusLabel{
    
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = [UIFont systemFontOfSize:25.f];
        _statusLabel.text = @"登录中...";
        _statusLabel.backgroundColor = [UIColor orangeColor];
    }
    return _statusLabel;
}

- (UIButton *)swichButton{
    
    if (!_swichButton) {
        _swichButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_swichButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        _swichButton.backgroundColor = [UIColor orangeColor];
        _swichButton.layer.cornerRadius = 4;
        _swichButton.layer.masksToBounds = YES;
        [_swichButton setTitleColor:[UIColor blackColor]
                                forState:UIControlStateHighlighted];
        [_swichButton setTitle:@"切换账号"
                      forState:UIControlStateNormal];
        [_swichButton addTarget:self
                         action:@selector(selectSwichButton:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _swichButton;
}


#pragma mark - Action Method

/**
 *  切换账号
 *
 *  @param sender <#sender description#>
 */
- (void)selectSwichButton:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(didSwitchOhterLogin:)]) {
        [self.delegate didSwitchOhterLogin:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
