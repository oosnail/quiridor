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
    
    UITableView*view;
    view.rowHeight;
    
}

- (void)beginGame{
    ViewController *vc =[[ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [UIView transitionFromView:self.view toView:vc.view duration:1.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
