//
//  DongTaiTableViewCell.h
//  YanXin
//
//  Created by Macx on 17/1/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhoYanYuanModel.h"
@interface DongTaiTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)WhoYanYuanModel * model;
@end
