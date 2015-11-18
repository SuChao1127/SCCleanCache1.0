//
//  ViewController.m
//  SCCleanCache
//
//  Created by dllo on 15/11/18.
//  Copyright © 2015年 SC. All rights reserved.
//

#import "ViewController.h"
#import "SCCleanCache.h"
@interface ViewController ()
@property(nonatomic, retain)UIAlertController *alertController;//提示框
@property(nonatomic, retain)UIButton *button; //点击button
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化Button
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(100, 50, 175, 50);
    _button.layer.borderWidth = 2.0;
    //计算缓存大小添加到 Button 的标题上
    [_button setTitle:[NSString stringWithFormat:@"%.2fM", [SCCleanCache folderSizeAtPath:[SCCleanCache getCachesPath:@"Caches"]]] forState:UIControlStateNormal];
    [self.view addSubview:_button];
    //为 Button 添加清理缓存的方法
    [_button addTarget:self action:@selector(cleanAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 清理缓存
- (void)cleanAction
{
    //初始化提示框
    self.alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定清楚缓存吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //清理缓存
       [SCCleanCache cleanCaches:[SCCleanCache getCachesPath:@"Caches"]];
        //再次计算缓存大小添加到 Button 的标题上
       [_button setTitle:[NSString stringWithFormat:@"%.2fM", [SCCleanCache folderSizeAtPath:[SCCleanCache getCachesPath:@"Caches"]]] forState:UIControlStateNormal];
    }];
    [_alertController addAction:action1];
    [_alertController addAction:action2];
    [self presentViewController:_alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
