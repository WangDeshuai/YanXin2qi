//
//  CuestmYanYuan.m
//  YanXin
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CuestmYanYuan.h"
@interface CuestmYanYuan()
@property(nonatomic,strong)UIImageView * shiMingImage;
@end
@implementation CuestmYanYuan



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lineImage=[UIImageView new];
        _lineImage.layer.cornerRadius=30;
        _lineImage.clipsToBounds=YES;
        
        _name=[UILabel new];
       
        _xingbieImage=[UIImageView new];
       
        _VIPimage = [UIImageView new];
        
        _shiMingImage=[UIImageView new];
        
        _zhiye=[UILabel new];
        _zhiye.backgroundColor=[UIColor whiteColor];
        _zhiye.textAlignment=1;
        _zhiye.font=[UIFont systemFontOfSize:14];
        _zhiye.textColor=DAO_COLOR;
        _zhiye.sd_cornerRadius=@(10);
        
        _zhiye.layer.borderWidth=.5;
        _zhiye.layer.borderColor=DAO_COLOR.CGColor;
        
        
        _jianjie=[UILabel new];
        _jianjie.alpha=.6;
        _jianjie.font=[UIFont systemFontOfSize:14];
    [self.contentView sd_addSubviews:@[_lineImage,_name,_xingbieImage,_zhiye,_jianjie,_VIPimage,_shiMingImage]];
        //头像
        _lineImage.sd_layout
        .widthIs(60)
        .heightIs(60)
        .topSpaceToView(self.contentView,15)
        .leftSpaceToView(self.contentView,15);
      //姓名
        _name.sd_layout
        .topEqualToView(_lineImage)
        .leftSpaceToView(_lineImage,10)
        .heightIs(25);
        [_name setSingleLineAutoResizeWithMaxWidth:220];
        
        
        //实名认证
        _shiMingImage.sd_layout
        .leftSpaceToView(_name,5)
        .centerYEqualToView(_name)
        .widthIs(42)
        .heightIs(13);
        
        //vip图标
        _VIPimage.sd_layout
        .leftSpaceToView(_shiMingImage,5)
        .centerYEqualToView(_name)
        .widthIs(40)
        .heightIs(14);
        
        
       //性别
        _xingbieImage.sd_layout
        .leftEqualToView(_name)
        .topSpaceToView(_name,0)
        .widthIs(18)
        .heightIs(18);
        //职业
        _zhiye.sd_layout
        .leftSpaceToView(_xingbieImage,10)
        .topEqualToView(_xingbieImage)
        .heightIs(20);
       // [_zhiye setSingleLineAutoResizeWithMaxWidth:200];
        //内容
        _jianjie.sd_layout
        .leftEqualToView(_name)
        .rightSpaceToView(self.contentView,3)
        .topSpaceToView(_xingbieImage,0)
        .heightIs(25);
       
        [self setupAutoHeightWithBottomView:_jianjie bottomMargin:10];
        // Initialization code
    }
    return self;
}

-(void)setModel:(yanyuanModel *)model
{
    _model=model;
    _name.text=model.name;
    _jianjie.text=model.introduction;
    CGFloat  fl = [ShuJuModel getWidthWithFontSize:17 height:30 string:model.name];
    _name.sd_layout.widthIs(fl);
    
    NSString * str =[NSString stringWithFormat:@"啊%@",model.categoryname];
    CGFloat  zy = [ShuJuModel getWidthWithFontSize:14 height:30 string:str];
    
    _zhiye.text=model.categoryname;
    _zhiye.sd_layout.widthIs(zy);
    _xingbieImage.image=model.xingbieImage;
    if (model.shiMingImage==nil) {
        _shiMingImage.hidden=YES;
        //实名认证
        _VIPimage.sd_layout
        .leftSpaceToView(_name,5)
        .centerYEqualToView(_name)
        .widthIs(40)
        .heightIs(14);
    }else{
       _shiMingImage.image=model.shiMingImage;
    }
    
    [_lineImage sd_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholderImage:[UIImage imageNamed:@"头像占位图"]];
    
    _VIPimage.image=model.vipImage;
//    //屏蔽支付宝功能
//    [ShuJuModel huoquVipTubiaosuccess:^(NSDictionary *dic) {
//        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]];
//        if ([code isEqualToString:@"0"]) {
//            
//        }else{
//            [_VIPimage sd_setImageWithURL:[NSURL URLWithString:model.vipname]];
//            if ([model.viplevel isEqualToString:@"3"]) {
//                _name.textColor=[UIColor colorWithRed:184/255.0 green:36/255.0 blue:232/255.0 alpha:1];
//            }else if ([model.viplevel isEqualToString:@"2"]){
//                _name.textColor=[UIColor colorWithRed:228/255.0 green:43/255.0 blue:23/255.0 alpha:1];
//                
//            }else if([model.viplevel isEqualToString:@"1"]){
//                _name.textColor=[UIColor colorWithRed:208/255.0 green:163/255.0 blue:99/255.0 alpha:1];
//            }
//            else{
//                _name.textColor=[UIColor blackColor];
//            }
//
//        }
//        
//        
//    } error:nil];
    
    
    
    
//    NSString * s= [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
//    if ([s isEqualToString:@"15032735032"] || s ==nil) {
//        
//    }else
//    {
//         [_VIPimage sd_setImageWithURL:[NSURL URLWithString:model.vipname]];
//    }
    
    
   



}


//-(void)setFrame:(CGRect)frame
//{
//    
//    frame.origin.y+=5;
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
