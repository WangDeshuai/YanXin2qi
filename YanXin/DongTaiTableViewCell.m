//
//  DongTaiTableViewCell.m
//  YanXin
//
//  Created by Macx on 17/1/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DongTaiTableViewCell.h"
@interface DongTaiTableViewCell()
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UIImageView * renZhengImage;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * contentLabel;
@property(nonatomic,strong) SDWeiXinPhotoContainerView * picContainerView;//到时候换成演艺圈的那种
@end
@implementation DongTaiTableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    DongTaiTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[DongTaiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self startCell];
    }
    return self;
}

-(void)startCell{
    /*
     headImage
     nameLabel
     renZhengImage
     timeLabel
     contentLabel
     textImage
     */
    _headImage=[UIImageView new];
    _nameLabel=[UILabel new];
    _renZhengImage=[UIImageView new];
    _timeLabel=[UILabel new];
    _contentLabel=[UILabel new];
    _picContainerView=[SDWeiXinPhotoContainerView new];
    
    
    [self.contentView sd_addSubviews:@[_headImage,_nameLabel,_renZhengImage,_timeLabel,_contentLabel,_picContainerView]];
    //属性
    _headImage.sd_cornerRadius=@(60/2);
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.textColor=DAO_COLOR;
    _timeLabel.font=[UIFont systemFontOfSize:14];
    _timeLabel.alpha=.6;
    _contentLabel.font=[UIFont systemFontOfSize:15];
    _contentLabel.alpha=.8;
    _contentLabel.numberOfLines=0;
   //赋值
    _headImage.image=[UIImage imageNamed:@"messege_big"];
    _nameLabel.text=@"熊宇";
    _renZhengImage.image=[UIImage imageNamed:@"messege_shiming"];
    _timeLabel.text=@"2016-12-18 17:07:25";
    _contentLabel.text=@"啊发哈坎干哈哦啊接发哈分好发咖啡卡拉干哈 爱的离开钢拉杆就啊";
    _picContainerView.picPathStringsArray=@[
                                            @"http://img.bitscn.com/upimg/allimg/c160120/1453262R114060-155B6.jpg",
                                            @"http://img.bitscn.com/upimg/allimg/c160120/1453262R114060-155B6.jpg",
                                            @"http://img.bitscn.com/upimg/allimg/c160120/1453262R114060-155B6.jpg"];
    
    [self zuoBiaoFrame];
     [self setupAutoHeightWithBottomView:_picContainerView bottomMargin:10];
}
-(void)zuoBiaoFrame{
   //头像
    _headImage.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,15)
    .widthIs(60)
    .heightIs(60);
    //名字
    _nameLabel.sd_layout
    .leftSpaceToView(_headImage,10)
    .topSpaceToView(self.contentView,20)
    .heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    //认证
    _renZhengImage.sd_layout
    .leftSpaceToView(_nameLabel,10)
    .centerYEqualToView(_nameLabel)
    .widthIs(42)
    .heightIs(13);
    //时间
    _timeLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel,10)
    .heightIs(20);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //内容
    _contentLabel.sd_layout
    .leftEqualToView(_headImage)
    .topSpaceToView(_headImage,10)
    .rightSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel,10);
    
    
}
-(void)setModel:(WhoYanYuanModel *)model
{
    _model=model;
    //头像
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.headImage] placeholderImage:[UIImage imageNamed:@"messege_big"]];
    //姓名
    _nameLabel.text=model.headName;
    //实名认证
    if ([model.headRenZheng isEqualToString:@"0"]) {
        //没有实名认证
        _renZhengImage.hidden=YES;
    }else{
        _renZhengImage.hidden=NO;
    }
    //发布时间
    _timeLabel.text=model.headTime;
    //发布内容
    _contentLabel.text=model.headConent;
    //图片数组
    _picContainerView.picPathStringsArray=model.headImageArr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
