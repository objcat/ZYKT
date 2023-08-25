//
//  ZYKTBaseViewController.m
//  ZYKTDemo
//
//  Created by objcat on 2023/8/25.
//

#import "ZYKTBaseViewController.h"

@interface ZYKTBaseViewController ()

@end

@implementation ZYKTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"superViewDidLoad");
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"存储" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStyleDone target:self action:@selector(clearAction)];
    self.navigationItem.rightBarButtonItems = @[saveItem, clearItem];
}

- (void)saveAction {
    n_store.saveClass = NSStringFromClass(self.class);
    NSLog(@"储存成功!");
}

- (void)clearAction {
    n_store.saveClass = nil;
    NSLog(@"清除成功!");
}

@end
