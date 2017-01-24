//
//  MyMessageCell.m
//  YanXin
//
//  Created by Macx on 17/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyMessageCell.h"
@interface MyMessageCell()

@property(nonatomic,strong)UILabel * nameLabel;

@end
@implementation MyMessageCell

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    MyMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[MyMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
    [self.contentView sd_addSubviews:@[_titleLabel,_nameLabel]];
    _titleLabel.alpha=.8;
    _nameLabel.alpha=.8;
    _titleLabel.font=[UIFont systemFontOfSize:15];
    _nameLabel.font=[UIFont systemFontOfSize:15];
    //标题名字
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .widthIs(70)
    .heightIs(20);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_titleLabel,15)
    .centerYEqualToView(_titleLabel)
    .heightIs(20);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    //文本框
    _textfield=[UITextField new];
    _textfield.placeholder=@"未填写";
    _textfield.font=[UIFont systemFontOfSize:15];
    _textfield.textAlignment=0;
//    _textfield.backgroundColor=[UIColor yellowColor];
    [self.contentView sd_addSubviews:@[_textfield]];
    _textfield.sd_layout
    .leftSpaceToView(_titleLabel,10)
    .rightSpaceToView(self.contentView,15)
    .centerYEqualToView(self.contentView)
    .heightIs(30);
    
    
    
    //textView
    _textView=[UITextView new];
    _textView.font=[UIFont systemFontOfSize:15];
    _textView.hidden=YES;
    [self.contentView sd_addSubviews:@[_textView]];
    _textView.sd_layout
    .leftSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,15)
    .topSpaceToView(self.contentView,5)
    .bottomSpaceToView(self.contentView,5);
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
