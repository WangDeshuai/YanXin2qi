//
//  Custom.m
//  YanXin
//
//  Created by mac on 16/2/19.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "Custom.h"

@implementation Custom
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        _nameLab=[UILabel new];
        
        _lineImage=[UIImageView new];
        _lineImage.image=[UIImage imageNamed:@"11.jpg"];
        _jianJieLab=[UILabel new];
        _jianJieLab.textColor=[UIColor colorWithRed:75/255.0 green:75/255.0  blue:75/255.0  alpha:.7];
        _jianJieLab.numberOfLines=3;
        _jianJieLab.font=[UIFont systemFontOfSize:13];
        _VIPImage =[UIImageView new];
        _renZhengImage=[UIImageView new];
        _renZhengImage.image=[UIImage imageNamed:@"qyrz"];
        [self.contentView sd_addSubviews:@[_nameLab,_lineImage,_jianJieLab,_VIPImage,_renZhengImage]];
        
        _lineImage.sd_layout
        .topSpaceToView(self.contentView,20)
        .leftSpaceToView(self.contentView,15)
        .widthIs(100)
        .heightIs(100);
        
        _nameLab.sd_layout
        .topEqualToView(_lineImage)
        .leftSpaceToView(_lineImage,10)
        .heightIs(30);
      [_nameLab setSingleLineAutoResizeWithMaxWidth:250];
        _renZhengImage.sd_layout
        .leftEqualToView(_nameLab)
        .topSpaceToView(_nameLab,5)
        .widthIs(43)
        .heightIs(14);
        
        _VIPImage.sd_layout
        .leftSpaceToView(_renZhengImage,10)
        .centerYEqualToView(_renZhengImage)
        .widthIs(40)
        .heightIs(14);
        
        _jianJieLab.sd_layout
        .topSpaceToView(_renZhengImage,5)
        .leftEqualToView(_nameLab)
        .rightSpaceToView(self.contentView,30)
        .heightIs(40);
        [self setupAutoHeightWithBottomView:_jianJieLab bottomMargin:10];
        // Initialization code
    }
    return self;
}

-(void)setModel:(YanShangModel *)model
{
    _model=model;
    [_lineImage sd_setImageWithURL:[NSURL URLWithString:model.headImageUrl] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    _nameLab.text=model.title;
    
    
    CGFloat  fl = [ShuJuModel getWidthWithFontSize:17 height:30 string:model.title];
    if(fl>self.contentView.frame.size.width-120)
    {
        fl=self.contentView.frame.size.width-150;
    }
    _nameLab.sd_layout.widthIs(fl);
    
//    if ([model.renZheng isEqualToString:@"0"]) {
//        //没有认证
//        _renZhengImage.hidden=YES;
//        _VIPImage.sd_layout
//        .leftEqualToView(_nameLab)
//        .topSpaceToView(_nameLab,5);
//    }else{
//        _renZhengImage.hidden=NO;
//    }
    _VIPImage.image=model.vipImage;
    
    
    //屏蔽支付宝功能
//    [ShuJuModel huoquVipTubiaosuccess:^(NSDictionary *dic) {
//        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
//        if ([code isEqualToString:@"0"]) {
//            
//        }else{
//            [_VIPImage sd_setImageWithURL:[NSURL URLWithString:model.imageVIPName]];
//            if ([model.viplevel isEqualToString:@"3"]) {
//                _nameLab.textColor=[UIColor colorWithRed:184/255.0 green:36/255.0 blue:232/255.0 alpha:1];
//            }else if ([model.viplevel isEqualToString:@"2"]){
//                _nameLab.textColor=[UIColor colorWithRed:228/255.0 green:43/255.0 blue:23/255.0 alpha:1];
//                
//            }else if([model.viplevel isEqualToString:@"1"]){
//                _nameLab.textColor=[UIColor colorWithRed:208/255.0 green:163/255.0 blue:99/255.0 alpha:1];
//            }else{
//                _nameLab.textColor=[UIColor blackColor];
//            }
//
//        }
//        
//        
//    } error:nil];
    
    
    
    
    _jianJieLab.text=model.content;
}




//-(void)setFrame:(CGRect)frame
//{
//    
//    frame.origin.y+=10;
//    frame.size.height-=10;
//    frame.origin.x+=10;
//    frame.size.width-=20;
//    [super setFrame:frame ];
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
