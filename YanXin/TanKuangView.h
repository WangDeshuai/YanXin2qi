//
//  TanKuangView.h
//  YanXin
//
//  Created by Macx on 17/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanKuangView : UIView
//认证弹框
-(id)initWithTitle:(NSString*)title cacleBtn:(NSString*)btnName;//初始化方法
//充值认证
-(id)initWithChongZhiTitle:(NSString*)title ContentName:(NSString*)content cacleBtn:(NSString*)btnName;
-(void)show;//显示弹框
-(void)dissmiss;//取消弹框
@property(nonatomic,copy)void(^BtnClickBlock)(UIButton*btn);
@end
