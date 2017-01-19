//
//  CommentModel.h
//  YanXin
//
//  Created by Macx on 16/8/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property(nonatomic,copy)NSString * dyContent;
@property(nonatomic,copy)NSString * dyId;
@property(nonatomic,copy)NSString * dyImgUrl;
@property(nonatomic,copy)NSString * dyOwnerAccount;
@property(nonatomic,copy)NSString * dyOwnerHeadImgUrl;
@property(nonatomic,copy)NSString * dyOwnerName;
@property(nonatomic,copy)NSString * pushScene;
@property(nonatomic,copy)NSString * triggerAccount;
@property(nonatomic,copy)NSString * triggerHeadImgUrl;
@property(nonatomic,copy)NSString * triggerName;
@property(nonatomic,copy)NSString * triggerTime;
@property(nonatomic,copy)NSString * triggerContent;
-(id)initWithDic:(NSDictionary*)dic;
@end
