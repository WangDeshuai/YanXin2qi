//
//  LZQStratViewController_25.m
//  SupperSupper
//
//  Created by qianfeng on 15/9/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LZQStratViewController_25.h"
#import "ViewController.h"
#define SCR_W [UIScreen mainScreen].bounds.size.width
#define SCR_H [UIScreen mainScreen].bounds.size.height

@interface LZQStratViewController_25 () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    
    UIButton *_btn;
}
@end

@implementation LZQStratViewController_25

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSrollView];
  //  [self addTimer];
    
    [self addBtn];
}

- (void)addSrollView{
    //初始化滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H)];
    //设置滚动视图区域
    _scrollView.contentSize = CGSizeMake(SCR_W * 3, SCR_H);
    NSMutableArray * starArr = [[NSMutableArray alloc]initWithObjects:@"star1",@"star2",@"star3", nil];
    for (int i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCR_W * i , 0, SCR_W, SCR_H)];
       // imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        imageView.image=[UIImage imageNamed:starArr[i]];
        
        [_scrollView addSubview:imageView];
    }
    //设置分页显示，一页的宽度是我们视图的宽度
    _scrollView.pagingEnabled = YES;
    //设置滚动风格
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
          //  UIScrollViewIndicatorStyleDefault, // 黑色
          //  UIScrollViewIndicatorStyleBlack,   // 黑色
          //  UIScrollViewIndicatorStyleWhite    // 白色
    
    //隐藏水平导航栏
    _scrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    _scrollView.delegate = self;
    _scrollView.bounces=NO;
    [self.view addSubview:_scrollView];
    
    
        
    
    //分页控制器（小圆点－－位置）
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCR_H - 60, SCR_W, 40)];
    _pageControl.backgroundColor = [UIColor redColor];
    //设置小圆点个数
    _pageControl.numberOfPages = 3;
    //[self.view addSubview:_pageControl];
}


- (void)addBtn{
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_W * 2 + SCR_W / 2-75, 530*GAO/667, 150, 77*150/300)];
    
    [_btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [_btn setBackgroundImage:[UIImage imageNamed:@"立即体验"] forState:0];
    [_scrollView addSubview:_btn];
}

- (void)clickBtn{
    //当用户点击进入App的时候，会记录一下
    [[NSUserDefaults standardUserDefaults] setObject:@"APPSTAR" forKey:@"star"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    ViewController * vc = [[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
#pragma mark - 只要视图滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //设置_pageControl当前小圆点的位置
    _pageControl.currentPage = _scrollView.contentOffset.x / SCR_W;
}

#pragma mark - 移除
- (void)dealloc
{
    // 移除定时器
    [_timer invalidate];
    _timer = nil;
}
@end
