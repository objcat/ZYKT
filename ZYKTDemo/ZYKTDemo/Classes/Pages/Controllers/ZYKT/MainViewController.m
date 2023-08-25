//
//  MainViewController.m
//  ZYKitDemo
//
//  Created by objcat on 2023/8/3.
//

#import "MainViewController.h"
#import <ZYKT/ZYKT.h>
#import <EHFormKit/EHFormKit.h>
#import "ZYTitleTableViewCell.h"
#import "TestZYUserDefaultsViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) EHFormTableView *tableView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建表视图
    [self createTableView];
}

- (void)createTableView {
    self.tableView = [EHFormTableView tableView];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addNormalRowWithName:@"ZYUserDefaults" value:@"轻量化存储工具" cellClass:[ZYTitleTableViewCell class] rowHeight:44 callBack:^(EHFormModel *model, EHFormModelEventType eventType, NSDictionary *dictionary) {
        TestZYUserDefaultsViewController *vc = [[TestZYUserDefaultsViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    // 检查有没有保存的控制器 如果有直接推出来
    Class classz = NSClassFromString(n_store.saveClass);
    if (classz) {
        UIViewController *vc = [[classz alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
