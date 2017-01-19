//
//  DongTaiCell.h
//  YanXin
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhoDongTaiModel.h"
@interface DongTaiCell : UITableViewCell
@property(nonatomic,retain)UIButton * deleteBtn;
@property(nonatomic,strong)WhoDongTaiModel * model;


@end
