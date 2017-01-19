//
//  YuDingChangDiViewController.m
//  test
//
//  Created by 一口海之言 on 16/4/29.
//  Copyright © 2016年 三米技术. All rights reserved.
//

#import "YuDingChangDiViewController.h"
#import "LQQMonitorKeyboard.h"
#define NUMBER 5
#import "WHUCalendarPopView.h"
#import "ChooseCityViewController.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface YuDingChangDiViewController ()<UITextViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    WHUCalendarPopView* _pop;
}
@property (nonatomic, strong)NSMutableArray *seletedDays;//选择的日期
@property (nonatomic, copy)NSString *showStr;
@property (nonatomic,retain)NSString *timeRiQi;
@property (nonatomic, strong)NSMutableArray *firstArr;//选择的规则
@end

@implementation YuDingChangDiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   // [self yueshu];
    
    self.title=@"预定场地";
    // _bgScroller.contentOffset=CGPointMake(KUAN, 700);
    _bgScroller.contentSize=CGSizeMake(KUAN, 730);
    _bgScroller.scrollEnabled=YES;
    self.yanchushijian.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.yanchushijian.titleEdgeInsets=UIEdgeInsetsMake(-5, 3, 0, 0);
    [self.yanchushijian addTarget:self action:@selector(timeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.huodongLeixing.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.huodongLeixing.titleEdgeInsets=UIEdgeInsetsMake(-5, 3, 0, 0);
    [self.huodongLeixing addTarget:self action:@selector(leixing) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.yanchudidian.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.yanchudidian.titleEdgeInsets=UIEdgeInsetsMake(-5, 3, 0, 0);
    
    
    self.tianxianhuodongzhuti.layer.borderWidth=1;
    self.tianxianhuodongzhuti.tag=10;
    self.tianxianhuodongzhuti.delegate=self;
    self.tianxianhuodongzhuti.layer.borderColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    
    self.tianxiechangdiYaoqiu.layer.borderWidth=1;
    self.tianxiechangdiYaoqiu.tag=11;
    self.tianxiechangdiYaoqiu.delegate=self;
    self.tianxiechangdiYaoqiu.layer.borderColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
  
    _namelianXi.tag=1;
    _namelianXi.delegate=self;
    _dianhuaTF.tag=2;
    _dianhuaTF.delegate=self;
    _canyurenshuTF.delegate=self;
    _canyurenshuTF.tag=3;
    [self riqi];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [_bgScroller addGestureRecognizer:tap];
    
      //



}
//日期选择
-(void)riqi
{
    _pop=[[WHUCalendarPopView alloc] init];
    __weak typeof(self)weakSelf=self;
    _pop.onDateSelectBlk=^(NSDate* date){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy年MM月dd"];
        
        double shijianCha =[[NSDate date] timeIntervalSinceDate:date];
        int myInt = (int)shijianCha/60/60/24;
        if (myInt<0||myInt==0) {
            NSString *dateString = [format stringFromDate:date];
           _timeRiQi=dateString;
            
            [weakSelf.yanchushijian setTitle:dateString forState:0];
            [weakSelf.yanchushijian setTitleColor:[UIColor blackColor] forState:0];
        }else
        {
            
            UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"不能选择今天之前的日期" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * queren =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alerview addAction:queren];
            [weakSelf presentViewController:alerview animated:YES completion:nil];
        }
        
        
    };

    
}
#pragma mark -- 日期选择
-(void)timeBtn
{
     [_pop show];
}
#pragma mark--活动类型
-(void)leixing
{
    

    
    

}






-(void)tap{
    [_bgScroller endEditing:YES];
    _bgScroller.scrollEnabled=YES;
    [UIView animateWithDuration:.3 animations:^{
        _bgScroller.contentOffset=CGPointMake(0, 0);
    }];
}

-(void)textViewDidBeginEditing:(UITextView*)textView
{
    if(textView.tag==10){
        if ([textView.text isEqualToString:@"请填写您的活动主题...."])
        {
            textView.text=@"";
            textView.textColor=[UIColor blackColor];
        }
        
    }else if (textView.tag==11){
        if ([textView.text isEqualToString:@"请填写您的场地要求...."])
        {
            textView.text=@"";
            textView.textColor=[UIColor blackColor];
        }
    }
    
}
-(void)textViewDidEndEditing:(UITextView*)textView{
    
    if (textView.tag==10) {
        if(textView.text.length<1){
            textView.text=@"请填写您的活动主题....";
            textView.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.5];
        }
    }else{
        if(textView.text.length<1){
            textView.text=@"请填写您的场地要求....";
            textView.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.5];
        }
        
        
    }
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
  //  CGFloat content =self.view.frame.size.height -(textField.frame.size.height+216+150);
    
    
    if(textField.tag==1){
       
        [UIView animateWithDuration:.3 animations:^{
            _bgScroller.contentOffset=CGPointMake(0, 160);
            
        }];
    }else if (textField.tag==2){
        
        [UIView animateWithDuration:.3 animations:^{
            _bgScroller.contentOffset=CGPointMake(0, 180);
        }];
    }else if (textField.tag==3){
        [UIView animateWithDuration:.3 animations:^{
            _bgScroller.contentOffset=CGPointMake(0, 120);
        }];
        
    }
    
    
    
    
    _bgScroller.scrollEnabled=NO;
    
    
    return YES;
}
//


