//
//  HuiYiShiViewController.h
//  YanXin
//
//  Created by mac on 16/3/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuiYiShiViewController : UIViewController
@property (nonatomic,retain)NSMutableArray * dataArray;


@property (nonatomic,copy)void(^pswNameBlock) (NSInteger number);
@end
