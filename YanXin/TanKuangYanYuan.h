//
//  TanKuangYanYuan.h
//  YanXin
//
//  Created by Macx on 17/1/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewYanYuanModel.h"
@interface TanKuangYanYuan : UIView
//认证弹框
-(id)initWithTitle:(NSMutableArray*)titleArr cacleBtn:(NSString*)btnName;//初始化方法
-(void)show;//显示弹框
-(void)dissmiss;//取消弹框
@property(nonatomic,copy)void(^nameBlock)(NewYanYuanModel*md);
@end
