//
//  FTestVC.m
//  Runner
//
//  Created by 冯文杰 on 2019/7/4.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "FTestVC.h"

@interface FTestVC ()

@end

@implementation FTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(10,100,100,100);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
    
    - (void)back{
        [self dismissViewControllerAnimated:true completion:nil];
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
