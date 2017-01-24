//
//  JiBenMessageCell.m
//  YanXin
//
//  Created by Macx on 17/1/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "JiBenMessageCell.h"
@interface JiBenMessageCell()


@end
@implementation JiBenMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    JiBenMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[JiBenMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    _titleLabel=[UILabel new];
    _nameLabel=[UILabel new];
    _textview=[UITextView new];
    _textview.font=[UIFont systemFontOfSize:15];
    _textview.alpha=.6;
    _textview.hidden=YES;
    _textview.editable=NO;
    
    _swit=[[UISwitch alloc]init];
  
    
    
    [self.contentView sd_addSubviews:@[_titleLabel,_nameLabel,_textview,_swit]];
    _titleLabel.alpha=.8;
    _nameLabel.alpha=.8;
    _titleLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.textAlignment=0;
    _nameLabel.hidden=YES;
    
    //标题名字
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(80)
    .heightIs(20);
    
   // _nameLabel.backgroundColor=[UIColor redColor];
//    _textview.backgroundColor=[UIColor greenColor];
    //内容名字
    _nameLabel.sd_layout
    .leftSpaceToView(_titleLabel,10)
    .centerYEqualToView(_titleLabel)
    .widthIs(150)
    .heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
   
    //个人简介和基本资料用
    _textview.sd_layout
    .leftSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,15)
    .bottomSpaceToView(self.contentView,0);
   
    _swit.hidden=YES;
    _swit.sd_layout
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(49)
    .heightIs(30);

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
