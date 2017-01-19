//
//  XiangCeCell.m
//  YanXin
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XiangCeCell.h"
#define gao 105
@implementation XiangCeCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // _label=[UILabel new];
        
        _image1=[UIImageView new];
        _image2=[UIImageView new];
        _image3=[UIImageView new];
        _image1.frame=[FrameAutoScaleLFL CGLFLMakeX:15 Y:5 width:gao height:gao];
        _image2.frame=[FrameAutoScaleLFL CGLFLMakeX:25+gao Y:5 width:gao height:gao];
        _image3.frame=[FrameAutoScaleLFL CGLFLMakeX:35+gao+gao Y:5 width:gao height:gao];
        [self.contentView addSubview:_image2];
        [self.contentView addSubview:_image1];
        [self.contentView addSubview:_image3];
       // [self.contentView addSubview:_label];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
