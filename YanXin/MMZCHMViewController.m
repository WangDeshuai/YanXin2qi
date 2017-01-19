//
//  MMZCHMViewController.m
//  MMR
//
//  Created by qianfeng on 15/6/30.
//  Copyright © 2015年 MaskMan. All rights reserved.
//

#import "MMZCHMViewController.h"
//#import "settingPassWardViewController.h"
//#import "MMZCViewController.h"



@interface MMZCHMViewController ()
{
    UIView *bgView;
    UITextField *phone;
    UITextField *code;
    UITextField *pasCode;
    UITextField *passCode;
    UINavigationBar *customNavigationBar;
    UIButton *yzButton;
    UIImageView * View;
   
}

@property(nonatomic, copy) NSString *oUserPhoneNum;
@property(assign, nonatomic) NSInteger timeCount;
//@property(strong, nonatomic) NSTimer *timer;
//验证码
@property(copy, nonatomic) NSString *smsId;
@end

@implementation MMZCHMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置NavigationBar背景颜色
    View=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    View.image=[UIImage imageNamed:@"bg4.jpg"];
    [self.view addSubview:View];
   
    UIView * view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 64)];
    view1.backgroundColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
    [self.view addSubview:view1];
    //为了显示背景图片自定义navgationbar上面的三个按钮
    UIButton *but =[[UIButton alloc]initWithFrame:CGRectMake(5, 27, 35, 35)];
    [but setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickaddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:but];
    
    UILabel *lanel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-30)/2, 30, 50, 30)];
    lanel.text=@"注册";
    lanel.textColor=[UIColor whiteColor];
    [view1 addSubview:lanel];

    
    
    
    
    
    [self createTextFields];
}

-(void)clickaddBtn:(UIButton *)button
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createTextFields
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 75, self.view.frame.size.width-90, 30)];
    label.text=@"请输入您的手机号码";
    label.textColor=[UIColor grayColor];
    label.textAlignment=0;
    label.font=[UIFont systemFontOfSize:13];
    
    [self.view addSubview:label];
