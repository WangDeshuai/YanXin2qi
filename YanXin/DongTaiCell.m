//
//  DongTaiCell.m
//  YanXin
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DongTaiCell.h"

@implementation DongTaiCell
{
    UILabel *_contentLabel;
    UILabel *_timeLabel;
    SDWeiXinPhotoContainerView *_picContainerView;
}
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
-(void)setup
{

     _contentLabel = [UILabel new];
     _picContainerView = [SDWeiXinPhotoContainerView new];
     _timeLabel = [UILabel new];
     _timeLabel.font = [UIFont systemFontOfSize:13];
     _timeLabel.textColor = [UIColor lightGrayColor];
   
    _deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setTitle:@"删除" forState:0];
   
    _deleteBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [_deleteBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    
    ;
   // NSLog(@"登录中是%@",);
   
    [self.contentView sd_addSubviews:@[_contentLabel,_picContainerView,_timeLabel,_deleteBtn]];
     UIView *contentView = self.contentView;
    CGFloat margin = 10;
    _contentLabel.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel);
  
    _timeLabel.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_picContainerView, margin+5)
    .heightIs(15)
    .widthIs(85);
    
    _deleteBtn.sd_layout
    .rightSpaceToView(contentView,10)
    .topEqualToView(_timeLabel)
    .widthIs(35)
    .heightIs(15);

}
-(void)setModel:(WhoDongTaiModel *)model
{
   
    _model=model;
   //  NSLog(@"注册号%@",_model.zhuce);
    if (![_model.zhuce isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]]) {
        _deleteBtn.hidden=YES;
    }
    
    _contentLabel.text=model.neirong;
     _picContainerView.picPathStringsArray = model.picNamesArray;
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_contentLabel, picContainerTopMargin);
    NSString *b = [model.time substringToIndex:11];
    _timeLabel.text=b;
    
      [self setupAutoHeightWithBottomView:_timeLabel bottomMargin:picContainerTopMargin+10];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
