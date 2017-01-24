//
//  PhotoViewController.h
//  YanXin
//
//  Created by Macx on 17/1/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
//需要查找哪个，把哪个的号码穿过来
@property(nonatomic,copy)NSString * phoneNum ;
//tagg==1是相册，tagg==2是视频
@property(nonatomic,assign)NSInteger tagg;
/*
 numTag==2是从演出公司进入了
 */
@property(nonatomic,assign)NSInteger numTag;
@end
