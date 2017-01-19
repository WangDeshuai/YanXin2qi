//
//  ThiredVC.m
//  YanXin
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ThiredVC.h"

@interface ThiredVC ()

@end

@implementation ThiredVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIWebView * web =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, KUAN, GAO-64)];
    
    NSURL *url=[NSURL URLWithString:_urlStr];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    [web setScalesPageToFit:YES];
    [web loadRequest:request];
    [self.view addSubview:web];
    
    
    
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
