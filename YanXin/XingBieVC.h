//
//  XingBieVC.h
//  YanXin
//
//  Created by Macx on 17/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XingBieVC : UIViewController
@property(nonatomic,copy)void(^XingBieBlock)(NSString*XXname,NSString*number);
@end
