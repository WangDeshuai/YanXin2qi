//
//  XiangCeTableViewCell.h
//  YanXin
//
//  Created by Macx on 17/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiangCeTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
//点击的哪个
@property(nonatomic,copy)void(^IndePathBlock)(NSIndexPath*indepath);
//点击查看更多
@property(nonatomic,copy)void(^moreBtnBlock)(UIButton*btn);
@property(nonatomic,strong)NSMutableArray * dataArr;
@end
