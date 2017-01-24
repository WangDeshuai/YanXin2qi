//
//  YanYiQuanModel.m
//  YanXin
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YanYiQuanModel.h"
//extern const CGFloat contentLabelFontSize;
//extern CGFloat maxContentLabelHeight;
@implementation YanYiQuanModel

@synthesize msgContent = _msgContent;
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
        NSDictionary * userInfoDic=[dic objectForKey:@"userInfo"];
        self.name=[userInfoDic objectForKey:@"name"];
        self.iconName=[userInfoDic objectForKey:@"headimgurl"];
        
        NSDictionary * dyInfoDic=[dic objectForKey:@"dyInfo"];
        self.time=[dyInfoDic objectForKey:@"addtime"];
        self.msgContent=[dyInfoDic objectForKey:@"content"];
        NSMutableArray*imglistArr= [dyInfoDic objectForKey:@"imgList"];
        self.picNamesArray=imglistArr;
        self.pingLun=[dyInfoDic objectForKey:@"discussList"];
        self.zan=[dyInfoDic objectForKey:@"praiseList"];
        NSMutableArray *tempLikes=[NSMutableArray new];
       
        for(NSDictionary * zandicc in self.zan){
            SDTimeLineCellLikeItemModel *zan =[SDTimeLineCellLikeItemModel new];
            zan.userName=[zandicc objectForKey:@"name"];
            zan.userId=[NSString stringWithFormat:@"%@",[zandicc objectForKey:@"account"]];
            [tempLikes addObject:zan];
        }
        self.likeItemsArray = [tempLikes copy];
        
        
        NSMutableArray *tempComments = [NSMutableArray new];
        
        
        for(NSDictionary * dicc in self.pingLun){
            SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
            commentItemModel.firstUserName=[dicc objectForKey:@"disname"];
            commentItemModel.firstUserId = [dicc objectForKey:@"disaccount"];
            commentItemModel.secondUserName=[dicc objectForKey:@"berepliedname"];
            commentItemModel.secondUserId=[dicc objectForKey:@"berepliedaccount"];
            commentItemModel.commentString =[dicc objectForKey:@"content"];
            [tempComments addObject:commentItemModel];
            
        }
        self.commentItemsArray = [tempComments copy];
        
        
        
        // self.likeItemsArray=[dyInfoDic objectForKey:@"praiseList"];
        self.renjiaID=[[dyInfoDic objectForKey:@"id"] intValue];
        // NSLog(@"我是解析出啦的图片的个数%lu",(unsigned long)self.picNamesArray.count);
        self.zhucehao=[self string:[dyInfoDic objectForKey:@"account"]];
        self.ISlike =[NSString stringWithFormat:@"%@",[dyInfoDic objectForKey:@"selfPraised"]];
        //self.discussid=[NSString stringWithFormat:@"%@",[dyInfoDic objectForKey:@"discussid"]];
        if ([self.ISlike isEqualToString:@"1"]) {
            _liked=YES;
        }else
        {
            _liked=NO;
        }
        
        
      //  NSLog(@"我是>>%@",[dyInfoDic objectForKey:@"selfPraised"]);
    }
    
    return self;
    
}
//过滤一下
-(NSString*)string:(id)sss
{
    
    NSString * a=@"";
    if (sss==[NSNull null]) {
        a=@"";
    }else{
        a=sss;
    }
    return a;
    
}



- (void)setMsgContent:(NSString *)msgContent
{
    _msgContent = msgContent;
}

- (NSString *)msgContent
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    if (textRect.size.height > 60) {
        _shouldShowMoreButton = YES;
    }
    else {
        _shouldShowMoreButton = NO;
    }
    
    return _msgContent;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}


@end



@implementation SDTimeLineCellLikeItemModel


@end


//评论
@implementation SDTimeLineCellCommentItemModel


@end
