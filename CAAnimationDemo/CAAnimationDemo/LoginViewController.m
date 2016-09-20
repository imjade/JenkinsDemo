//
//  LoginViewController.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/29.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
@interface LoginViewController()
@property (nonatomic,strong) LoginView *loginView;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"登录"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(selectRightItem:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

#pragma mark - setter


#pragma mark - Action Method

- (void)selectRightItem:(id)sender
{
    [[[LoginView alloc] init] addLogin2View:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end
