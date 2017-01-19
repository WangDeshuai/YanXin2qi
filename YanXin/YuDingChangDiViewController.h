//
//  YuDingChangDiViewController.h
//  test
//
//  Created by 一口海之言 on 16/4/29.
//  Copyright © 2016年 三米技术. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuDingChangDiViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *bgScroller;

@property (weak, nonatomic) IBOutlet UIButton *yanchushijian;
@property (weak, nonatomic) IBOutlet UIButton *huodongLeixing;
@property (weak, nonatomic) IBOutlet UITextField *namelianXi;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UILabel *huodongshijianLab;
@property (weak, nonatomic) IBOutlet UILabel *huodongchengshiLab;
@property (weak, nonatomic) IBOutlet UIButton *yanchudidian;

@property (weak, nonatomic) IBOutlet UILabel *huodongzhutiLab;
@property (weak, nonatomic) IBOutlet UILabel *changdiyaoqiuLab;
@property (weak, nonatomic) IBOutlet UITextView *tianxiechangdiYaoqiu;


@property (weak, nonatomic) IBOutlet UITextView *tianxianhuodongzhuti;

@property (weak, nonatomic) IBOutlet UILabel *huodongleixingLab;
@property (weak, nonatomic) IBOutlet UILabel *canyurenshuLab;
@property (weak, nonatomic) IBOutlet UITextField *canyurenshuTF;
@property (weak, nonatomic) IBOutlet UILabel *dianhuaLab;
@property (weak, nonatomic) IBOutlet UITextField *dianhuaTF;
@property (weak, nonatomic) IBOutlet UIButton *yudingBtn;


@end
