//
//  TanKuangVC.m
//  YanXin
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TanKuangVC.h"

@interface TanKuangVC ()

@end

@implementation TanKuangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.layer.cornerRadius=10;
    self.view.clipsToBounds=YES;
    
    UILabel * titleLabel =[UILabel new];
    titleLabel.text=@"公司简介";
    titleLabel.font=[UIFont systemFontOfSize:19];
    titleLabel.textColor=[UIColor colorWithRed:38/255.0 green:182/255.0 blue:240/255.0 alpha:1];
    UILabel * jianJieLab =[UILabel new];
    jianJieLab.text=_model.jianJie;
    jianJieLab.font=[UIFont systemFontOfSize:15];
    
    UILabel * lianXiLabel= [UILabel new];
    lianXiLabel.text=@"联系方式";
    lianXiLabel.font=[UIFont systemFontOfSize:19];
    lianXiLabel.textColor=[UIColor colorWithRed:38/255.0 green:182/255.0 blue:240/255.0 alpha:1];
    UILabel * name =[UILabel new];
   
    UILabel * phone =[UILabel new];
    UILabel * dizhi =[UILabel new];
    name.font=[UIFont systemFontOfSize:15];
    phone.font=[UIFont systemFontOfSize:15];
    dizhi.font=[UIFont systemFontOfSize:15];
    name.text=[NSString stringWithFormat:@"联系人:%@",_model.name];
    phone.text=[NSString stringWithFormat:@"联系电话:%@",_model.phone];
    dizhi.text=[NSString stringWithFormat:@"公司地址:%@",_model.dizhi];
    [self.view sd_addSubviews:@[titleLabel,jianJieLab,lianXiLabel,name,phone,dizhi]];

    titleLabel.sd_layout
    .topSpaceToView(self.view,10)
    .leftSpaceToView(self.view,10)
    .widthIs(100)
    .heightIs(35);
    
    jianJieLab.sd_layout
    .topSpaceToView(titleLabel,5)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .autoHeightRatio(0);
    
    lianXiLabel.sd_layout
    .bottomSpaceToView(dizhi,65)
    .leftEqualToView(titleLabel)
    .widthRatioToView(titleLabel,1)
    .heightRatioToView(titleLabel,1);

    name.sd_layout
    .bottomSpaceToView(dizhi,35)
    .leftEqualToView(jianJieLab)
    .rightSpaceToView(self.view,10)
    .heightIs(25);
    
    phone.sd_layout
    .bottomSpaceToView(dizhi,5)
    .leftEqualToView(name)
    .rightEqualToView(name)
    .heightIs(25);

    dizhi.sd_layout
    .bottomSpaceToView(self.view,20)
    .leftEqualToView(phone)
    .rightEqualToView(phone)
    .heightIs(25);
   
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
