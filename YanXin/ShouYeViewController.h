//
//  ShouYeViewController.h
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ShouYeViewController : UIViewController<CLLocationManagerDelegate>
{
    NSString * publicName;
    NSInteger number;
    CLLocationManager * _manager;
    //地理编码 反编码
    CLGeocoder * _coder;
}

@end
