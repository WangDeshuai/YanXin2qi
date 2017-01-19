//
//  ChooseCityViewController.m
//  YanXin
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChooseCityViewController.h"
#import "ShiViewController.h"
@interface ChooseCityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    UIView * view;
//    UIButton * namebtn;
}
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * shengArr;
@end

@implementation ChooseCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    _dataArray=[[NSMutableArray alloc]init];
    _shengArr=[NSMutableArray new];
    [self.navigationItem setTitle:@"城市选择"];
//    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    backBtn.hidden=YES;
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    
    view=[UIView new];
    view.frame=CGRectMake(0, 64, KUAN, 44);
    UIButton * namebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    namebtn.backgroundColor=[UIColor whiteColor];
    namebtn.frame=CGRectMake(0, 2,KUAN, 40);
    NSString * str =@"全国(全部)";
    [namebtn setTitle:str forState:0];
    namebtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [namebtn setTitleColor:[UIColor blackColor] forState:0];
    namebtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    namebtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    [namebtn addTarget:self action:@selector(buttonBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:namebtn];
    
    [self.view addSubview:view];
    [self CraetData];
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 44+64+10, KUAN, GAO-64-44) style:UITableViewStylePlain];
    _tableView.tag=100;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    
   
    
    
    
}
-(void)CraetData{
    [ShuJuModel getshengAllsuccess:^(NSDictionary *dic) {
        NSMutableArray * content =[dic objectForKey:@"content"];
        for (NSDictionary * dicc in content) {
            NSString * shengName =[dicc objectForKey:@"name"];
            
            // [self.shengArr addObject:shengName];
            [self.dataArray addObject:shengName];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    }
    cell.textLabel.text=_dataArray[indexPath.row];
   
   cell.textLabel.font=[UIFont systemFontOfSize:15] ;
   cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ShiViewController * shiVC =[ShiViewController new];
    shiVC.messageJie=_messageJie;
    shiVC.shengName=_dataArray[indexPath.row];
    if (_messageJie) {
         [[NSUserDefaults standardUserDefaults]setObject:_dataArray[indexPath.row] forKey:@"sheng1"];
    }else{
       [[NSUserDefaults standardUserDefaults]setObject:_dataArray[indexPath.row] forKey:@"shengz"];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
    shiVC.shiBlock=^(NSString * shneg,NSString*ss){
         self.shouYeBlock(shneg,ss);
    };
    [self.navigationController pushViewController:shiVC animated:YES];
    
}

-(void)buttonBtn:(UIButton*)btn
{
    self.shouYeBlock(@"全国",@"1");
    
    [self.navigationController popViewControllerAnimated:YES];
//    if (_tableView.tag==100) {
//        
//        if (_shouYe) {
//            [[NSUserDefaults standardUserDefaults]setObject:@"全国" forKey:@"shizzz"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//     //   NSLog(@"100000");
////
//        
//    }else{
//       
//        if (_yuyuebtn) {
//            
//        }
//        else if(_zhi){
//           //都不能点击
//        }
//        else {
//        NSString * sheng =[[NSUserDefaults standardUserDefaults]objectForKey:@"sheng2"];
//            NSString * shi =[[NSUserDefaults standardUserDefaults]objectForKey:@"shi2"];
//            if (btn.tag==10) {
//                return;
//            }else{
//               // NSLog(@"输出看看%@",_shengArr[btn.tag]);
//                self.pswNameBlock(sheng,shi,_shengArr[btn.tag]);
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//            
//         }
//
//    }
//        
    
}
-(void)viewWillAppear:(BOOL)animated
{
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sheng2"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shi2"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xian2"];
//    _qqgg=0;
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
-(void)backClink:(UIButton*)btn
{
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xianyu"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shiyu"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shengyu"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xian1"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shi1"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sheng1"];
//    
//    [[NSUserDefaults standardUserDefaults]synchronize];
//
//    
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
-(void)shouYeBtn:(UIButton*)btn{
    
   
//    NSString * sheng =[[NSUserDefaults standardUserDefaults]objectForKey:@"sheng2"];
//    NSString * shi =[[NSUserDefaults standardUserDefaults]objectForKey:@"shi2"];
//    if (_qqgg==10) {
//         self.pswNameBlock(sheng,shi,@"全国");
//    }else{
//         self.pswNameBlock(sheng,shi,_shengArr[btn.tag]);
//    }
//    
//    
//        [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
@end
