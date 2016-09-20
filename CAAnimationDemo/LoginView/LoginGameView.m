//
//  LoginGameView.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/30.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "LoginGameView.h"
#import "PywInputTF.h"
#import "LoginTableDataSource.h"
@interface LoginGameView()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) PywInputTF *accountInputTF;
@property (nonatomic,strong) UITableView *accountListTable;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *otherLoginButton;
@property (nonatomic,strong) UIButton *selectAccontButton;

@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) LoginTableDataSource *dataSource;
@end

@implementation LoginGameView

- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:228/255.f green:228/255.f blue:228/255.f alpha:1];
        self.layer.cornerRadius = 4.f;
        self.layer.masksToBounds = YES;
        [self setUp];
    }
    return self;
}

#pragma mark - setUp

- (void)setUp
{
    self.dataList = [NSMutableArray arrayWithObjects:@"xp1111",@"xp2222",@"xp3333", nil];
    [self addSubview:self.topView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.accountInputTF];
    [self addSubview:self.loginButton];
    [self addSubview:self.otherLoginButton];
    [self addConstraints];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    /**
     *  Table 的约束
     */
    if (!CGRectEqualToRect(self.frame, CGRectZero)) {
        if (!_accountListTable) {
            [self addSubview:self.accountListTable];
            __weak typeof(self) weakSelf = self;
            [self.accountListTable makeConstraints :^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.top.mas_equalTo(weakSelf.accountInputTF.mas_bottom);
                make.width.mas_equalTo(weakSelf.accountInputTF.mas_width);
                make.height.mas_equalTo(0);
            }];
        }
        
    }
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
        make.height.mas_equalTo(weakSelf.height).multipliedBy(0.17);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.width.mas_equalTo(weakSelf.width).multipliedBy(0.9);
        make.height.mas_equalTo(weakSelf.height).multipliedBy(0.15);
        make.top.mas_equalTo(weakSelf.topView.bottom).offset(10);
    }];
    
    [self.accountInputTF makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.top.mas_equalTo(weakSelf.titleLabel.bottom).offset(0);
        make.width.height.mas_equalTo(weakSelf.titleLabel);
    }];
    
    [self.loginButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.height.width.mas_equalTo(weakSelf.accountInputTF);
        make.top.mas_equalTo(weakSelf.accountInputTF.bottom).offset(20);
    }];
    
    [self.otherLoginButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.height.width.mas_equalTo(weakSelf.loginButton);
        make.top.mas_equalTo(weakSelf.loginButton.bottom).offset(20);
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
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"欢迎登录";
    }
    return _titleLabel;
}

- (PywInputTF *)accountInputTF{
    
    if (!_accountInputTF) {
        
        _accountInputTF = [[PywInputTF alloc] init];
        _accountInputTF.delegate = self;
        _accountInputTF.layer.cornerRadius = 5;
        [_accountInputTF setTintColor:[UIColor lightGrayColor]];
        _accountInputTF.borderStyle = UITextBorderStyleRoundedRect;
        _accountInputTF.leftViewMode = UITextFieldViewModeAlways;
        _accountInputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountInputTF.placeholder = @"请输入游戏账号";
        _accountInputTF.rightView = self.selectAccontButton;
        _accountInputTF.rightViewMode = UITextFieldViewModeAlways;
        [_accountInputTF addTarget:self
                            action:@selector(accountTextFieldChange:)
                  forControlEvents:UIControlEventEditingDidBegin];
    }
    return _accountInputTF;
}

- (UITableView *)accountListTable
{
    if (!_accountListTable) {
        _accountListTable = [[UITableView alloc] init];
        _accountListTable.layer.borderWidth = 1;
        _accountListTable.layer.borderColor = [UIColor grayColor].CGColor;
        _accountListTable.tableFooterView = [[UIView alloc] init];
        _accountListTable.dataSource = self.dataSource;
        _accountListTable.delegate = self.dataSource;
    }
    return _accountListTable;
}

