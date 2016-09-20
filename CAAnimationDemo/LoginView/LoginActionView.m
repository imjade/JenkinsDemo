//
//  LoginActionView.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/30.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "LoginActionView.h"
#import "PywInputTF.h"
#import "LoginView.h"
#import "LoginTableDataSource.h"
@interface LoginActionView()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) PywInputTF *accountInputTF;
@property (nonatomic,strong) UITableView *accoutListTable;
@property (nonatomic,strong) PywInputTF *passwordInputTF;
@property (nonatomic,strong) UIButton *enterButton;
@property (nonatomic,strong) UIButton *forgetButton;
@property (nonatomic,strong) UIButton *registerButton;
@property (nonatomic,strong) UIButton *selectAccountButton;

@property (nonatomic,strong) LoginTableDataSource *dataSource;//Table 的数据源
@property (nonatomic,strong) NSMutableArray *accountList;//账号列表

@end
@implementation LoginActionView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:228/255.f green:228/255.f blue:228/255.f alpha:1];
        self.layer.cornerRadius = 4.f;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
        [self setUp];
    }
    return self;
}



#pragma mark - setUp

- (void)setUp
{
    self.accountList = [NSMutableArray arrayWithObjects:@"xp1234",@"xp3288080",@"xp11111",nil];
    [self addSubview:self.topView];
    [self addSubview:self.accountInputTF];
    [self addSubview:self.passwordInputTF];
    [self addSubview:self.enterButton];
    [self addSubview:self.forgetButton];
    [self addSubview:self.registerButton];
    [self addSubview:self.selectAccountButton];
    
    [self addConstraints];
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
    
    [self.accountInputTF makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.top.mas_equalTo(weakSelf.topView.bottom).offset(20);
        make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(0.9);
        make.height.mas_equalTo(weakSelf.mas_height).multipliedBy(0.15);
    }];
    
    
    [self.passwordInputTF makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.top.mas_equalTo(weakSelf.accountInputTF.bottom).offset(10);
        make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(0.9);
        make.height.mas_equalTo(weakSelf.mas_height).multipliedBy(0.15);
    }];
    
    [self.enterButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.top.mas_equalTo(weakSelf.passwordInputTF.bottom).offset(20);
        make.height.width.mas_equalTo(weakSelf.passwordInputTF);
    }];
    
    [self.forgetButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(weakSelf.enterButton.bottom).offset(10);
        make.left.mas_equalTo(weakSelf.enterButton.left);
        make.height.mas_equalTo(weakSelf.enterButton.height);
    }];
    
    [self.registerButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(weakSelf.enterButton.bottom).offset(10);
        make.right.mas_equalTo(weakSelf.enterButton.right);
        make.height.mas_equalTo(weakSelf.enterButton.height);
    }];
    
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    /**
     *  Table 的约束
     */
    if (!CGRectEqualToRect(self.frame, CGRectZero)) {
        if (!_accoutListTable) {
            [self addSubview:self.accoutListTable];
            __weak typeof(self) weakSelf = self;
            [self.accoutListTable makeConstraints :^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.top.mas_equalTo(weakSelf.accountInputTF.mas_bottom);
                make.width.mas_equalTo(weakSelf.accountInputTF.mas_width);
                make.height.mas_equalTo(0);
            }];
        }
        
    }
}

#pragma mark - getter
/**
 *  顶部
 *
 */
