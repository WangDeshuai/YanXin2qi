//
//  XiuGaiPassWordVC.m
//  YanXin
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XiuGaiPassWordVC.h"

@interface XiuGaiPassWordVC ()

@end

@implementation XiuGaiPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"修改密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    _bigView.layer.cornerRadius=5;
    _bigView.clipsToBounds=YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)TiJiaoBtn:(UIButton *)sender {
    if ([_sss.text isEqualToString:_queRenWord.text]&&![_sss.text isEqualToString:@""]) {
        
        
        [ShuJuModel xiugaimima:_oldPassWord.text newPsw:_sss.text success:^(NSDictionary *dic) {
            NSString * msgg =[dic objectForKey:@"msg"];
          
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
           
            if ([code isEqualToString:@"1"]) {
                [WINDOW showHUDWithText:msgg Type:ShowPhotoYes Enabled:YES];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                  [WINDOW showHUDWithText:msgg Type:ShowPhotoNo Enabled:YES];
            }
            
            
        } error:^(NSError *error) {
            
        }];

        
        
    }
    
    
}

-(void)backClink
{
    [self.navigationController popViewControllerAnimated:YES];
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

@end
