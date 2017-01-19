//
//  JiBenMessageCell.h
//  YanXin
//
//  Created by Macx on 17/1/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface JiBenMessageCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UITextView * textview;
@end
