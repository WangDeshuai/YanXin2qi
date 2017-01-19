//
//  CommentModel.m
//  YanXin
//
//  Created by Macx on 16/8/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
-(id)initWithDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _dyContent=[dic objectForKey:@"dyContent"];
         _dyId=[dic objectForKey:@"dyId"];
         _dyImgUrl=[dic objectForKey:@"dyImgUrl"];
        
        _dyOwnerAccount=[dic objectForKey:@"dyOwner_account"];
         _dyOwnerHeadImgUrl=[dic objectForKey:@"dyOwner_headImgUrl"];
         _dyOwnerName=[dic objectForKey:@"dyOwner_name"];
        
         _pushScene=[dic objectForKey:@"push_scene"];
         _triggerAccount=[dic objectForKey:@"trigger_account"];
         _triggerHeadImgUrl=[dic objectForKey:@"trigger_headImgUrl"];
        
        _triggerName=[dic objectForKey:@"trigger_name"];
        _triggerTime=[dic objectForKey:@"trigger_time"];
        if ([_pushScene isEqualToString:@"add_discuss"])
        {
            _triggerContent=[dic objectForKey:@"trigger_content"];
        }
        
        
    }
    return self;
}

@end
