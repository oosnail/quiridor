//
//  OORootViewController.m
//  quiridor
//
//  Created by 张天琛 on 2017/3/10.
//  Copyright © 2017年 ZTC. All rights reserved.
//

#import "OORootViewController.h"
#import "ViewController.h"
@interface OORootViewController ()
@end

@implementation OORootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    dispatch_sync(mainQueue,^{
//        NSLog(@"MainQueue");
//    });
    
    
    // Do any additional setup after loading the view.
    {
        UIButton*button = [[UIButton alloc]init];
        button.center = CGPointMake(kScreenWidth/2, kScreenHeight/3);
        button.bounds = CGRectMake(0, 0, 200, 40);
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"开始游戏" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(beginGame) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    {
        UIButton*button = [[UIButton alloc]init];
        button.center = CGPointMake(kScreenWidth/2, kScreenHeight/3+100);
        button.bounds = CGRectMake(0, 0, 200, 40);
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"游戏设置" forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
    
    {
        UIButton*button = [[UIButton alloc]init];
        button.center = CGPointMake(kScreenWidth/2, kScreenHeight/3+200);
        button.bounds = CGRectMake(0, 0, 200, 40);
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"游戏说明" forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
    
    
    
    
}

- (void)beginGame{
    ViewController *vc =[[ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
