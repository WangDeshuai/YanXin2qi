//
//  Message1.h
//  YanXin
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Message1 : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
   
    NSString *text1;
    UIImage * image1;
    NSInteger  numberXB;
    NSInteger  numberSF;
    
    NSString * Xbname;
    NSString * Diquname;
    
    
}

@property (weak, nonatomic) IBOutlet UIButton *save1;
@property (weak, nonatomic) IBOutlet UIButton *save2;

@property (weak, nonatomic) IBOutlet UIImageView *bgimageView;


@property (weak, nonatomic) IBOutlet UITextField *shoujihao;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberHao;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, copy) NSString *selectedath;
@property(nonatomic ,assign)NSInteger number;
@property(nonatomic ,assign)NSInteger number1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerview;
@property (weak, nonatomic) IBOutlet UIButton *lineBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UIButton *xingBieTF;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UIView *yanYuanView;
@property (weak, nonatomic) IBOutlet UITextView *myJingLiTF;
@property (weak, nonatomic) IBOutlet UIButton *zhiYeBtn;
@property (weak, nonatomic) IBOutlet UITextView *myJianjieTF;

@property (nonatomic,retain)NSDictionary * dic;


@end
