//
//  LoginTableDataSource.m
//  CAAnimationDemo
//
//  Created by Jade on 4/5/16.
//  Copyright © 2016 Jade. All rights reserved.
//

#import "LoginTableDataSource.h"

@interface LoginTableDataSource()
@property (nonatomic,copy) didSelectRow didSelectRow;
@property (nonatomic,strong) NSArray *dataList;
@end

@implementation LoginTableDataSource
+ (instancetype)createTableDataSourceWithDataList:(NSArray *)dataList
                                     DidSelectRow:(didSelectRow)didSelectRow
{
    return [[[self class] alloc] initTableDataSourceWithDataList:dataList
                                            DidSelectRow:didSelectRow];
}

- (instancetype)initTableDataSourceWithDataList:(NSArray *)dataList
                                   DidSelectRow:(didSelectRow)didSelectRow
{
    self = [super init];
    if (self) {
        self.didSelectRow = didSelectRow;
        self.dataList = dataList;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiter = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifiter];
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectRow) {
        self.didSelectRow(indexPath);
    }
}



@end
