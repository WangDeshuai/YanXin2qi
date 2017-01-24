//
//  ButtonSeclt.m
//  YanXin
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ButtonSeclt.h"
#import "LQQMonitorKeyboard.h"
#define NUMBER 5
#import "WHUCalendarPopView.h"
#import "ChooseCityViewController1.h"
@interface ButtonSeclt ()<UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
     WHUCalendarPopView* _pop;
}
@property (nonatomic, strong)NSMutableArray *seletedDays;//选择的日期
@property (nonatomic, copy)NSString *showStr;
@end

@implementation ButtonSeclt

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray * btnArr=[[NSMutableArray alloc]initWithObjects:@"预定演出",@"预定演员",@"预定设备",@"预定场地", nil];
    
    if (_number==3) {
        _label1.text=@"活动时间:";
        _label2.text=@"活动城市:";
        _label3.text=@"活动地址:";
        _label4.text=@"活动主题:";
        _label5.text=@"活动要求:";
//        _label.text=@"活动时间:";
//        _label1.text=@"活动时间:";
    }
    
    
    
    
    [self.navigationItem setTitle:btnArr[_number]];
    self.timeBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.timeBtn.titleEdgeInsets=UIEdgeInsetsMake(-2, 3, 0, 0);
    [self.timeBtn addTarget:self action:@selector(timebtn) forControlEvents:UIControlEventTouchUpInside];
    self.zhuTiTV.layer.borderWidth=1;
    self.zhuTiTV.tag=10;
    self.zhuTiTV.delegate=self;
    self.zhuTiTV.layer.borderColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    self.yaoQiuTV.layer.borderWidth=1;
    self.yaoQiuTV.delegate=self;
    self.yaoQiuTV.tag=11;
    self.yaoQiuTV.layer.borderColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    self.yanchudidian.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.yanchudidian.titleEdgeInsets=UIEdgeInsetsMake(-2, 2, 0, 0);
    self.nameTV.delegate=self;
    self.nameTV.tag=1;
    self.phoneTV.delegate=self;
    self.phoneTV.tag=2;
    _scroller.contentSize=CGSizeMake(0, 0);
    _scroller.delegate=self;
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lianjie:)];
    [_scroller addGestureRecognizer:tap];
      _pop=[[WHUCalendarPopView alloc] init];
     __weak typeof(self)weakSelf=self;
    _pop.onDateSelectBlk=^(NSDate* date){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        
        double shijianCha =[[NSDate date] timeIntervalSinceDate:date];
        int myInt = (int)shijianCha/60/60/24;
        if (myInt<0||myInt==0) {
            NSString *dateString = [format stringFromDate:date];
            _timeRiQi=dateString;
           
            [weakSelf.timeBtn setTitle:dateString forState:0];
            [weakSelf.timeBtn setTitleColor:[UIColor blackColor] forState:0];
        }else
        {
            
            UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"不能选择今天之前的日期" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * queren =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alerview addAction:queren];
            [weakSelf presentViewController:alerview animated:YES completion:nil];
        }
        
        
    };

//
//    [LQQMonitorKeyboard LQQAddMonitorWithShowBack:^(NSInteger height) {
//        
//        _scroller.contentOffset =CGPointMake(0, height);
//        _scroller.scrollEnabled=NO;
//        
//    } andDismissBlock:^(NSInteger height) {
//        _scroller.contentOffset=CGPointMake(0, 0);
//    }];




}

