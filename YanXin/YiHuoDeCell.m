//
//  YiHuoDeCell.m
//  YanXin
//
//  Created by Macx on 17/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "YiHuoDeCell.h"
@interface YiHuoDeCell()
@property(nonatomic,strong)UIImageView * lineImage;//头像
@property(nonatomic,strong)UILabel * nameLabel;//名字
@property(nonatomic,strong)UIImageView * vipImage;//VIP标志
@property(nonatomic,strong)UIImageView * friendImage;//直接好友
@property(nonatomic,strong)UILabel * priceLable;//价格
@property(nonatomic,strong)UILabel * timeLabel;//时间
@end
@implementation YiHuoDeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    YiHuoDeCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[YiHuoDeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    /*
     lineImage;//头像
     nameLabel;//名字
     vipImage;//VIP标志
     friendImage;//直接好友
     priceLable;//价格
     timeLabel;//时间
     
     */
    _lineImage=[UIImageView new];
    _nameLabel=[UILabel new];
    _vipImage=[UIImageView new];
    _friendImage=[UIImageView new];
    _priceLable=[UILabel new];
    _timeLabel=[UILabel new];
   //属性
    _lineImage.sd_cornerRadius=@(70/2);
    _nameLabel.alpha=.7;
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _priceLable.alpha=.7;
    _priceLable.font=[UIFont systemFontOfSize:15];
    _timeLabel.alpha=.5;
    _timeLabel.font=[UIFont systemFontOfSize:15];
   //赋值
    _lineImage.image=[UIImage imageNamed:@"my_pic"];
    _nameLabel.text=@"王阳明";
    _vipImage.image=[UIImage imageNamed:@"my_v2"];
    _friendImage.image=[UIImage imageNamed:@"cf_zj"];
    _priceLable.text=@"+900";
    _timeLabel.text=@"2017-01-01";
    
    [self.contentView sd_addSubviews:@[_lineImage,_nameLabel,_vipImage,_friendImage,_timeLabel,_priceLable]];
    //坐标
    //头像
    _lineImage.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,10)
    .widthIs(70)
    .heightIs(70);
    //姓名
    _nameLabel.sd_layout
    .leftSpaceToView(_lineImage,10)
    .topSpaceToView(self.contentView,25)
    .heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    //vip
    _vipImage.sd_layout
    .leftSpaceToView(_nameLabel,10)
    .centerYEqualToView(_nameLabel)
    .widthIs(40)
    .heightIs(13);
    
    //好友
    _friendImage.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel,10)
    .widthIs(43)
    .heightIs(14);
   //价格
    _priceLable.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_nameLabel)
    .heightIs(20);
    [_priceLable setSingleLineAutoResizeWithMaxWidth:200];
    //time
    _timeLabel.sd_layout
    .rightEqualToView(_priceLable)
    .topSpaceToView(_priceLable,10)
    .heightIs(20);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
}
-(void)setModel:(YiHuoDeModel *)model
{
    _model=model;
    //赋值
    [_lineImage sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"my_pic"]];
    
    
    _nameLabel.text=model.name;
    _vipImage.image=model.vipImage;
    _friendImage.image=model.friendImage;
    _priceLable.text=[NSString stringWithFormat:@"+%@",model.price];
    _timeLabel.text=model.time;
    
    
    
}
@end
