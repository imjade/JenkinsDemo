//
//  LoginView.h
//  CAAnimationDemo
//
//  Created by Jade on 16/3/29.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^StopAnimation)(void);

@interface LoginView : UIView
/**
 *  添加LoginView到其他View
 *
 *  @param theView 添加到的View
 */
- (void)addLogin2View:(UIView *)theView;
@end