//
   
        CGRect frame=[UIScreen mainScreen].bounds;
        bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 110, frame.size.width-20, 200)];
        bgView.layer.cornerRadius=3.0;
        bgView.backgroundColor=[UIColor colorWithRed:245/255.0 green:243/255.0 blue:237/255.0 alpha:1];
        [self.view addSubview:bgView];
        
        phone=[self createTextFielfFrame:CGRectMake(100, 10, 200, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入手机号"];
        phone.clearButtonMode = UITextFieldViewModeWhileEditing;
        phone.keyboardType=UIKeyboardTypeNumberPad;
  
        code=[self createTextFielfFrame:CGRectMake(100, 60+50, 90, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"请确认密码" ];
        code.clearButtonMode = UITextFieldViewModeWhileEditing;
        code.secureTextEntry=YES;
   
    pasCode=[self createTextFielfFrame:CGRectMake(100, 60, 90, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"请输入密码" ];
    pasCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    pasCode.secureTextEntry=YES;
    
    passCode=[self createTextFielfFrame:CGRectMake(100, 60+100, 90, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"请输入验证码" ];
    passCode.clearButtonMode = UITextFieldViewModeWhileEditing;
 //   passCode.keyboardType=UIKeyboardTypeNumberPad;
    
    
    
    UILabel *phonelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 50, 25)];
    phonelabel.text=@"手机号";
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=0;
    phonelabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *codelabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62+50, 65, 25)];
    codelabel.text=@"确认密码";
    codelabel.textColor=[UIColor blackColor];
    codelabel.textAlignment=0;
    codelabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *passlabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62, 50, 25)];
    passlabel.text=@"密码";
    passlabel.textColor=[UIColor blackColor];
    passlabel.textAlignment=0;
    passlabel.font=[UIFont systemFontOfSize:14];
    
    UILabel *yanzhenglabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 62+100, 65, 25)];
    yanzhenglabel.text=@"验证码";
    yanzhenglabel.textColor=[UIColor blackColor];
    yanzhenglabel.textAlignment=0;
    yanzhenglabel.font=[UIFont systemFontOfSize:14];
    
    yzButton=[[UIButton alloc]initWithFrame:CGRectMake(bgView.frame.size.width-100-20, 62+100, 100, 30)];
    
    [yzButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [yzButton setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1] forState:UIControlStateNormal];
    yzButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [yzButton addTarget:self action:@selector(getValidCode:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:yzButton];
    
    UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 100, bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
     UIImageView *line2=[self createImageViewFrame:CGRectMake(20, 50, bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
     UIImageView *line3=[self createImageViewFrame:CGRectMake(20, 150, bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    UIButton *landBtn=[self createButtonFrame:CGRectMake(10, bgView.frame.size.height+bgView.frame.origin.y+30,self.view.frame.size.width-20, 37) backImageName:nil title:@"完成" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(next)];
    landBtn.backgroundColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
    landBtn.layer.cornerRadius=5.0f;

        
    [bgView addSubview:phone];
    [bgView addSubview:code];
    [bgView addSubview:passlabel];
    [bgView addSubview:phonelabel];
    [bgView addSubview:codelabel];
    [bgView addSubview:line1];
    [bgView addSubview:line2];
    [bgView addSubview:line3];
    [bgView addSubview: yanzhenglabel];
    [bgView addSubview:pasCode];
    [bgView addSubview:passCode];
    [self.view addSubview:landBtn];
    
}
//注册短信验证
- (void)getValidCode:(UIButton *)sender
{
    
   
    // [LCLoadingHUD showLoading:@"验证码获取中..."];
    [ShuJuModel zhuceDuanXinYanZheng:phone.text success:^(NSDictionary *dic) {
        
      NSString*codee=  [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([codee isEqualToString:@"1"]) {
            //实现倒计时
           //  [LCLoadingHUD hideInKeyWindow];
                        __block int timeout=60; //倒计时时间
                        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                     dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                      dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                     dispatch_source_set_event_handler(_timer, ^{
                          if(timeout<=0){ //倒计时结束，关闭
                                dispatch_source_cancel(_timer);
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    //设置界面的按钮显示 根据自己需求设置
                                    [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                                   sender.userInteractionEnabled = YES;
                                });
                            }
                          else{
                                int seconds = timeout % 60;
                                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    //设置界面的按钮显示 根据自己需求设置
                                    //NSLog(@"____%@",strTime);
                                    [UIView beginAnimations:nil context:nil];
                                    [UIView setAnimationDuration:1];
                                    [sender setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                                    [UIView commitAnimations];
                                    sender.userInteractionEnabled = NO;
                                });
                                timeout--;
                            }
                        });
                        dispatch_resume(_timer);
                    }
        
            
    
        
        }
        
     error:^(NSError *error) {
        
    }];

   
    

    
  }

- (void)reduceTime:(NSTimer *)codeTimer {
   
    
   
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

//注册按钮
-(void)next
{
    UIAlertController * ac =[UIAlertController alertControllerWithTitle:@"提示" message:@"请填写完成信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * q =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    if ([phone.text isEqualToString:@""])
    {
       
        [ac addAction:q];
        [self presentViewController:ac animated:YES completion:nil];
        return;
    }
    else if (phone.text.length <11)
    {
      
        [ac addAction:q];
        [self presentViewController:ac animated:YES completion:nil];
        return;
    }
    else if ([code.text isEqualToString:@""])
    {
      
        [ac addAction:q];
        [self presentViewController:ac animated:YES completion:nil];
        return;
    }else if ([code.text isEqualToString:pasCode.text])
    {
       
       
        [self tiaozhuan:passCode.text];
        
       
    }
    
}
-(void)tiaozhuan:(NSString*)yanzhengm
{
    
    
//    NSLog(@">>验证码%@",yanzhengm);
//     NSLog(@">>密码%@",code.text);
   // [LCLoadingHUD showLoading:@"注册中请稍后..."];
    
    [ShuJuModel registUserWithName:phone.text password:code.text  Yanzhengma:yanzhengm success:^(NSDictionary *dic)
                     {
                         NSString * code1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                         if ([code1 isEqualToString:@"1"])
                         {
                             [WINDOW showHUDWithText:@"注册成功" Type:ShowPhotoYes Enabled:YES];
                           //  [LCLoadingHUD hideInKeyWindow];
                             self.pswNameBlock(phone.text,code.text);
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }
                         else
                             {
                               //   [LCLoadingHUD hideInKeyWindow];
                                 [WINDOW showHUDWithText:[dic objectForKey:@"msg"] Type:ShowPhotoNo Enabled:YES];
                                 NSLog(@"%@>>>>>>%@",phone.text,code.text);
                             }
     
                     } error:^(NSError *error)
                      {
                                 
                      }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
