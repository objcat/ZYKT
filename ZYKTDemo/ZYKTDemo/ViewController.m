//
//  ViewController.m
//  ZYKitDemo
//
//  Created by objcat on 2023/8/3.
//

#import "ViewController.h"
#import <ZYKT/ZYKT.h>
#import <EHFormKit/EHFormKit.h>

@interface ViewController ()
@property (strong, nonatomic) EHFormTableView *tableView;
@end

@implementation ViewController

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
    
    [self.tableView addNormalRowWithName:@"EHFormKit" value:@"快速构建表单" cellClass:[EHTapTableViewCell class] rowHeight:44 callBack:^(EHFormModel *model, EHFormModelEventType eventType, NSDictionary *dictionary) {
        
    }];
}

@end
