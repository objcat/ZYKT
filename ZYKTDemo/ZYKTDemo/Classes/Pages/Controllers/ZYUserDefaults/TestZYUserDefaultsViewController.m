//
//  TestZYUserDefaultsViewController.m
//  ZYKTDemo
//
//  Created by objcat on 2023/8/25.
//

#import "TestZYUserDefaultsViewController.h"
#import <EHFormKit/EHFormKit.h>

@interface TestZYUserDefaultsViewController ()
@property (strong, nonatomic) EHFormTableView *tableView;
@end

@implementation TestZYUserDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [EHFormTableView tableView];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addNormalRowWithName:@"标准值测试" value:@"" cellClass:[EHTapTableViewCell class] rowHeight:44 callBack:^(EHFormModel *model, EHFormModelEventType eventType, NSDictionary *dictionary) {
        NSLog(@"%@", x_store.class);
        e_store.env = ZYEnvironmentProd;
        x_store.testString = @"123";
        x_store.testNumber = @(666);
        x_store.testArray = @[@"1", @"2", @"3"];
        x_store.testMutableArray = x_store.testArray.mutableCopy;
        x_store.testDictionary = @{@"name": @"张三", @"age": @"18"};
        x_store.testMutableDictionary = x_store.testDictionary.mutableCopy;
        x_store.testData = [[NSData alloc] init];
        x_store.testMutableData = [[NSMutableData alloc] init];
        x_store.testDate = NSDate.date;
        x_store.testTimeInterval = 1;
        x_store.testInteger = 1;
        x_store.testUInteger = 2;
        x_store.testInt = 1;
        x_store.testLong = 11;
        x_store.testFloat = 0.2;
        x_store.testDouble = 0.22;
        x_store.testCGFloat = 0.222;
        x_store.testBool = YES;
        x_store.testBoolean = true;
        NSLog(@"%@", x_store);
    }];
    
    [self.tableView addNormalRowWithName:@"空值测试" value:@"" cellClass:[EHTapTableViewCell class] rowHeight:44 callBack:^(EHFormModel *model, EHFormModelEventType eventType, NSDictionary *dictionary) {
        x_store.testString = nil;
        x_store.testNumber = nil;
        x_store.testArray = nil;
        x_store.testMutableArray = nil;
        x_store.testDictionary = nil;
        x_store.testMutableDictionary = nil;
        x_store.testData = nil;
        x_store.testMutableData = nil;
        x_store.testDate = nil;
        x_store.testTimeInterval = 0;
        x_store.testInteger = nil;
        x_store.testUInteger = nil;
        x_store.testInt = 0;
        x_store.testLong = 0;
        x_store.testFloat = 0;
        x_store.testDouble = 0;
        x_store.testCGFloat = 0;
        x_store.testBool = nil;
        x_store.testBoolean = nil;
        NSLog(@"%@", x_store);
    }];
    
    [self.tableView addNormalRowWithName:@"NSNull测试" value:@"" cellClass:[EHTapTableViewCell class] rowHeight:44 callBack:^(EHFormModel *model, EHFormModelEventType eventType, NSDictionary *dictionary) {
        x_store.testString = [NSNull null];
        x_store.testNumber = [NSNull null];
        x_store.testArray = [NSNull null];
        x_store.testMutableArray = [NSNull null];
        x_store.testDictionary = [NSNull null];
        x_store.testMutableDictionary = [NSNull null];
        x_store.testData = [NSNull null];
        x_store.testMutableData = [NSNull null];
        x_store.testDate = [NSNull null];
        x_store.testTimeInterval = 0;
        x_store.testInteger = [NSNull null];
        x_store.testUInteger = [NSNull null];
        x_store.testInt = [NSNull null];
        x_store.testLong = 0;
        x_store.testFloat = 0;
        x_store.testDouble = 0;
        x_store.testCGFloat = 0;
        x_store.testBool = [NSNull null];
        x_store.testBoolean = [NSNull null];
        NSLog(@"%@", x_store);
    }];
    
    [self.tableView addNormalRowWithName:@"清理数据" value:@"" cellClass:[EHTapTableViewCell class] rowHeight:44 callBack:^(EHFormModel *model, EHFormModelEventType eventType, NSDictionary *dictionary) {
        x_store.clean;
        NSLog(@"%@", x_store);
    }];
    
    [self.tableView addNormalRowWithName:@"打印数据" value:@"" cellClass:[EHTapTableViewCell class] rowHeight:44 callBack:^(EHFormModel *model, EHFormModelEventType eventType, NSDictionary *dictionary) {
        NSLog(@"%@", x_store);
    }];
    
}

@end
