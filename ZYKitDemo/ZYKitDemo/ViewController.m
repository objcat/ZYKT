//
//  ViewController.m
//  ZYKitDemo
//
//  Created by objcat on 2023/8/3.
//

#import "ViewController.h"
#import <ZYKit/ZYKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Student *student = [[Student alloc] init];
    NSLog(@"%@", student);
}

@end