- (UIButton *)loginButton{
    
    if (!_loginButton) {
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.layer.cornerRadius = 5;
        [_loginButton setTitle:@"进入游戏" forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor orangeColor];
        [_loginButton setTitleColor:[UIColor whiteColor]
                           forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor blackColor]
                              forState:UIControlStateHighlighted];
        [_loginButton addTarget:self
                         action:@selector(selectLoginButton:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)otherLoginButton{
    
    if (!_otherLoginButton) {
        _otherLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _otherLoginButton.layer.cornerRadius = 5;
        [_otherLoginButton setTitle:@"使用其他方式登录"
                           forState:UIControlStateNormal];
        [_otherLoginButton setTitleColor:[UIColor blackColor]
                                forState:UIControlStateNormal];
        _otherLoginButton.backgroundColor = [UIColor whiteColor];
        [_otherLoginButton setTitleColor:[UIColor blueColor]
                           forState:UIControlStateHighlighted];
        _otherLoginButton.layer.borderWidth = 1;
        _otherLoginButton.layer.borderColor = [UIColor orangeColor].CGColor;
        [_otherLoginButton addTarget:self
                         action:@selector(selectOtherLoginButton:)
               forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _otherLoginButton;
}


- (UIButton *)selectAccontButton{
    
    if (!_selectAccontButton) {
        
        _selectAccontButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectAccontButton.layer.borderWidth = 1;
        _selectAccontButton.layer.borderColor = [UIColor orangeColor].CGColor;
        [_selectAccontButton addTarget:self
                                action:@selector(selectAccontButton:)
                      forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAccontButton;
}

- (LoginTableDataSource *)dataSource
{
    if (!_dataSource) {
        __weak typeof(self) weakSelf = self;
        _dataSource = [LoginTableDataSource createTableDataSourceWithDataList:self.dataList DidSelectRow:^(NSIndexPath *indexPath) {
            [weakSelf endEditing:YES];
            weakSelf.accountInputTF.text = weakSelf.dataList[indexPath.row];
            [weakSelf hideTable];
        }];
    }
    return _dataSource;
}


#pragma mark - Action Method
/**
 *  输入文本
 *
 *  @param textFiled <#textFiled description#>
 */
- (void)accountTextFieldChange:(PywInputTF *)textFiled
{
    [self hideTable];
}

/**
 *  点击进入游戏
 *
 *  @param sender <#sender description#>
 */
- (void)selectLoginButton:(UIButton *)sender
{
    [self endEditing:YES];
    [self hideTable];
    if ([self.delegate respondsToSelector:@selector(didSelectLogin:)]) {
        [self.delegate didSelectLogin:self];
    }
}

/**
 *  选择其他方式登录
 *
 *  @param sender <#sender description#>
 */
- (void)selectOtherLoginButton:(UIButton *)sender
{
    [self endEditing:YES];
    [self hideTable];
    if ([self.delegate respondsToSelector:@selector(didSelectOtherLogin:)]) {
        [self.delegate didSelectOtherLogin:self];
    }
}


/**
 *  选择游戏账号列表
 *
 *  @param sender <#sender description#>
 */
- (void)selectAccontButton:(UIButton *)sender
{
    [self endEditing:YES];
    sender.selected = !sender.selected;
    sender.selected?[self showTable]:[self hideTable];
}

#pragma mark - Private
/**
 *  显示Table
 *
 */
- (void)showTable
{
    __weak typeof(self) weakSelf = self;
    CGRect accountFrame = self.accountListTable.frame;
    accountFrame.size.height = 90.f;
    [UIView animateWithDuration:.2f
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         weakSelf.accountListTable.frame = accountFrame;
                     } completion:^(BOOL finished) {
                         weakSelf.selectAccontButton.selected = YES;
                     }];
    
}

/**
 *  隐藏Table
 */
- (void)hideTable
{
    __weak typeof(self) weakSelf = self;
    CGRect accountFrame = self.accountListTable.frame;
    accountFrame.size.height = 0.f;
    [UIView animateWithDuration:.2f
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         weakSelf.accountListTable.frame = accountFrame;
                     } completion:^(BOOL finished) {
                         weakSelf.selectAccontButton.selected = NO;
                     }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}


@end
