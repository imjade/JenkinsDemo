//
//  TableViewDataSource.h
//  CAAnimationDemo
//
//  Created by Jade on 16/3/23.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^didSelectRow)(NSIndexPath *indexPath);
@interface TableViewDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>
+ (instancetype)createTableViewDataSourceWithDataList:(NSArray *)dataList
                                         didSelectRow:(didSelectRow)didSelectRow;
@end
