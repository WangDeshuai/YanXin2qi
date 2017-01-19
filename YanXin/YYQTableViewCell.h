//
//  YYQTableViewCell.h
//  YanXin
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDTimeLineCellDelegate <NSObject>

- (void)didClickLickButtonInCell:(UITableViewCell *)cell;
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell;

@end


@class YanYiQuanModel;
@interface YYQTableViewCell : UITableViewCell
@property(nonatomic,strong)YanYiQuanModel * model;
@property (nonatomic, weak) id<SDTimeLineCellDelegate> delegate;

// UIButton *_iconView;
//UIButton *_nameLable;
@property(nonatomic,retain)UIButton *iconView;
@property(nonatomic,retain)UIButton *nameLable;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIButton *operationButton;
@property (nonatomic, strong) UIButton *operationButton1;
@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath,NSString *commIDD);
@end
