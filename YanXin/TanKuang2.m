//
//  TanKuang2.m
//  YanXin
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TanKuang2.h"

@interface TanKuang2 ()

@end

@implementation TanKuang2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor greenColor];
  //  NSLog(@"我是弹框2》》》%@",_dic);
    self.view.backgroundColor=[UIColor whiteColor];
    self.view.layer.cornerRadius=10;
    self.view.clipsToBounds=YES;
  //  NSLog(@"%@",[_dic objectForKey:@"name"]);
    UIImageView * imageview =[UIImageView new];
   // imageview.backgroundColor=[UIColor redColor];
  //  NSLog(@">>>%@",[_dic objectForKey:@"imgurl"]);
    [imageview sd_setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"imgurl"]] placeholderImage:[UIImage imageNamed:@"主题背景"]];
//
    UIView * linview =[UIView new];
    linview.backgroundColor=[UIColor grayColor];
//
    UILabel * nameLab =[UILabel new];
    nameLab.text=[_dic objectForKey:@"name"];
//
    UILabel * mianj =[UILabel new];
    NSLog(@"面积%@",[_dic objectForKey:@"area"]);
    mianj.text=[NSString stringWithFormat:@"面积%@m³",[_dic objectForKey:@"area"]];
    mianj.font=[UIFont systemFontOfSize:14];
    mianj.alpha=.7;
//
    UILabel * renshu =[UILabel new];
    renshu.text=[NSString stringWithFormat:@"能容纳%@人",[_dic objectForKey:@"capcity"]];
    renshu.font=[UIFont systemFontOfSize:14];
    renshu.alpha=.7;
//
    UILabel * jiage =[UILabel new];
    jiage.text=[NSString stringWithFormat:@"¥%@",[_dic objectForKey:@"price"]];
    jiage.font=[UIFont systemFontOfSize:14];
    jiage.alpha=.7;
//
    [self.view sd_addSubviews:@[imageview,linview,nameLab,mianj,renshu,jiage]];

    imageview.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(GAO/3);
    
    linview.sd_layout
    .topSpaceToView(imageview,5)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(1);

    nameLab.sd_layout
    .topSpaceToView(linview,10)
    .leftSpaceToView(self.view,5)
    .autoWhiteRatio(0)
    .heightIs(20);
    mianj.sd_layout
    .topSpaceToView(nameLab,10)
    .leftEqualToView(nameLab)
    .autoWhiteRatio(0)
    .heightIs(20);
    
    renshu.sd_layout
    .topEqualToView(mianj)
    .leftSpaceToView(mianj,10)
    .autoWhiteRatio(0)
    .heightIs(20);
    
    
    jiage.sd_layout
    .topEqualToView(renshu)
    .leftSpaceToView(renshu,10)
    .autoWhiteRatio(0)
    .heightIs(20);
    
    
    
    
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
