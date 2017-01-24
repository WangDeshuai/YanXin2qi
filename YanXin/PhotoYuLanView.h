//
//  PhotoYuLanView.h
//  YanXin
//
//  Created by Macx on 17/1/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoYuLanView : UIView
-(id)initWithFangDa:(NSMutableArray*)photoArr NSindex:(NSInteger)index Tagg:(NSInteger)tagg;

-(void)show;//显示弹框
-(void)dissmiss;//取消弹框
/*
 tagg==1说明，数组中存的是url
 tagg==2说明，数组中存的是image,
 */
@property(nonatomic,copy)void(^dissBlock)();
@end
