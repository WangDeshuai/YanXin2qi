//
//  CuestmYanYuan.h
//  YanXin
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "yanyuanModel.h"
@interface CuestmYanYuan : UITableViewCell
@property (nonatomic,retain)yanyuanModel *model;
@property(nonatomic,retain)UIImageView *lineImage;
@property(nonatomic,retain)UILabel *name;

@property(nonatomic,retain)UIImageView *xingbieImage;
@property(nonatomic,retain)UILabel *zhiye;
@property(nonatomic,retain)UILabel *jianjie;
@property(nonatomic,retain)UIImageView *VIPimage;

@end
