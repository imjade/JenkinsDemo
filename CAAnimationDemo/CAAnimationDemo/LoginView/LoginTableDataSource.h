//
//  LoginTableDataSource.h
//  CAAnimationDemo
//
//  Created by Jade on 4/5/16.
//  Copyright © 2016 Jade. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^didSelectRow)(NSIndexPath *indexPath);
@interface LoginTableDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>
+ (instancetype)createTableDataSourceWithDataList:(NSArray *)dataList
                                     DidSelectRow:(didSelectRow)didSelectRow;
@end
