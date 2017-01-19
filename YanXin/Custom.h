//
//  Custom.h
//  YanXin
//
//  Created by mac on 16/2/19.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YanShangModel.h"
@interface Custom : UITableViewCell

@property (nonatomic,retain)UILabel * nameLab;
@property (nonatomic,retain)UIImageView * lineImage;
@property (nonatomic,retain)UILabel * jianJieLab;
@property (nonatomic,retain)UIImageView * VIPImage;
@property (nonatomic,strong)UIImageView * renZhengImage;
@property (nonatomic,retain)YanShangModel * model;
@end
