//
//  MyFrieldsCell.m
//  YanXin
//
//  Created by Macx on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyFrieldsCell.h"
@interface MyFrieldsCell()
@property(nonatomic,strong)UIImageView * headImage;//头像
@property(nonatomic,strong)UILabel * nameLabel;//名字
@property(nonatomic,strong)UIImageView * shiMingImage;//实名图标
@property(nonatomic,strong)UIImageView * vipImage;//Vip图标
@property(nonatomic,strong)UILabel * yanXinLabel;//演信号
@property(nonatomic,strong)UILabel * timeLabel;//时间
@end
@implementation MyFrieldsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    MyFrieldsCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MyFrieldsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
     headImage;//头像
     nameLabel;//名字
     shiMingImage;//实名图标
     vipImage;//Vip图标
     yanXinLabel;//演信号
     timeLabel;//时间
     */
    
    _headImage=[UIImageView new];
    _nameLabel=[UILabel new];
    _shiMingImage=[UIImageView new];
    _vipImage=[UIImageView new];
    _yanXinLabel=[UILabel new];
    _timeLabel=[UILabel new];
    
    [self.contentView sd_addSubviews:@[_headImage,_nameLabel,_shiMingImage,_vipImage,_yanXinLabel,_timeLabel]];
    //属性
    _headImage.sd_cornerRadius=@(30);
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.alpha=.7;
    _yanXinLabel.font=[UIFont systemFontOfSize:15];
    _yanXinLabel.alpha=.7;
    _timeLabel.font=[UIFont systemFontOfSize:14];
    _timeLabel.alpha=.6;
    //赋值
    _headImage.image=[UIImage imageNamed:@"my_pic"];
    _nameLabel.text=@"王明阳";
    _shiMingImage.image=[UIImage imageNamed:@"my_shiming"];
    _vipImage.image=[UIImage imageNamed:@"my_v2"];
    _yanXinLabel.text=@"演信号:254129572";
    _timeLabel.text=@"2016-12-21";
    [self zuoBiaoFrame];
}

-(void)zuoBiaoFrame{
    //头像
    _headImage.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15)
    .widthIs(60)
    .heightIs(60);
    //姓名
    _nameLabel.sd_layout
    .leftSpaceToView(_headImage,15)
    .topSpaceToView(self.contentView,20)
    .heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:220];
    //已实名
    _shiMingImage.sd_layout
    .leftSpaceToView(_nameLabel,10)
    .centerYEqualToView(_nameLabel)
    .widthIs(43)
    .heightIs(14);
    //vip
    _vipImage.sd_layout
    .leftSpaceToView(_shiMingImage,10)
    .centerYEqualToView(_nameLabel)
    .widthIs(40)
    .heightIs(13);
    //演信号
    _yanXinLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel,10)
    .heightIs(20);
    [_yanXinLabel setSingleLineAutoResizeWithMaxWidth:220];
    //时间
    _timeLabel.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(_yanXinLabel)
    .heightIs(20);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:220];
    [self setupAutoHeightWithBottomView:_timeLabel bottomMargin:10];
}
-(void)setModel:(MyFriendsModel *)model
{
    _model=model;
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.headStr] placeholderImage:[UIImage imageNamed:@"my_pic"]];
    
    _nameLabel.text=model.name;
    _shiMingImage.image=[UIImage imageNamed:@"my_shiming"];
    _vipImage.image=model.vipImage;
    _yanXinLabel.text=[NSString stringWithFormat:@"演信号:%@",model.yanXinNum];//@"演信号:254129572";
    _timeLabel.text=model.time;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
