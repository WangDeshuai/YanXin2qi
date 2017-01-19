//
//  MyMessageCell.h
//  YanXin
//
//  Created by Macx on 17/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UITextField * textfield;
@property(nonatomic,strong)UITextView * textView;
@end
