//
//  ProvNameCityVC.h
//  YanXin
//
//  Created by Macx on 17/1/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProvNameCityVC : UIViewController
@property(nonatomic,copy)void(^Block)(NSString*provname,NSString*city,NSString*xian);
@end
