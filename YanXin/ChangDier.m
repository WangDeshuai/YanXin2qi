//
//  ChangDier.m
//  YanXin
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChangDier.h"
#import "HuiYiShiViewController.h"
#import "KeFangVC.h"
#import "TanKuangVC.h"
#import "TanKuang2.h"
@interface ChangDier ()<UIScrollViewDelegate>
{
    UIView *linView1;
    UIView *linView2;
    TanKuangVC * tvc;
    TanKuang2 * tvc2;
    UIView * huiView;
}
@property (nonatomic,retain)UIScrollView * scrollView;
@end

@implementation ChangDier

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets=YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    self.title=_model.titleName;
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    _scrollView.delegate=self;
    _scrollView.tag=10;
    _scrollView.bounces=NO;
    _scrollView.contentSize=CGSizeMake(KUAN, GAO+240);
    _scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;


    
    
    
    UIView * bgView =[[UIView alloc]init];

    UIImageView *imageView=[[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_model.imageName] placeholderImage:[UIImage imageNamed:@"changdi"]];
    imageView.image=[self compressImageWith:imageView.image width:KUAN height:222];
    
    UIImageView *imageView2 =[[UIImageView alloc]init];
    imageView2.image=[UIImage imageNamed:@"phone2"];
    
    UILabel * label =[[UILabel alloc]init];
    label.text=_model.dizhi;
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:18];
    
    UIButton * xiangLab =[UIButton new];
    [xiangLab setTitle:@"详细>>" forState:0];
    [xiangLab setTitleColor:[UIColor blackColor] forState:0];
    [xiangLab addTarget:self action:@selector(xiangxi) forControlEvents:UIControlEventTouchUpInside];
    xiangLab.titleLabel.font=[UIFont systemFontOfSize:13];
    
    
    UIButton *btn1 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag=11;
    [btn1 addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"会议室" forState:0];
    btn1.selected=YES;
    _lastBtn=btn1;

    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    [btn1 setTitleColor:[UIColor colorWithRed:29/255.0 green:174/255.0 blue:231/255.0 alpha:1] forState:UIControlStateSelected];
    
    UIButton *btn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.tag=12;
    [btn2 addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"客房" forState:0];
    [btn2 setTitleColor:[UIColor colorWithRed:29/255.0 green:174/255.0 blue:231/255.0 alpha:1] forState:UIControlStateSelected];
    [btn2 setTitleColor:[UIColor blackColor] forState:0];

    
    linView1 =[[UIView alloc]init];
    linView1.backgroundColor=[UIColor colorWithRed:29/255.0 green:174/255.0 blue:231/255.0 alpha:1];
    linView2 =[[UIView alloc]init];
    linView2.hidden=YES;
    linView2.backgroundColor=[UIColor colorWithRed:29/255.0 green:174/255.0 blue:231/255.0 alpha:1];
    [_scrollView sd_addSubviews:@[bgView]];
    [bgView sd_addSubviews:@[imageView,imageView2,label,btn1,btn2,linView1,linView2,xiangLab]];
    
    bgView.sd_layout
    .topSpaceToView(_scrollView,0)
    .leftSpaceToView(_scrollView,0)
    .rightSpaceToView(_scrollView,0)
    .heightIs(340);
    
    
    imageView.sd_layout
    .topSpaceToView(bgView,0)
    .leftSpaceToView(bgView,0)
    .rightSpaceToView(bgView,0)
    .heightIs(222);
    
    imageView2.sd_layout
    .leftSpaceToView(bgView,18)
    .topSpaceToView(imageView,10)
    .widthIs(8)
    .heightIs(45);
    
    label.sd_layout
    .leftSpaceToView(imageView2,28)
    .rightSpaceToView(bgView,70)
    .heightIs(50)
    .topEqualToView(imageView2);
    
    xiangLab.sd_layout
    .leftSpaceToView(label,0)
    .rightSpaceToView(bgView,15)
    .heightIs(25)
    .topSpaceToView(imageView,30);
    
    
    
    
    btn1.sd_layout
    .leftSpaceToView(bgView,0)
    .widthIs(KUAN/2)
    .heightIs(35)
    .topSpaceToView(label,20);
    btn2.sd_layout
    .leftSpaceToView(btn1,0)
    .rightSpaceToView(bgView,0)
    .topEqualToView(btn1)
    .heightRatioToView(btn1,1);
    
    linView1.sd_layout
    .topSpaceToView(btn1,0)
    .widthRatioToView(btn1,1)
    .heightIs(2)
    .leftEqualToView(btn1);
    
    linView2.sd_layout
    .topSpaceToView(btn2,0)
    .widthRatioToView(btn2,1)
    .heightIs(2)
    .leftEqualToView(btn2);
    
    HuiYiShiViewController *hvc =[[HuiYiShiViewController alloc]init];
    hvc.view.frame=CGRectMake(0, 340, KUAN, GAO);
    hvc.dataArray=_model.huiyishi;
   
    hvc.pswNameBlock=^(NSInteger number){
        tvc2 =[TanKuang2 new];
        _scrollView.contentOffset=CGPointMake(0, 0);
        [_scrollView addSubview:huiView];
        _scrollView.scrollEnabled=NO;
        tvc2.dic=_model.huiyishi[number];
        tvc2.view.frame=CGRectMake(20,GAO/4, KUAN-40, GAO/2);
        [_scrollView addSubview:tvc2.view];
        [self addChildViewController:tvc2];
       
    };
    [self addChildViewController:hvc];
    [_scrollView addSubview:hvc.view];

    KeFangVC *kvc =[KeFangVC new];
    kvc.dataArray1=_model.kefang;
    kvc.pswNameBlock=^(NSInteger number){
        tvc2 =[TanKuang2 new];
        _scrollView.contentOffset=CGPointMake(0, 0);
        [_scrollView addSubview:huiView];
        _scrollView.scrollEnabled=NO;
        tvc2.dic=_model.kefang[number];
        tvc2.view.frame=CGRectMake(20,GAO/4, KUAN-40, GAO/2);
        [_scrollView addSubview:tvc2.view];
        [self addChildViewController:tvc2];
        
    };
    
    
    
    
    kvc.view.frame=CGRectMake(0, 340, KUAN, GAO);
    [self addChildViewController:kvc];
   
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lianjie)];
    [_scrollView addGestureRecognizer:tap];
  
    tvc =[[TanKuangVC alloc]init];
    tvc.model=_model;
    huiView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    huiView.backgroundColor=[UIColor grayColor];
    huiView.alpha=.7;
    
}
-(void)backClink
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIImage *)compressImageWith:(UIImage *)image width:(float)width height:(float)height
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //[newImage retain];
    [newImage copy];
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

-(void)lianjie
{
    _scrollView.scrollEnabled=YES;
    [tvc.view removeFromSuperview];
    [tvc2.view removeFromSuperview];
    [huiView removeFromSuperview];
   
}
-(void)xiangxi
{
    [_scrollView addSubview:huiView];
    _scrollView.scrollEnabled=NO;
    _scrollView.contentOffset=CGPointMake(0, 0);
    tvc.view.frame=CGRectMake(20, 150, KUAN-40, GAO-350);
    [_scrollView addSubview:tvc.view];
    [self addChildViewController:tvc];

}
-(void)buttonClink:(UIButton*)button
{
     UIViewController *vc = self.childViewControllers[button.tag-11];
    _lastBtn.selected=NO;
    button.selected=YES;
    _lastBtn=button;
     [_scrollView addSubview:vc.view];
    if (button.tag==11) {
        
        linView1.hidden=NO;
        linView2.hidden=YES;
    }else if(button.tag==12)
    {
       
        linView1.hidden=YES;
        linView2.hidden=NO;
    }

}
-(void)SaveBtn
{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",(int)scrollView.contentOffset.y] forKey:@"key1"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification1" object:nil userInfo:dic];
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
