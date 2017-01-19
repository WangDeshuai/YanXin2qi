//
//  HuiKeTableViewCell.m
//  YanXin
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HuiKeTableViewCell.h"

@implementation HuiKeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _nameLabel= [UILabel new];
        _mianJiLabel=[UILabel new];
        _mianJiLabel.font=[UIFont systemFontOfSize:14];
        _renshuLabel=[UILabel new];
        _renshuLabel.font=[UIFont systemFontOfSize:14];
        _jiaGeLabel=[UILabel new];
        _jiaGeLabel.textColor=[UIColor colorWithRed:29/255.0 green:174/255.0 blue:231/255.0 alpha:1];
        _canKaoLabel=[UILabel new];
        _canKaoLabel.text=@"参考价";
        _canKaoLabel.font=[UIFont systemFontOfSize:14];
       _canKaoLabel.textColor=[UIColor colorWithRed:75/255.0 green:75/255.0 blue:75/255.0 alpha:.7];
        _mianJiLabel.textColor=[UIColor colorWithRed:75/255.0 green:75/255.0 blue:75/255.0 alpha:.7];
        _renshuLabel.textColor=[UIColor colorWithRed:75/255.0 green:75/255.0 blue:75/255.0 alpha:.7];
        _buttonSelect=[UIButton buttonWithType:UIButtonTypeCustom];
        _buttonSelect.frame=CGRectMake(0, 0, self.frame.size.width, 60);
        [self.contentView addSubview:_buttonSelect];
        
        [self.contentView sd_addSubviews:@[_nameLabel,_renshuLabel,_mianJiLabel,_jiaGeLabel,_canKaoLabel]];
        
        _nameLabel.sd_layout
        .leftSpaceToView(self.contentView,10)
        .autoWhiteRatio(0)
        .heightIs(20)
        .topSpaceToView(self.contentView,5);
        
        _mianJiLabel.sd_layout
        .leftEqualToView(_nameLabel)
        .heightIs(15)
        .topSpaceToView(_nameLabel,10)
        .autoWhiteRatio(0);
       
        _renshuLabel.sd_layout
        .leftSpaceToView(_mianJiLabel,5)
        .topEqualToView(_mianJiLabel)
        .autoWhiteRatio(0)
        .heightRatioToView(_mianJiLabel,1);
        
        _jiaGeLabel.sd_layout
        .rightSpaceToView(self.contentView,10)
        .heightRatioToView(_nameLabel,1)
        .autoWhiteRatio(0)
        .topEqualToView(_nameLabel);
        
        _canKaoLabel.sd_layout
        .rightEqualToView(_jiaGeLabel)
        .autoWhiteRatio(0)
        .topEqualToView(_mianJiLabel)
        .heightRatioToView(_mianJiLabel,1);
        
        
        
    }
    return self;
}


-(void)setDictionary:(NSDictionary *)dictionary
{
    _nameLabel.text=[dictionary objectForKey:@"name"];
    _mianJiLabel.text =[NSString stringWithFormat:@"%@平米",[dictionary objectForKey:@"area"]];
    _jiaGeLabel.text=[NSString stringWithFormat:@"¥%@",[dictionary objectForKey:@"price"]];
    _renshuLabel.text=[NSString stringWithFormat:@"%@人",[dictionary objectForKey:@"capcity"]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
