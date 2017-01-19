//
//  YYQTableViewCell.m
//  YanXin
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YYQTableViewCell.h"
#import "YanYiQuanModel.h"
#import "SDTimeLineCellCommentView.h"

@implementation YYQTableViewCell
{
  CGFloat maxContentLabelHeight;
  CGFloat contentLabelFontSize ;
  
   UILabel *_contentLabel;
   SDWeiXinPhotoContainerView *_picContainerView;
    UILabel *_timeLabel;
    UIButton *_moreButton;
    SDTimeLineCellCommentView *_commentView;
//    //评论
//   UIButton *_operationButton;
   //赞
//    UIButton *_operationButton1;
   BOOL _shouldOpenContentLabel;
    UIButton * button;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        maxContentLabelHeight=0;
        contentLabelFontSize=15;
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


-(void)setup
{
    
    _iconView = [UIButton new];
    _iconView.adjustsImageWhenHighlighted=NO;
    //[_iconView addTarget:self action:@selector(iconClink:) forControlEvents:UIControlEventTouchUpInside];
    _iconView.layer.cornerRadius=20;
    _iconView.clipsToBounds=YES;
   
    
    _nameLable = [UIButton new];
    //_nameLable.backgroundColor=[UIColor redColor];
    _nameLable.titleLabel.font = [UIFont systemFontOfSize:16];
    //_nameLable.titleLabel.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:1];
   // [_nameLable addTarget:self action:@selector(iconClink:) forControlEvents:UIControlEventTouchUpInside];
    [_nameLable setTitleColor:[UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:1] forState:0];
    
    
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
    }
    _moreButton = [UIButton new];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(morebuttonClink) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _operationButton = [UIButton new];
    
    [_operationButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    _operationButton1 = [UIButton new];
   
  
     _commentView = [SDTimeLineCellCommentView new];
    _picContainerView = [SDWeiXinPhotoContainerView new];
    
    __weak typeof(self)weakSelf=self;
   
    [_commentView setDidClickCommentLabelBlock:^(NSString *commentId, CGRect rectInWindow,NSString * commIDD) {
        if (weakSelf.didClickCommentLabelBlock) {
            weakSelf.didClickCommentLabelBlock(commentId, rectInWindow, weakSelf.indexPath,commIDD);
        }
    }];

    
   
    
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    NSArray *views = @[_iconView, _nameLable, _contentLabel,  _picContainerView, _timeLabel,_moreButton,_operationButton,_operationButton1,_commentView];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
//    
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .heightIs(18)
    .widthIs(70);
    //[_nameLable setSingleLineAutoResizeWithMaxWidth:200];
//
    _contentLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
//
   //  morebutton的高度在setmodel里面设置
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
//
//    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel); // 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
//
    _timeLabel.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_picContainerView, margin+5)
    .heightIs(15)
    .autoHeightRatio(0);

    _operationButton.sd_layout
    .rightSpaceToView(contentView, margin*5)
    .centerYEqualToView(_timeLabel)
    .heightIs(49*4/13)
    .widthIs(49);
   
    _operationButton1.sd_layout
    .rightSpaceToView(_operationButton, margin+5)
    .centerYEqualToView(_timeLabel)
    .heightIs(49*4/13)
    .widthIs(49*9/13);
    
    _commentView.sd_layout
    .leftEqualToView(_contentLabel)
    .rightSpaceToView(self.contentView, margin)
    .topSpaceToView(_timeLabel, margin); // 已经在内部实现高度自适应所以不需要再设置高度

    
    
}

-(void)setModel:(YanYiQuanModel *)model
{
    _model=model;
   
    for (NSDictionary * dica in _model.pingLun) {
      int a=  [[dica objectForKey:@"discussid"] intValue];
        button.tag=a;
    }
    
    _commentView.frame = CGRectZero;
    [_commentView setupWithLikeItemsArray:model.likeItemsArray commentItemsArray:model.commentItemsArray];
    _shouldOpenContentLabel = NO;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.iconName] forState:0 placeholderImage:[UIImage imageNamed:@"头像占位图"]];
   // [_iconView sd_setImageWithURL:[NSURL URLWithString:model.iconName] placeholderImage:[UIImage imageNamed:@"头像占位图"]];
   
    //_nameLable.text = model.name;
    [_nameLable setTitle:model.name forState:0];
    
    [_nameLable sizeToFit];
    _contentLabel.text = model.msgContent;
  
   _picContainerView.picPathStringsArray = model.picNamesArray;

   // NSLog(@"相片的个数是>>>%d",model.picNamesArray.count);
    
    if (model.shouldShowMoreButton) { // 如果文字高度超过60
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
       
    }
    else {
       
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }

    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);
   // 日期
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
   // NSString*   date = [formatter stringFromDate:[NSDate date]];
    //NSLog(@"系统时间%@", date);
  
  
    NSString * nigei = model.time;
    NSDateFormatter *formmater = [[NSDateFormatter alloc]init];
    [formmater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate*   dat = [formmater dateFromString:nigei];
  //  NSString * d =[formmater stringFromDate: dat ];
  //  NSLog(@"你给的时间%@",d);
    double shijianCha =[[NSDate date] timeIntervalSinceDate:dat];
    int myInt = (int)shijianCha/60;
    if ( myInt<1) {
        _timeLabel.text=@"刚刚";
    }
    else if (myInt<60)
    {
        _timeLabel.text=[NSString stringWithFormat:@"%d分前",myInt];
    }else if (myInt<60*24){
        _timeLabel.text=[NSString stringWithFormat:@"%d小时前",myInt/60];
    }else if (myInt<60*24*2){
        _timeLabel.text=@"昨天";
    }else
    {
         _timeLabel.text=[NSString stringWithFormat:@"%d天前",myInt/60/24];
    }
    
    
//
    UIView *bottomView;
   // NSLog(@">>>>>%d",model.commentItemsArray.count);
    if (!model.commentItemsArray.count && !model.likeItemsArray.count) {
        _commentView.fixedWith = @0; // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        _commentView.fixedHeight = @0; // 如果没有评论或者点赞，设置commentview的固定高度为0（设置了fixedHeight的控件将不再在自动布局过程中调整高度）
        _commentView.sd_layout.topSpaceToView(_timeLabel, 0);
        bottomView = _timeLabel;
        
    } else {
        _commentView.fixedHeight = nil; // 取消固定宽度约束
        _commentView.fixedWith = nil; // 取消固定高度约束
        _commentView.sd_layout.topSpaceToView(_timeLabel, 10);
        bottomView = _commentView;
    }
//
   
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:picContainerTopMargin+10];
    
}

//全文收起
-(void)morebuttonClink{
   // NSLog(@"111");
   // NSLog(@"%@",self.indexPath);
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }

    
}

//评论
-(void)operationButtonClicked
{
    
    
}
-(void)button1
{
   // NSLog(@"%d",button.tag);
    
}

-(void)operationButtonClicked1
{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
