//
//  ZYBaseViewController.m
//  demo
//
//  Created by 张祎 on 2020/6/4
//  Copyright © 2020 objcat. All rights reserved.
//


#import "ZYBaseViewController.h"

@interface ZYBaseViewController () <UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIImage *naviBgImage;
@property (strong, nonatomic) UIImage *backIndicatorImage_backup;
@property (strong, nonatomic) UIImage *backIndicatorTransitionMaskImage_backup;
@end

@implementation ZYBaseViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 禁用某页面返回按钮功能
    if (self.stopInteractivePopGestureRecognizer) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.stopInteractivePopGestureRecognizer) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 默认设置
    [self defaultSetting];
    // 打印沙盒路径
    [self logSandbox];
}

- (void)setClearColor:(BOOL)clearColor {
    _clearColor = clearColor;
    if (clearColor == YES) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:self.naviBgImage forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];
    }
}

- (void)setNavigationBarTintColor:(UIColor *)navigationBarTintColor {
    _navigationBarTintColor = navigationBarTintColor;
    self.navigationController.navigationBar.tintColor = navigationBarTintColor;
}

- (void)defaultSetting {
    // 设置导航栏背景颜色, 这里使用99%透明度的图片作为背景, 既做到了不透明又不影响初始坐标系
    self.naviBgImage = [self imageWithColor:[UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:0.99] Size:CGSizeMake(1, 64)];
    [self.navigationController.navigationBar setBackgroundImage:self.naviBgImage forBarMetrics:UIBarMetricsDefault];
    
    // 判断是否初始化了颜色 如果没有赋值成白色
    // 加判断的目的是为了不影响storyboard中设置的初始背景颜色
    if (self.view.backgroundColor == nil) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)logSandbox {
    // 打印沙盒路径
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"沙盒路径: %@", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]);
    });
}

- (void)setBackButtonImage:(UIImage *)backButtonImage {
    _backButtonImage = backButtonImage;
    // 设置返回按钮图片
    UIImage *image = backButtonImage;
    if (image) {
        // 保存原图片
        self.backIndicatorImage_backup = self.navigationController.navigationBar.backIndicatorImage;
        self.backIndicatorTransitionMaskImage_backup = self.navigationController.navigationBar.backIndicatorTransitionMaskImage;
        self.navigationController.navigationBar.backIndicatorImage = image;
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = image;
    } else {
        // 还原图片
        self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"system_back"];
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"system_back"];
    }
}

- (void)setBackButtonTitle:(NSString *)backButtonTitle {
    _backButtonTitle = backButtonTitle;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:self.backButtonTitle style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)dealloc {
    NSLog(@"控制器释放---%@", NSStringFromClass([self class]));
}

@end
