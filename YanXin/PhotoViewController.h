//
//  PhotoViewController.h
//  YanXin
//
//  Created by Macx on 17/1/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
@property(nonatomic,copy)NSString * phoneNum ;
//tagg==1是相册，tagg==2是视频
@property(nonatomic,assign)NSInteger tagg;
@end
