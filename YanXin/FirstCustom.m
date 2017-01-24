//
//  FirstCustom.m
//  YanXin
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "FirstCustom.h"

@implementation FirstCustom


+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    FirstCustom * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[FirstCustom alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}


-(void)setup{
    _image1=[[UIImageView alloc]init];
    _lab1=[[UILabel alloc]init];
    _lab2=[[UILabel alloc]init];
    _lab3=[[UILabel alloc]init];
    _baoming=[[UIImageView alloc]init];
    //_lab1.textColor=[UIColor orangeColor];
    _lab2.textColor=[UIColor colorWithRed:75/255.0 green:75/255.0 blue:75/255.0 alpha:.7];
    _lab3.textColor=[UIColor colorWithRed:75/255.0 green:75/255.0 blue:75/255.0 alpha:.7];
    _lab2.font=[UIFont systemFontOfSize:14];
    _lab3.font=[UIFont systemFontOfSize:14];
    
    [self.contentView sd_addSubviews:@[_image1,_lab1,_lab2,_lab3,_baoming]];
    UIView * bg =self.contentView ;
    _image1.sd_layout
    .centerYEqualToView(bg)
    .leftSpaceToView(bg,10)
    .widthIs(85)
    .heightIs(80);
    
    
    _baoming.sd_layout
    .rightSpaceToView(bg,20)
    .heightIs(30/2)
    .widthIs(82/2)
    .topSpaceToView(bg,20);
    
    _lab1.sd_layout
    .leftSpaceToView(_image1,20)
    .topSpaceToView(bg,15)
    .heightIs(30)
    .rightSpaceToView(_baoming,10);
    //[_lab1 setSingleLineAutoResizeWithMaxWidth:375];
    
    
   
    
    
    _lab2.sd_layout
    .topSpaceToView(_lab1,0)
    .leftEqualToView(_lab1)
    .rightSpaceToView(bg,10)
    .heightIs(20);
    
    _lab3.sd_layout
    .topSpaceToView(_lab2,0)
    .leftEqualToView(_lab2)
    .rightEqualToView(_lab2)
    .heightIs(20);
    
   
    [self setupAutoHeightWithBottomView:_lab3 bottomMargin:10];
    
}
-(void)setModel:(FirstModel *)model{
    _model=model;
   [_image1 sd_setImageWithURL:[NSURL URLWithString:_model.imageview] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
     _lab1.text=_model.titleLabel;
     _lab2.text=_model.neirongLabel;
    _lab3.text=[NSString stringWithFormat:@"演出时间: %@",_model.fabuTime];
    
   // NSLog(@"我就看这名字%@",_model.titleLabel);
    [self isAchievement];
}
-(void)isAchievement{
    NSString * nigei = _model.fabuTime;
    NSDateFormatter *formmater = [[NSDateFormatter alloc]init];
    [formmater setDateFormat:@"YYYY-MM-dd"];//YYYY-MM-dd HH:mm:ss
    NSDate*   dat = [formmater dateFromString:nigei];
//    NSLog(@"后台返回的时间是%@",_model.fabuTime);
//    NSLog(@">>>>>%@",dat);
    
    NSString*   dateStr = [formmater stringFromDate:[NSDate date]];
    NSDate*   nowDate = [formmater dateFromString:dateStr];
    
    
   // NSLog(@"今天的时间是%@",nowDate);//NSOrderedDescending
    if ([nowDate compare:dat] == NSOrderedDescending)
    {
        _baoming.image=[UIImage imageNamed:@"finish(2)"];
        //NSLog(@"已完成");
       // _baoming.text=@"已完成";
    }else{
       // NSLog(@"报名中");
       // _baoming.text=@"报名中";
         _baoming.image=[UIImage imageNamed:@"signup(2)"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
