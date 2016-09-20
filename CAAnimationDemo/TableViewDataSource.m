//
//  TableViewDataSource.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/23.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "TableViewDataSource.h"
#import "TableViewCell.h"
#import "NextViewController.h"
@interface TableViewDataSource()
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,copy) didSelectRow didSelectRow;
@end

@implementation TableViewDataSource

+ (instancetype)createTableViewDataSourceWithDataList:(NSArray *)dataList
                                 didSelectRow:(didSelectRow)didSelectRow
{
    return [[[self class] alloc] initTableViewDataSourceWithDataList:dataList
                                                        didSelectRow:didSelectRow];
}

- (instancetype)initTableViewDataSourceWithDataList:(NSArray *)dataList
                                            didSelectRow:(didSelectRow)didSelectRow
{
    self = [super init];
    if (self) {
        self.dataList = dataList;
        self.didSelectRow = didSelectRow;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiter = @"Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identifiter];
    }
    [cell reloadDataWithDataList:self.dataList[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.didSelectRow(indexPath);
    
    
}
@end
