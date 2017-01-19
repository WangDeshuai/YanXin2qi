//
//  HuiKeTableViewCell.h
//  YanXin
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuiKeTableViewCell : UITableViewCell
@property (nonatomic,retain)UILabel * nameLabel;
@property (nonatomic,retain)UILabel * mianJiLabel;
@property (nonatomic,retain)UILabel * renshuLabel;
@property (nonatomic,retain)UILabel * jiaGeLabel;
@property (nonatomic,retain)UILabel * canKaoLabel;

@property (nonatomic,retain)UIButton * buttonSelect;
@property(nonatomic,retain)NSDictionary * dictionary;
@end
