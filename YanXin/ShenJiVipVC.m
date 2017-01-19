//
//  ShenJiVipVC.m
//  YanXin
//
//  Created by Macx on 17/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ShenJiVipVC.h"

#import "CreatYanYuanZiLiaoVC.h"//填写演员资料
@interface ShenJiVipVC ()
@property(nonatomic,strong)UIView * bgView;
@end

@implementation ShenJiVipVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    
    _bgView=self.view;
    [self CreatLabel];
    
    
}

#pragma mark --创建控件
-(void)CreatLabel{
    
    
    //灰条
    UIImageView * image1 =[UIImageView new];
    image1.image=[UIImage imageNamed:@"vip_bg"];
    [_bgView sd_addSubviews:@[image1]];
    image1.sd_layout
    .leftSpaceToView(_bgView,0)
    .topSpaceToView(_bgView,40+64)
    .widthIs(229)
    .heightIs(29);
    
    
    //升级流程
    UIImageView * image2 =[UIImageView new];
    image2.image=[UIImage imageNamed:@"vip_yuan"];
    [_bgView sd_addSubviews:@[image2]];
    image2.sd_layout
    .leftSpaceToView(_bgView,20)
    .centerYEqualToView(image1)
    .widthIs(44)
    .heightIs(44);
    //laebl
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"升级流程";
    nameLabel.textColor=JXColor(0, 170, 238, 1);
    nameLabel.font=[UIFont systemFontOfSize:16];
    [_bgView sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(image2,20)
    .centerYEqualToView(image1)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:120];
    
   //完善个人资料
    UIImageView * image3 =[UIImageView new];
    image3.image=[UIImage imageNamed:@"vip_bt1"];
    [_bgView sd_addSubviews:@[image3]];
    image3.sd_layout
    .leftSpaceToView(_bgView,20)
    .topSpaceToView(image2,30)
    .widthIs(57)
    .heightIs(57);
    //完善个人资料label
    UILabel * nameLabel2 =[UILabel new];
    nameLabel2.text=@"完善个人信息\n信息越完善，宣传越全面";
    nameLabel2.font=[UIFont systemFontOfSize:13];
    nameLabel2.numberOfLines=2;
    nameLabel2.attributedText=[ToolClass attrStrFrom:nameLabel2.text intFond:16 Color:JXColor(255, 101, 101, 1) numberStr:@"完善个人信息"];
    [_bgView sd_addSubviews:@[nameLabel2]];
    nameLabel2.sd_layout
    .leftSpaceToView(image3,10)
    .centerYEqualToView(image3)
    .rightSpaceToView(_bgView,10)
    .autoHeightRatio(0);
   //实名认证
    UIImageView * image4 =[UIImageView new];
    image4.image=[UIImage imageNamed:@"vip_bt2"];
    [_bgView sd_addSubviews:@[image4]];
    image4.sd_layout
    .leftSpaceToView(_bgView,20+57)
    .topSpaceToView(nameLabel2,25)
    .widthIs(57)
    .heightIs(57);
    //实名认证label
    UILabel * nameLabel3 =[UILabel new];
    nameLabel3.text=@"完成实名认证\n实名认证成功，通过最终审核";
    nameLabel3.font=[UIFont systemFontOfSize:13];
    nameLabel3.numberOfLines=2;
    
    nameLabel3.attributedText=[ToolClass attrStrFrom:nameLabel3.text intFond:16 Color:JXColor(68, 188, 237, 1) numberStr:@"完成实名认证"];
    
    
    
    [_bgView sd_addSubviews:@[nameLabel3]];
    nameLabel3.sd_layout
    .leftSpaceToView(image4,10)
    .centerYEqualToView(image4)
    .rightSpaceToView(_bgView,10)
    .autoHeightRatio(0);
    
    
    //会员升级充值
    UIImageView * image5 =[UIImageView new];
    image5.image=[UIImage imageNamed:@"vip_bt3"];
    [_bgView sd_addSubviews:@[image5]];
    image5.sd_layout
    .leftEqualToView(image4)
    .topSpaceToView(image4,25)
    .widthIs(57)
    .heightIs(57);
    //会员升级充值label
    UILabel * nameLabel4 =[UILabel new];
    nameLabel4.text=@"会员升级充值\n会员充值成功，获得更多的财富";
    nameLabel4.font=[UIFont systemFontOfSize:13];
    nameLabel4.attributedText=[ToolClass attrStrFrom:nameLabel4.text intFond:16 Color:JXColor(101, 207, 114, 1) numberStr:@"会员升级充值"];
    nameLabel4.numberOfLines=2;
    [_bgView sd_addSubviews:@[nameLabel4]];
    nameLabel4.sd_layout
    .leftSpaceToView(image5,10)
    .centerYEqualToView(image5)
    .rightSpaceToView(_bgView,10)
    .autoHeightRatio(0);
    
    
    //后台审核成功
    UIImageView * image6 =[UIImageView new];
    image6.image=[UIImage imageNamed:@"vip_bt4"];
    [_bgView sd_addSubviews:@[image6]];
    image6.sd_layout
    .leftEqualToView(image3)
    .topSpaceToView(image5,25)
    .widthIs(57)
    .heightIs(57);
    //后台审核成功label
    UILabel * nameLabel5 =[UILabel new];
    nameLabel5.text=@"后台审核成功\n通过后台审核，获得唯一演信号，分享开启财富之门";
    nameLabel5.font=[UIFont systemFontOfSize:13];
    nameLabel5.numberOfLines=2;
    nameLabel5.attributedText=[ToolClass attrStrFrom:nameLabel5.text intFond:16 Color:JXColor(255, 121, 79, 1) numberStr:@"后台审核成功"];
    [_bgView sd_addSubviews:@[nameLabel5]];
    nameLabel5.sd_layout
    .leftSpaceToView(image6,10)
    .centerYEqualToView(image6)
    .rightSpaceToView(_bgView,10)
    .autoHeightRatio(0);

    UIButton * chuangJiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [chuangJiBtn setBackgroundImage:[UIImage imageNamed:@"vip_btt"] forState:0];
    [chuangJiBtn addTarget:self action:@selector(creatBtn) forControlEvents:UIControlEventTouchUpInside];
    [_bgView sd_addSubviews:@[chuangJiBtn]];
    
    chuangJiBtn.sd_layout
    .centerXEqualToView(_bgView)
    .topSpaceToView(nameLabel5,60)
    .widthIs(305)
    .heightIs(40);
}
#pragma mark --开始创建资料
-(void)creatBtn{
//    ChongZhiVC * vc =[ChongZhiVC new];
    CreatYanYuanZiLiaoVC * vc =[CreatYanYuanZiLiaoVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"升级会员";
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
