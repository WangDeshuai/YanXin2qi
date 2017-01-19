//
//  YanYuanKongJian.m
//  YanXin
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YanYuanKongJian.h"
#import "JiBenXinXinViewController.h"
#import "HotViewController.h"
#import "XiangCeVC.h"
#import "WhoYanYuanModel.h"
#import "UIImageView+LBBlurredImage.h"
#import "WhoYanYuanModel.h"
//#import "TouSu1.h"
@interface YanYuanKongJian ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollerView;
    WhoYanYuanModel * model;
    UIView * linView1;
    UIView * linView2;
    UIView * linView3;
}
@end

@implementation YanYuanKongJian
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
   
    _scrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    _scrollerView.delegate=self;
    
    _scrollerView.contentSize=CGSizeMake(KUAN, GAO+200);
    _scrollerView.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    [self.view addSubview:_scrollerView];
    
    UIView * bgView =[[UIView alloc]init];
    bgView.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    bgView.frame=CGRectMake(0, 0, KUAN, 260);
    [_scrollerView addSubview:bgView];
   
    UIImageView *imageView=[[UIImageView alloc]init];
    UIImageView * linImage=[UIImageView new];
    UILabel * userLabel=[UILabel new];
    NSString * dianhua =nil;
    if (_phone1==nil) {
//        dianhua=_model12.who;
    }else{
        dianhua=_phone1;
    }
   
    
    [ShuJuModel whoWithYanyuan:dianhua success:^(NSDictionary *dic) {
        NSDictionary * contentDic =[dic objectForKey:@"content"];
        model=[[WhoYanYuanModel alloc]initWithDic:contentDic];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"头像占位图" ]];
      
      UIImage * ima=  [self compressImageWith:imageView.image width:KUAN height:220];
        imageView.image=ima;
        
        [imageView setImageToBlur:imageView.image blurRadius:10 completionBlock:nil];
        [linImage sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"头像占位图" ]];
        userLabel.text=model.name;
    } error:^(NSError *error) {
        
    }];

    imageView.userInteractionEnabled=YES;
    imageView.frame=CGRectMake(0, 0, KUAN, 220);
    [bgView addSubview:imageView];
   
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 20, 30, 30);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回键"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:backBtn];
    
    UIButton * tousuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    tousuBtn.frame=CGRectMake(KUAN-40, 20, 30, 30);
    [tousuBtn addTarget:self action:@selector(tousu) forControlEvents:UIControlEventTouchUpInside];
    [tousuBtn setBackgroundImage:[UIImage imageNamed:@"tousu"] forState:0];
    NSString * sss =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    if ([sss isEqualToString:@"15032735032"]) {
        [imageView addSubview:tousuBtn];
    }
    
    
    
    
    linImage.layer.cornerRadius=40;
    linImage.clipsToBounds=YES;
  
    userLabel.adjustsFontSizeToFitWidth=YES;
    
    userLabel.textColor=[UIColor whiteColor];
    userLabel.textAlignment=1;
    userLabel.font=[UIFont systemFontOfSize:18];
    
    [imageView sd_addSubviews:@[linImage,userLabel]];
    linImage.sd_layout
    .topSpaceToView(imageView,50)
    .centerXEqualToView(imageView)
    .widthIs(80)
    .heightIs(80);
    
    userLabel.sd_layout
    .topSpaceToView(linImage,20)
    .leftEqualToView(linImage)
    .widthIs(80)
    .heightIs(30);
    
   
    
    UIButton * btn1 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.tag=11;
    btn1.selected=YES;
    _lastBtn=btn1;
    [btn1 setTitle:@"信息" forState:0];
    [btn1 setTitleColor:[UIColor blackColor] forState:0];
    UIButton * btn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.tag=12;
    [btn2 setTitle:@"动态" forState:0];
    [btn2 setTitleColor:[UIColor blackColor] forState:0];
    UIButton * btn3 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.tag=13;
    [btn3 setTitle:@"相册" forState:0];
    [btn3 setTitleColor:[UIColor blackColor] forState:0];
    [btn1 addTarget:self action:@selector(buttonclint:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(buttonclint:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(buttonclint:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor colorWithRed:27/255.0 green:176/255.0 blue:229/255.0 alpha:1] forState:UIControlStateSelected];
    [btn2 setTitleColor:[UIColor colorWithRed:27/255.0 green:176/255.0 blue:229/255.0 alpha:1] forState:UIControlStateSelected];
    [btn3 setTitleColor:[UIColor colorWithRed:27/255.0 green:176/255.0 blue:229/255.0 alpha:1] forState:UIControlStateSelected];
    btn1.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    btn2.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    btn3.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    
    linView1 =[UIView new];
    linView1.backgroundColor=[UIColor colorWithRed:27/255.0 green:176/255.0 blue:229/255.0 alpha:1];
    linView2 =[UIView new];
    linView2.backgroundColor=[UIColor colorWithRed:27/255.0 green:176/255.0 blue:229/255.0 alpha:1];
    linView3 =[UIView new];
    linView3.backgroundColor=[UIColor colorWithRed:27/255.0 green:176/255.0 blue:229/255.0 alpha:1];
    [bgView sd_addSubviews:@[btn1,btn2,btn3,linView1,linView2,linView3]];
    
    linView2.hidden=YES;
    linView3.hidden=YES;
    
    
    btn1.sd_layout
    .topSpaceToView(imageView,0)
    .leftSpaceToView(bgView,0)
    .heightIs(30)
    .widthIs(KUAN/3);
    btn2.sd_layout
    .topSpaceToView(imageView,0)
    .leftSpaceToView(btn1,0)
    .heightIs(30)
    .widthIs(KUAN/3);
    btn3.sd_layout
    .topSpaceToView(imageView,0)
    .leftSpaceToView(btn2,0)
    .heightIs(30)
    .rightSpaceToView(bgView,0);
    
    linView1.sd_layout
    .leftEqualToView(btn1)
    .widthRatioToView(btn1,1)
    .topSpaceToView(btn1,0)
    .heightIs(2);
    linView2.sd_layout
    .leftEqualToView(btn2)
    .widthRatioToView(btn2,1)
    .topSpaceToView(btn2,0)
    .heightIs(2);
    linView3.sd_layout
    .leftEqualToView(btn3)
    .widthRatioToView(btn3,1)
    .topSpaceToView(btn3,0)
    .heightIs(2);
    
    JiBenXinXinViewController *hvc =[[JiBenXinXinViewController alloc]init];
    if(_phone1==nil){
       //  hvc.shui=_model12.who;
    }else
    {
        hvc.shui=_phone1;
    }
   
    hvc.view.frame=CGRectMake(0, 252, KUAN, GAO);
    [self addChildViewController:hvc];
    [_scrollerView addSubview:hvc.view];
    
    HotViewController *kvc =[HotViewController new];
    if(_phone1==nil){
       // kvc.shui=_model12.who;
    }else
    {
        kvc.shui=_phone1;
    }
    kvc.view.frame=CGRectMake(0, 252, KUAN, GAO);
    [self addChildViewController:kvc];
    
   
    XiangCeVC *xvc =[XiangCeVC new];
    xvc.DeLiSelf=self;
    if(_phone1==nil){
      //  xvc.shui=_model12.who;
    }else
    {
        xvc.shui=_phone1;
    }
    xvc.view.frame=CGRectMake(0, 252, KUAN, GAO);
    [self addChildViewController:xvc];
    
    
    
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
-(void)tousu
{
//    TouSu1 * ss =[TouSu1 new];
//    [self.navigationController pushViewController:ss animated:YES];
}
-(void)buttonclint:(UIButton*)button
{
    _lastBtn.selected=NO;
    button.selected=YES;
    _lastBtn=button;
     _scrollerView.scrollEnabled=YES;
    UIViewController *vc = self.childViewControllers[button.tag-11];
    [_scrollerView addSubview:vc.view];
    if (button.tag==11) {
        linView1.hidden=NO;
        linView2.hidden=YES;
        linView3.hidden=YES;
    }else if (button.tag==12){
        linView1.hidden=YES;
        linView2.hidden=NO;
        linView3.hidden=YES;
    }else if (button.tag==13){
        linView1.hidden=YES;
        linView2.hidden=YES;
        linView3.hidden=NO;
        _scrollerView.scrollEnabled=NO;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
   NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",(int)scrollView.contentOffset.y] forKey:@"key2"];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"pianyi" object:nil userInfo:dic];
}
-(void)backClink
{
    [self.navigationController popViewControllerAnimated:YES];
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
