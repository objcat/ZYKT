//
//  ZYBaseViewController.h
//  demo
//
//  Created by 张祎 on 2020/6/4
//  Copyright © 2020 objcat. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ZYBaseViewController : UIViewController

/// 设置返回按钮的标题, 支持动态修改, 需要在前一个页面进行修改
/// 默认原标题 设置为@""显示空
@property (strong, nonatomic) NSString *backButtonTitle;

/// 禁用单个页面返回手势
@property (assign, nonatomic) BOOL stopInteractivePopGestureRecognizer;

/// 清除导航栏颜色
@property (assign, nonatomic) BOOL clearColor;

/// 返回按钮图片
@property (strong, nonatomic) UIImage *backButtonImage;

/// 导航栏渲染颜色
@property (strong, nonatomic) UIColor *navigationBarTintColor;

@end