//- (void)yueshu
//{
//    _view1.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), Width , 44 / 667.00 * Height);
//    
//    _huodongshijianLab.frame = CGRectMake(10 / 375.00 * Width, 10 / 667.00 * Height, 70 / 375.00 * Width, 30 / 667.00 * Height);
//    _huodongshijianLab.adjustsFontSizeToFitWidth = YES;
//    
//    _xuanzeyanchushijianLab.frame = CGRectMake(CGRectGetMaxX(_huodongshijianLab.frame) + 30, 10 / 667.00 * Height, 180 / 375.00 * Width, 30 / 667.00 * Height);
//    _xuanzeyanchushijianLab.adjustsFontSizeToFitWidth = YES;
//    
//    _button1.frame = CGRectMake(Width - 40 / 375.00 * Width, 10 / 667.00 * Height, 30 / 667.00 * Height, 30 / 667.00 * Height);
//    
//    
//    _view2.frame = CGRectMake(0, CGRectGetMaxY(_view1.frame) + 2, Width, CGRectGetHeight(_view1.frame));
//    
//    _huodongchengshiLab.frame = CGRectMake(10 / 375.00 * Width, 10 / 667.00 * Height, 70 / 375.00 * Width, 30 / 667.00 * Height);
//    _huodongchengshiLab.adjustsFontSizeToFitWidth = YES;
//    
//    _yanchudidianTF.frame = CGRectMake(CGRectGetMaxX(_huodongchengshiLab.frame) + 30, 10 / 667.00 * Height, 180 / 375.00 * Width, 30 / 667.00 * Height);
//    _yanchudidianTF.adjustsFontSizeToFitWidth = YES;
//    
//    
//    
//    _view3.frame = CGRectMake(0, CGRectGetMaxY(_view2.frame) + 10, Width, 165 / 667.00 * Height);
//    
//    _huodongzhutiLab.frame = CGRectMake(10 / 375.00 * Width, 10 / 667.00 * Height, 70 / 375.00 * Width, 30 / 667.00 * Height);
//    _huodongzhutiLab.adjustsFontSizeToFitWidth = YES;
//    
//    _changdiyaoqiuLab.frame = CGRectMake(10 / 375.00 * Width, CGRectGetMaxY(_huodongzhutiLab.frame) + 40, 70 / 375.00 * Width, 30 / 667.00 * Height);
//    _changdiyaoqiuLab.adjustsFontSizeToFitWidth = YES;
//    
//    _tianxiehuodongzhutiTF.frame = CGRectMake(CGRectGetMaxX(_huodongzhutiLab.frame) + 20, 10 / 667.00 * Height, 265 / 375.00 * Width, 70 / 667.00 * Height);
//    _tianxiehuodongzhutiTF.adjustsFontSizeToFitWidth = YES;
//    
//    _tianxiechangdiyaoqiuTF.frame = CGRectMake(CGRectGetMaxX(_changdiyaoqiuLab.frame) + 20, CGRectGetMaxY(_tianxiehuodongzhutiTF.frame) + 5, 265 / 375.00 * Width, 70 / 667.00 * Height);
//    _tianxiechangdiyaoqiuTF.adjustsFontSizeToFitWidth = YES;
//    
//    
//    _view4.frame = CGRectMake(0, CGRectGetMaxY(_view3.frame) + 10, Width, CGRectGetHeight(_view1.frame));
//    
//    _huodongleixingLab.frame = CGRectMake(10 / 375.00 * Width, 10 / 667.00 * Height, 70 / 375.00 * Width, 30 / 667.00 * Height);
//    _huodongleixingLab.adjustsFontSizeToFitWidth = YES;
//    
//    _huodongleixingneirongLab.frame = CGRectMake(CGRectGetMaxX(_huodongleixingLab.frame) + 30, 10 / 667.00 * Height, 180 / 375.00 * Width, 30 / 667.00 * Height);
//    _huodongleixingneirongLab.adjustsFontSizeToFitWidth = YES;
//    
//    _button2.frame = CGRectMake(Width - 40 / 375.00 * Width, 10 / 667.00 * Height, 30 / 667.00 * Height, 30 / 667.00 * Height);
//    
//    
//    
//    _view5.frame = CGRectMake(0, CGRectGetMaxY(_view4.frame) + 2, Width, CGRectGetHeight(_view1.frame));
//    
//    _canyurenshuLab.frame = CGRectMake(10 / 375.00 * Width, 10 / 667.00 * Height, 70 / 375.00 * Width, 30 / 667.00 * Height);
//    _canyurenshuLab.adjustsFontSizeToFitWidth = YES;
//    
//    _canyurenshuTF.frame = CGRectMake(CGRectGetMaxX(_canyurenshuLab.frame) + 30, 10 / 667.00 * Height, 180/ 375.00 * Width, 30 / 667.00 * Height);
//    _canyurenshuTF.adjustsFontSizeToFitWidth = YES;
//    
//    _view6.frame = CGRectMake(0, CGRectGetMaxY(_view5.frame) + 2, Width, CGRectGetHeight(_view1.frame));
//    
//    _lianxirenLab.frame = CGRectMake(10 / 375.00 * Width, 10 / 667.00 * Height, 70 / 375.00 * Width, 30 / 667.00 * Height);
//    _lianxirenLab.adjustsFontSizeToFitWidth = YES;
//    
//    _lianxirenTF.frame = CGRectMake(CGRectGetMaxX(_lianxirenLab.frame) +30 , 10 / 667.00 * Height, 180 / 375.00 * Width, 30 / 667.00 * Height);
//    _lianxirenTF.adjustsFontSizeToFitWidth = YES;
//    
//    
//    
//    _view7.frame = CGRectMake(0, CGRectGetMaxY(_view6.frame) + 2, Width, CGRectGetHeight(_view1.frame));
//    
//    _dianhuaLab.frame = CGRectMake(10 / 375.00 * Width, 10 / 667.00 * Height, 70 / 375.00 * Width, 30 / 667.00 * Height);
//    _dianhuaLab.adjustsFontSizeToFitWidth = YES;
//    
//    _dianhuaTF.frame = CGRectMake(CGRectGetMaxX(_dianhuaLab.frame) + 30, 10 / 667.00 *Height, 180 / 375.00 * Width, 30 / 667.00 * Height);
//    _dianhuaTF.adjustsFontSizeToFitWidth = YES;
//    
//    _yudingBtn.frame = CGRectMake(10 / 375.00 * Width, Height - 60 / 667.00 * Height, 355 / 375.00 *Width, 50 / 667.00 * Height);
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
