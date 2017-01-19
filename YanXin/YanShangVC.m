//
//  YanShangVC.m
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "YanShangVC.h"
#import "ChildVC.h"
#import "ChangDiVC.h"
#import "SheBeiVC.h"
#import "YanShangSouSuoVC.h"
@interface YanShangVC ()<UIScrollViewDelegate>
{
    UISegmentedControl*segmentedControl;
    //大的滚动视图
    UIScrollView * _bigScroller;
    UIView * linView;
    UIView * view1;
    NSMutableArray * _numberArr;
  
    UIButton *souBtn;
}
@end

@implementation YanShangVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    [self segmentedControl];
    //大的滚动视图
    [self scrollView1];
   
    ChildVC * cvc = [[ChildVC alloc]init];
    cvc.yeshu=3;
    cvc.view.frame=CGRectMake(0, 0, KUAN, GAO);
    [_bigScroller addSubview:cvc.view];
    [self addChildViewController:cvc];
    
    SheBeiVC * shebVC=[[SheBeiVC alloc]init];
    shebVC.yeshu=4;
    shebVC.view.frame=CGRectMake(KUAN, 0, KUAN, GAO);
    [self addChildViewController:shebVC];
    
    ChangDiVC *vccc=[[ChangDiVC alloc]init];
    vccc.yeshu=5;
    vccc.view.frame=CGRectMake(KUAN*2, 0, KUAN, GAO);
    [self addChildViewController:vccc];

   
   
    
    
}



////大的滚动视图
-(void)scrollView1
{   _bigScroller =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KUAN, GAO-46-64)];
    _bigScroller.delegate=self;
    _bigScroller.pagingEnabled=YES;
    _bigScroller.contentSize=CGSizeMake(KUAN*3, GAO-64-46);
    [self.view addSubview:_bigScroller];
    
}- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 根据滚动视图的偏移量,计算当前所在的点
    int i = scrollView.contentOffset.x/KUAN;
    UIButton * button =(UIButton*)[view1 viewWithTag:i+1];
    [self upDataWeb1:button];
}







-(void)segmentedControl
{
    
    view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 64)];
    view1.backgroundColor=DAO_COLOR;
    [self.view addSubview:view1];
    
    souBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    souBtn.frame=CGRectMake(KUAN-36, 33,20, 20);
    [souBtn setBackgroundImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateNormal];
    [souBtn addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:souBtn];



    
    
    NSArray * arr = [[NSArray alloc]initWithObjects:@"演出公司",@"演出设备",@"演出场地", nil];
    
    int k =80;
    int sc =ScreenWidth-36;
    int d =(sc-k*3)/4;
    for (int i=0; i<arr.count; i++) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:arr[i] forState:0];
        [button setTitleColor:JXColor(220, 220, 220, 1)   forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [view1 sd_addSubviews:@[button]];
        
        button.sd_layout
        .leftSpaceToView(view1,d+10+(d+k)*i)
        .centerYEqualToView(souBtn)
        .widthIs(k)
        .heightIs(20);
        button.tag=i+1;
        [button addTarget:self action:@selector(upDataWeb1:) forControlEvents:UIControlEventTouchUpInside];
        //        [view1 addSubview:button ];
        if (i == 0)
        {
            // 获取第一个button的标题
            linView = [[UIView alloc]init];
            linView.backgroundColor = [UIColor whiteColor];
             [view1 sd_addSubviews:@[linView]];
            linView.sd_layout
            .leftEqualToView(button)
            .rightEqualToView(button)
            .topSpaceToView(button,5)
            .heightIs(2);
           
            button.selected=YES;
            _lastBtn=button;
                   
            }

        
        
    }
    

}
-(void)upDataWeb1:(UIButton*)button
{
    _lastBtn.selected=NO;
    button.selected=YES;
    _lastBtn=button;
    [view1 sd_addSubviews:@[linView]];
    linView.sd_layout
    .leftEqualToView(button)
    .rightEqualToView(button)
    .topSpaceToView(button,5)
    .heightIs(2);
    _bigScroller.contentOffset=CGPointMake(ScreenWidth*(button.tag-1), 0);
    if (button.tag==1) {
        ChildVC * chivc = self.childViewControllers[0];
        [_bigScroller addSubview:chivc.view];
    }
    if (button.tag==2) {
        SheBeiVC * shebe = self.childViewControllers[1];
        [_bigScroller addSubview:shebe.view];
    }
  
    if (button.tag==3) {
        ChangDiVC * aa =self.childViewControllers[2];
        [_bigScroller addSubview:aa.view];
    }

}
//右按钮
-(void)sousuo
{
    YanShangSouSuoVC * yanVC=[[YanShangSouSuoVC alloc]init];
    [self.navigationController pushViewController:yanVC animated:YES];
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
