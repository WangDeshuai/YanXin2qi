//
//  YiHuoDeCell.h
//  YanXin
//
//  Created by Macx on 17/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YiHuoDeModel.h"
@interface YiHuoDeCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)YiHuoDeModel * model;
@end
