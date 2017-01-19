//
//  YanYiQuanModel.h
//  YanXin
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SDTimeLineCellLikeItemModel, SDTimeLineCellCommentItemModel;

@interface YanYiQuanModel : NSObject



- (id)initWithDic:(NSDictionary *)dic;


@property (nonatomic, strong) NSArray<SDTimeLineCellLikeItemModel *> *likeItemsArray;
@property (nonatomic, strong) NSArray<SDTimeLineCellCommentItemModel *> *commentItemsArray;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, strong) NSArray *picNamesArray;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, retain) NSMutableArray *pingLun;
@property (nonatomic, retain) NSMutableArray *zan;
@property (nonatomic, assign) NSInteger renjiaID;
@property (nonatomic,copy)NSString * ISlike;
@property(nonatomic,copy)NSString * zhucehao;
@property (nonatomic, assign) BOOL isOpening;
@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;
@property (nonatomic, assign, getter = isLiked) BOOL liked;
//评论某一行的id
//@property(nonatomic,copy)NSString * discussid;
@end




@interface SDTimeLineCellLikeItemModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@end


@interface SDTimeLineCellCommentItemModel : NSObject

@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@end