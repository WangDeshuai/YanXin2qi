//
//  KeFangVC.h
//  YanXin
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeFangVC : UIViewController
@property (nonatomic,retain)NSMutableArray * dataArray1;
@property (nonatomic,copy)void(^pswNameBlock) (NSInteger number);

@end
