//
//  WhoDongTaiModel.h
//  YanXin
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WhoDongTaiModel : NSObject
@property(nonatomic,copy)NSString * neirong;
@property(nonatomic,copy)NSString * time;
@property (nonatomic, strong) NSArray *picNamesArray;
@property(nonatomic,copy)NSString * zhuce;
@property(nonatomic,copy)NSString * messageID;

- (id)initWithDic:(NSDictionary *)dic;
@end
