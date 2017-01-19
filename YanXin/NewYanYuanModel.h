//
//  NewYanYuanModel.h
//  YanXin
//
//  Created by Macx on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewYanYuanModel : NSObject
//演员的标签
@property(nonatomic,copy)NSString * biaoQianName;
@property(nonatomic,copy)NSString * biaoQianTag;
-(id)initWithBiaoQianDic:(NSDictionary*)dic;
@end
