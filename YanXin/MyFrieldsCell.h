//
//  MyFrieldsCell.h
//  YanXin
//
//  Created by Macx on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFriendsModel.h"
@interface MyFrieldsCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)MyFriendsModel * model;
@end
