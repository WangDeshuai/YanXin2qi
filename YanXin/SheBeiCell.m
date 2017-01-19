//
//  SheBeiCell.m
//  YanXin
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SheBeiCell.h"

@implementation SheBeiCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLab=[UILabel new];
        _nameLab.text=_model.titleName;
        _lineImage=[UIImageView new];
        _lineImage.image=[UIImage imageNamed:@"11.jpg"];
        _jianJieLab=[UILabel new];
        _jianJieLab.textColor=[UIColor colorWithRed:75/255.0 green:75/255.0  blue:75/255.0  alpha:.7];
        _jianJieLab.numberOfLines=3;
        _jianJieLab.font=[UIFont systemFontOfSize:13];
        
        
        _VIPImage =[UIImageView new];
        
        [self.contentView sd_addSubviews:@[_nameLab,_lineImage,_jianJieLab,_VIPImage]];
        
        _lineImage.sd_layout
        .topSpaceToView(self.contentView,15)
        .leftSpaceToView(self.contentView,15)
        .widthIs(70)
        .heightIs(70);
        
        _nameLab.sd_layout
        .topEqualToView(_lineImage)
        .leftSpaceToView(_lineImage,10)
        .autoWhiteRatio(0)
        .heightIs(30);
        _nameLab.sd_layout.maxWidthIs(210);
        
        _VIPImage.sd_layout
        .leftSpaceToView(_nameLab,3)
        .topSpaceToView(self.contentView,22)
        .widthIs(38)
        .heightIs(14);
        
        _jianJieLab.sd_layout
        .topSpaceToView(_nameLab,0)
        .leftEqualToView(_nameLab)
        .rightSpaceToView(self.contentView,30)
        .heightIs(40);
        
    }
    return self;
}

-(void)setModel:(YanShangModel *)model
{
    _model=model;
    [_lineImage sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    _nameLab.text=model.titleName;
    [_VIPImage sd_setImageWithURL:[NSURL URLWithString:model.imageVIPName]];
    _jianJieLab.text=model.jianJie;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
