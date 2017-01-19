//
//  FirstCustom.h
//  YanXin
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstModel.h"
@interface FirstCustom : UITableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;


@property (nonatomic,retain)UIImageView * image1;
@property (nonatomic,retain)UILabel *lab1;
@property (nonatomic,retain)UILabel *lab2;
@property (nonatomic,retain)UILabel *lab3;
@property(nonatomic,retain)UIImageView * baoming;
@property(nonatomic,retain)FirstModel * model;

@end
