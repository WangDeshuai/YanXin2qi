//
//  CityViewController.h
//  YanXin
//
//  Created by Macx on 17/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewController : UIViewController
@property(nonatomic,copy)void(^CityNameBlock)(NSString*shengName,NSString*shiName,NSString *xianName);
@end
