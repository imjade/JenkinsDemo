//
//  Network.h
//  CAAnimationDemo
//
//  Created by Jade on 4/11/16.
//  Copyright © 2016 Jade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Network : NSObject
+ (id)shareIntance;
/**
 *  网络类型
 *
 *  @return <#return value description#>
 */
- (NSString *)networkType;
@end
