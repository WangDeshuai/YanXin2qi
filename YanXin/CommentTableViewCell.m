//
//  CommentTableViewCell.m
//  YanXin
//
//  Created by Macx on 16/8/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CommentTableViewCell.h"
@interface CommentTableViewCell()
@property(nonatomic,retain)UIImageView * imageYou;
@property(nonatomic,retain)UILabel * nameLableYou;
@property(nonatomic,retain)UILabel * contentLable;
@property(nonatomic,retain)UILabel * timeLable;
@property(nonatomic,retain)UIImageView * zan;
@property(nonatomic,retain)UIImageView * imageMy;
@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
-(void)setup{
    _imageYou=[UIImageView new];
    _nameLableYou=[UILabel new];
    _contentLable=[UILabel new];
    _timeLable=[UILabel new];
    _imageMy=[UIImageView new];
    _zan=[UIImageView new];
    _zan.hidden=YES;
    _imageYou.layer.cornerRadius=10;
    _imageYou.clipsToBounds=YES;
   
    
    _nameLableYou.font=[UIFont systemFontOfSize:14];
    _contentLable.font=[UIFont systemFontOfSize:13];
    _timeLable.font=[UIFont systemFontOfSize:12];
    _timeLable.alpha=.7;
    
    [self.contentView sd_addSubviews:@[_imageYou,_nameLableYou,_contentLable,_timeLable,_imageMy,_zan]];
    
    UIView * view =self.contentView;
    _imageYou.sd_layout
    .leftSpaceToView(view,10)
    .widthIs(60)
    .heightIs(60)
    .topSpaceToView(view,5);
    
    _nameLableYou.sd_layout
    .leftSpaceToView(_imageYou,10)
    .topEqualToView(_imageYou)
    .heightIs(20);
    [_nameLableYou setSingleLineAutoResizeWithMaxWidth:150];
    
    _imageMy.sd_layout
    .rightSpaceToView(view,10)
    .topEqualToView(_imageYou)
    .widthIs(65)
    .heightIs(65);
    
    
    _contentLable.sd_layout
    .leftEqualToView(_nameLableYou)
    .topSpaceToView(_nameLableYou,5)
    .rightSpaceToView(_imageMy,15)
    .autoHeightRatio(0);
    
    _timeLable.sd_layout
    .topSpaceToView(_contentLable,5)
    .leftEqualToView(_nameLableYou)
    .heightIs(20);
    [_timeLable setSingleLineAutoResizeWithMaxWidth:150];
    [self setupAutoHeightWithBottomView:_timeLable bottomMargin:10];
}
-(void)setModel:(CommentModel *)model
{
    _model=model;
//点赞人头像
    [_imageYou sd_setImageWithURL:[NSURL URLWithString:model.triggerHeadImgUrl] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
//点赞人名字
    _nameLableYou.text=model.triggerName;
    
 //评论的内容
    if ([model.pushScene isEqualToString:@"add_praise"])
    {
//点赞
        _contentLable.text=@"点赞的图片";
        _zan.image=[UIImage imageNamed:@""];
    }else{
        _contentLable.text=model.triggerContent;
    }
//时间显示
    _timeLable.text=model.triggerTime;
    
//动态图片
    [_imageMy sd_setImageWithURL:[NSURL URLWithString:model.dyImgUrl] placeholderImage:[UIImage imageNamed:@""]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