-(void)backClink
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)SaveButton:(UIButton *)sender {
    
    NSString * number = [NSString stringWithFormat:@"%ld",_number+1];
    NSLog(@"演出时间是>>%@",_timeRiQi);
    NSLog(@"演出地点是>>%@",self.addthressTV.text);
    NSLog(@"演出主题是>>%@",self.zhuTiTV.text);
    NSLog(@"演出要求>>%@",self.yaoQiuTV.text);
    NSLog(@"联系人>>%@",self.nameTV.text);
    NSLog(@"电话>>%@",self.phoneTV.text);
    NSLog(@"%@",number);
   // NSData *data = UIImagePNGRepresentation(image1);
    NSData * data =UIImageJPEGRepresentation(image1, 0);
    if (number
        && self.phoneTV.text
        && self.nameTV.text
        && self.yaoQiuTV.text
        && self.zhuTiTV.text
        && self.addthressTV.text
        && _timeRiQi
        && self.yanchudidian.titleLabel.text) {
        
        [ShuJuModel saveYuDingMyMessageWithTime:_timeRiQi Address:self.addthressTV.text zhuTi:self.zhuTiTV.text YaoQiu:self.yaoQiuTV.text Name:self.nameTV.text Phone:self.phoneTV.text Type:number Image:data success:^(NSDictionary *dic) {
            NSLog(@"我是返回%@",dic);
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            if ([code isEqualToString:@"1"]) {
                NSLog(@"上传成功");
              //  [WINDOW showHUDWithText:@"成功预定" Type:ShowPhotoYes Enabled:YES];
            [self.navigationController popViewControllerAnimated:YES];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xianyu"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shiyu"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shengyu"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
                
            }else
            {
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                
            }
            
        } error:^(NSError *error) {
            
        }];
        
    }else{
        NSLog(@"请填完信息");
    }
    
    
 
    
    
}
-(void)textViewDidBeginEditing:(UITextView*)textView
{
    if(textView.tag==10){
        if ([textView.text isEqualToString:@"请填写您的演出主题..."])
        {
            textView.text=@"";
            textView.textColor=[UIColor blackColor];
        }
        
    }else if (textView.tag==11){
        if ([textView.text isEqualToString:@"请填写您的演出要求...."])
        {
            textView.text=@"";
            textView.textColor=[UIColor blackColor];
        }
    }
    
}
-(void)textViewDidEndEditing:(UITextView*)textView{
    
    if (textView.tag==10) {
        if(textView.text.length<1){
            textView.text=@"请填写您的演出主题...";
            textView.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.5];
        }
    }else{
        if(textView.text.length<1){
            textView.text=@"请填写您的演出要求....";
            textView.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:.5];
        }
        
        
    }
    
    
}

-(void)lianjie:(UITapGestureRecognizer*)tap
{
    [_scroller endEditing:YES];
     _scroller.scrollEnabled=YES;
    [UIView animateWithDuration:.3 animations:^{
            _scroller.contentOffset=CGPointMake(0, 0);
        }];
   

}
-(void)timebtn
{
    [_pop show];
}
- (IBAction)imageBtn:(UIButton *)sender {
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    controller.allowsEditing = YES;
    
    [self presentViewController:controller animated:YES completion:nil];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    image1=image;
    [self.lineBtn setBackgroundImage:image forState:0];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  //  [_scroller endEditing:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    //CGFloat content =self.view.frame.size.height -(textField.frame.size.height+216+150);
    
   if(textField.tag==1){
        [UIView animateWithDuration:.3 animations:^{
            _scroller.contentOffset=CGPointMake(0, 160);
           
        }];
    }else if (textField.tag==2){
        [UIView animateWithDuration:.3 animations:^{
            _scroller.contentOffset=CGPointMake(0, 180);
        }];
    }
//
    
    
    
    _scroller.scrollEnabled=NO;
    
    
    return YES;
}

    
   
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


- (IBAction)YanchuDiDianBtn:(UIButton *)sender {
   
    
    ChooseCityViewController1 * vc =nil;
    vc.hidesBottomBarWhenPushed=YES;
    
    if (vc==nil) {
        vc=[ChooseCityViewController1 new];
        vc.yuyuebtn=@"yuyue";
    }
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
  NSString *sheng=[[NSUserDefaults standardUserDefaults]objectForKey:@"shengyu"];
  NSString*shi= [[NSUserDefaults standardUserDefaults]objectForKey:@"shiyu"];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"xianyu"]) {
        
        NSString * string = [NSString stringWithFormat:@"%@%@%@",sheng,shi,[[NSUserDefaults standardUserDefaults]objectForKey:@"xianyu"]];
        [self.yanchudidian setTitle:string forState:0];
        [self.yanchudidian setTitleColor:[UIColor blackColor] forState:0];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xianyu"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shiyu"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shengyu"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
