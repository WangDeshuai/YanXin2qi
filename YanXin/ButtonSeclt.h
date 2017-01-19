//
//  ButtonSeclt.h
//  YanXin
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonSeclt : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImage * image1;
}
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;

@property (weak, nonatomic) IBOutlet UITextView *zhuTiTV;
@property (weak, nonatomic) IBOutlet UITextView *yaoQiuTV;
@property (weak, nonatomic) IBOutlet UITextField *nameTV;

@property (weak, nonatomic) IBOutlet UITextField *phoneTV;

@property (weak, nonatomic) IBOutlet UITextField *addthressTV;

@property (nonatomic,assign) NSInteger number;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

@property (nonatomic,retain)NSString *timeRiQi;
@property (weak, nonatomic) IBOutlet UIButton *lineBtn;
- (IBAction)YanchuDiDianBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *yanchudidian;
//这是哪几个Label

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UILabel *label5;

@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;


@end
