//
//  JIBenXInXICell.m
//  YanXin
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JIBenXInXICell.h"
//const CGFloat contentLabelFontSize = 15;
//CGFloat maxContentLabelHeight = 0; // 根据具体font而定
//#define TimeLineCellHighlightedColor
@implementation JIBenXInXICell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    _leftLabel=[UILabel new];
    _leftLabel.textColor=[UIColor grayColor];
    _leftLabel.alpha=.7;
    [self.contentView sd_addSubviews:@[_leftLabel]];
    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,5)
    .heightIs(34);
    [_leftLabel setSingleLineAutoResizeWithMaxWidth:375];
    
    _nameLabel=[UILabel new];
    _nameLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_nameLabel]];
    _nameLabel.sd_layout
    .leftSpaceToView(_leftLabel,10)
    .topSpaceToView(self.contentView,5)
    .heightIs(34);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:375];
    
    _jianJieLabel=[UILabel new];
    _jianJieLabel.font=[UIFont systemFontOfSize:15];
    //_jianJieLabel.backgroundColor=[UIColor redColor];
    [self.contentView sd_addSubviews:@[_jianJieLabel]];
    _jianJieLabel.sd_layout
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,0)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:_jianJieLabel bottomMargin:5];
    
}
-(void)setText:(NSString *)text{
    _text=text;
    _jianJieLabel.text=text;
   // NSLog(@"我是简介啊%@",text);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
