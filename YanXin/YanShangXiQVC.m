//
//  YanShangXiQVC.m
//  YanXin
//
//  Created by Macx on 17/1/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "YanShangXiQVC.h"
#import "SGTopTitleView.h"
#import "GongSiJianJieVC.h"
#import "SuccessAnLiViC.h"
@interface YanShangXiQVC ()<SGTopTitleViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * bgScrollView;
@property(nonatomic,strong)UIView * bgView;
@property (nonatomic, strong) SGTopTitleView *topTitleView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@end

@implementation YanShangXiQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
//    _bgScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight)];
//    _bgScrollView.backgroundColor=[UIColor redColor];
//    [self.view addSubview:_bgScrollView];
    _bgView=self.view;
   
      [self CreatImageView];
     [self setupChildViewController];
    self.titles = @[@"公司简介",@"成功案例"];
    self.topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(20, 64+216-22,ScreenWidth-40, 44)];
    _topTitleView.layer.cornerRadius=5;
    _topTitleView.clipsToBounds=YES;
    _topTitleView.staticTitleArr = [NSArray arrayWithArray:_titles];
    _topTitleView.backgroundColor=[UIColor whiteColor];
    _topTitleView.delegate_SG = self;
    [_bgView addSubview:_topTitleView];
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    
    [_bgView addSubview:_mainScrollView];
    
    GongSiJianJieVC *oneVC = [[GongSiJianJieVC alloc] init];
    oneVC.accountPhone=_accountPhone;
    [self.mainScrollView addSubview:oneVC.view];
    [self addChildViewController:oneVC];
    [_bgView insertSubview:_mainScrollView belowSubview:_topTitleView];

    
    
    
    
    
    
  
}
#pragma mark --创建图片标题
-(void)CreatImageView{
    UIImageView * headImage =[UIImageView new];
    //headImage.image=_titleImage;
    [headImage sd_setImageWithURL:[NSURL URLWithString:_titleImage] placeholderImage:[UIImage imageNamed:@"messege_bg"]];
    [_bgView sd_addSubviews:@[headImage]];
    headImage.sd_layout
    .centerXEqualToView(_bgView)
    .topSpaceToView(_bgView,54)
    .widthIs(ScreenWidth)
    .heightIs(216);
    
    
    
    
}
#pragma mark - - - SGTopScrollMenu代理方法
- (void)SGTopTitleView:(SGTopTitleView *)topTitleView didSelectTitleAtIndex:(NSInteger)index{
    
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}
// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

// 添加所有子控制器
- (void)setupChildViewController {
    
    GongSiJianJieVC *oneVC = [[GongSiJianJieVC alloc] init];
     oneVC.accountPhone=_accountPhone;
    [self addChildViewController:oneVC];
    
    
    SuccessAnLiViC *twoVC = [[SuccessAnLiViC alloc] init];
     twoVC.accountPhone=_accountPhone;
    [self addChildViewController:twoVC];
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topTitleView.allTitleLabel[index];
    
    // 3.滚动时，改变标题选中
    [self.topTitleView staticTitleLabelSelecteded:selLabel];
    
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
#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=_titleName;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    //返回按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
}
-(void)backClink{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
