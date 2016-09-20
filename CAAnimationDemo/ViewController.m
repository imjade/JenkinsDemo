//
//  ViewController.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/21.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Log.h"
#import "NextViewController.h"
#import "LoginViewController.h"
#import "Network.h"

@interface ViewController ()
@property (nonatomic,strong) UITableView *mainTable;
@property (nonatomic,strong) TableViewDataSource *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.mainTable];
    [self.mainTable makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];

    [[Network shareIntance] networkType];
    
}

#pragma mark - setter

- (UITableView *)mainTable
{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc] init];
        _mainTable.backgroundColor = [UIColor whiteColor];
        __block NSArray *array = @[@"dhwqodqopdoqdhopqhdoqhdoqhdoqwhpdohqwdhwqodqopdoqdhopqhdoqhdoqhdoqwhpdohqwdhwqodqopdoqdhopqhdoqhdoqhdoqwhpdohqw"
                                   ,@"42"
                                   ,@"27397120372017391273172739712037201739127317"
                                   ,@"34"
                                   ,@"5"
                                   ,@"6"
                                   ,@"idwqoe1290ue9123021301"
                                   ,@"7",@"2739712037201739127317"
                                   ,@"2739712037201739127317"
                                   ,@"idwqoe1290ue9123021301"];
        __weak typeof(self) weakSelf = self;
        self.dataSource = [TableViewDataSource createTableViewDataSourceWithDataList:array
                                                                        didSelectRow:^(NSIndexPath *indexPath) {
                                                                            NSLog(@"array_value:%@",[array objectAtIndex:indexPath.row]);
                                                                            switch (indexPath.row) {
                                                                                case 0:
                                                                                {
                                                                                    NextViewController *nextView = [[NextViewController alloc] init];
                                                                                    [weakSelf.navigationController pushViewController:nextView animated:YES];
                                                                                }
                                                                                    break;
                                                                                    
                                                                                default:
                                                                                {
                                                                                    LoginViewController *loginView = [[LoginViewController alloc] init];
                                                                                    [weakSelf.navigationController pushViewController:loginView animated:YES];
                                                                                }
                                                                                    break;
                                                                            }
                                                                        }];
        _mainTable.dataSource = self.dataSource;
        _mainTable.delegate = self.dataSource;
        _mainTable.rowHeight = UITableViewAutomaticDimension;
        _mainTable.estimatedRowHeight = 44.f;
        _mainTable.tableFooterView = [[UIView alloc] init];
        
    }
    return _mainTable;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