- (UIView *)topView{
    
    if (!_topView) {
        
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
/**
 *  账号输入框
 *
 */
- (PywInputTF *)accountInputTF{
    
    if (!_accountInputTF) {
        
        _accountInputTF = [[PywInputTF alloc] init];
        [_accountInputTF addTarget:self
                            action:@selector(accountTextFieldChange:)
                  forControlEvents:UIControlEventEditingDidBegin];
        _accountInputTF.delegate = self;
        _accountInputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountInputTF.layer.cornerRadius = 5;
        [_accountInputTF setTintColor:[UIColor lightGrayColor]];
        _accountInputTF.borderStyle = UITextBorderStyleRoundedRect;
//        _accountInputTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"passport"]];;
        _accountInputTF.leftViewMode = UITextFieldViewModeAlways;
        _accountInputTF.rightView = self.selectAccountButton;
        _accountInputTF.rightViewMode = UITextFieldViewModeAlways;
        _accountInputTF.placeholder = @"请输入游戏账号";
    }
    return _accountInputTF;
}

- (UITableView *)accoutListTable
{
    if (!_accoutListTable) {
        _accoutListTable = [[UITableView alloc] init];
        _accoutListTable.layer.borderWidth = 1;
        _accoutListTable.layer.borderColor = [UIColor grayColor].CGColor;
        _accoutListTable.tableFooterView = [[UIView alloc] init];
        _accoutListTable.dataSource = self.dataSource;
        _accoutListTable.delegate = self.dataSource;
    }
    return _accoutListTable;
}

/**
 *  密码输入框
 */
- (PywInputTF *)passwordInputTF{
    
    if (!_passwordInputTF) {
        
        _passwordInputTF = [[PywInputTF alloc] init];
        _passwordInputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_passwordInputTF setSecureTextEntry:YES];
        _passwordInputTF.delegate = self;
        [_passwordInputTF setTintColor:[UIColor lightGrayColor]];
        _passwordInputTF.borderStyle = UITextBorderStyleRoundedRect;
        _passwordInputTF.leftViewMode = UITextFieldViewModeAlways;
        _passwordInputTF.placeholder = @"请输入游戏密码";
    }
    return _passwordInputTF;
}

/**
 *  进入游戏按钮
 */
- (UIButton *)enterButton{
    
    if (!_enterButton) {
        
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterButton.layer.cornerRadius = 5;
        [_enterButton setTitle:@"进入游戏" forState:UIControlStateNormal];
        _enterButton.backgroundColor = [UIColor orangeColor];
        [_enterButton setTitleColor:[UIColor blackColor]
                           forState:UIControlStateHighlighted];
        [_enterButton setTitleColor:[UIColor whiteColor]
                           forState:UIControlStateNormal];
        [_enterButton addTarget:self
                         action:@selector(selectLoginButton:)
               forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _enterButton;
}

/**
 *  忘记密码
 */
- (UIButton *)forgetButton{
    
    if (!_forgetButton) {
        
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_forgetButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_forgetButton setTitleColor:[UIColor grayColor]
                            forState:UIControlStateNormal];
        [_forgetButton setTitleColor:[UIColor blackColor]
                           forState:UIControlStateHighlighted];
        [_forgetButton setTitle:@"忘记密码?"
                       forState:UIControlStateNormal];
        [_forgetButton addTarget:self
                          action:@selector(selectForgetButton:)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}

/**
 *  注册按钮
 */
- (UIButton *)registerButton{
    
    if (!_registerButton) {
        
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_registerButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_registerButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_registerButton setTitle:@"快速注册"
                         forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blackColor]
                            forState:UIControlStateHighlighted];
        [_registerButton addTarget:self
                            action:@selector(selectRegisterButton:)
                  forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerButton;
}

/**
 *  选择历史账号按钮
 */
- (UIButton *)selectAccountButton{
    if (!_selectAccountButton) {
        _selectAccountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectAccountButton.backgroundColor = [UIColor orangeColor];
        [_selectAccountButton addTarget:self
                      action:@selector(selectAccountListTable:)
            forControlEvents:UIControlEventTouchUpInside];
        self.passwordInputTF.rightView = _selectAccountButton;
    }
    return _selectAccountButton;
}

/**
 *  TableView 的数据源
 *
 */
- (LoginTableDataSource *)dataSource
{
    if (!_dataSource) {
        __weak typeof(self) weakSelf = self;
        _dataSource = [LoginTableDataSource createTableDataSourceWithDataList:self.accountList DidSelectRow:^(NSIndexPath *indexPath) {
            [weakSelf endEditing:YES];
            weakSelf.accountInputTF.text = weakSelf.accountList[indexPath.row];
            [weakSelf hideTable];
        }];
    }
    
    return _dataSource;
}



#pragma mark - Action Medthod 
/**
 *  输入账号下拉列表消失
 *
 *  @param inputTF <#inputTF description#>
 */
- (void)accountTextFieldChange:(PywInputTF *)inputTF
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
    BOOL isLoginPlatform = YES;
    if (isLoginPlatform) {
        if ([self.delegate respondsToSelector:@selector(didLoginPlatformAccount:)]) {
            [self.delegate didLoginPlatformAccount:self];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(didLoginGameAccount:)]) {
            [self.delegate didLoginGameAccount:self];
        }
    }

}

/**
 *  点击忘记密码
 *
 *  @param sender <#sender description#>
 */
- (void)selectForgetButton:(UIButton *)sender
{
    [self endEditing:YES];
}

/**
 *  点击快速注册
 *
 *  @param sender <#sender description#>
 */
- (void)selectRegisterButton:(UIButton *)sender
{
    [self endEditing:YES];
    
}

/**
 *  选择历史账号列表
 *
 *  @param sender <#sender description#>
 */
- (void)selectAccountListTable:(UIButton *)sender
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
    CGRect accountFrame = self.accoutListTable.frame;
    accountFrame.size.height = 90.f;
    [UIView animateWithDuration:.2f
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         weakSelf.accoutListTable.frame = accountFrame;
                     } completion:^(BOOL finished) {
                         weakSelf.selectAccountButton.selected = YES;
                     }];
    
}

/**
 *  隐藏Table
 */
- (void)hideTable
{
    __weak typeof(self) weakSelf = self;
    CGRect accountFrame = self.accoutListTable.frame;
    accountFrame.size.height = 0.f;
    [UIView animateWithDuration:.2f
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         weakSelf.accoutListTable.frame = accountFrame;
                     } completion:^(BOOL finished) {
                         weakSelf.selectAccountButton.selected = NO;
                     }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}



@end
