//
//  ChooseCityViewController1.m
//  YanXin
//
//  Created by Macx on 16/7/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ChooseCityViewController1.h"

@interface ChooseCityViewController1 ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    UIView * view;
    UIButton * namebtn;
}
@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * shengArr;

@end

@implementation ChooseCityViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    _dataArray=[[NSMutableArray alloc]init];
    _shengArr=[NSMutableArray new];
    [self.navigationItem setTitle:@"城市选择"];
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    
    
    
    view=[UIView new];
    view.frame=CGRectMake(0, 64, KUAN, 44);
    namebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    namebtn.backgroundColor=[UIColor whiteColor];
    namebtn.frame=CGRectMake(0, 2,KUAN, 40);
    
    // NSString * ss =[[NSUserDefaults standardUserDefaults]objectForKey:@"shiz"];
    NSString * str =@"全国(全部)";//[NSString stringWithFormat:@"全国",ss];
    [namebtn setTitle:str forState:0];
    namebtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [namebtn setTitleColor:[UIColor blackColor] forState:0];
    namebtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    namebtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    [namebtn addTarget:self action:@selector(buttonBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (_zhi) {
        namebtn.tag=10;
    }else{
        namebtn.tag=11;
    }
    [view addSubview:namebtn];
    
    [self.view addSubview:view];
    
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 44+64+10, KUAN, GAO-64-44-10) style:UITableViewStylePlain];
    _tableView.tag=100;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    [ShuJuModel getshengAllsuccess:^(NSDictionary *dic) {
        NSMutableArray * content =[dic objectForKey:@"content"];
        for (NSDictionary * dicc in content) {
            NSString * shengName =[dicc objectForKey:@"name"];
            
            [self.shengArr addObject:shengName];
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
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==100) {
        NSString * ss =[NSString stringWithFormat:@"%@(全部)",_dataArray[indexPath.row]];
        [namebtn setTitle:ss forState:0];
        // [namebtn setTitle:_dataArray[indexPath.row] forState:0];
        namebtn.tag=indexPath.row;
        [view addSubview:namebtn];
        if (_zhi) {
            [[NSUserDefaults standardUserDefaults]setObject:_dataArray[indexPath.row] forKey:@"sheng1"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        if (_yuyuebtn) {
            [[NSUserDefaults standardUserDefaults]setObject:_dataArray[indexPath.row] forKey:@"shengyu"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
        
        else{
            [[NSUserDefaults standardUserDefaults]setObject:_dataArray[indexPath.row] forKey:@"sheng2"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
        [ShuJuModel getcityAll:_dataArray[indexPath.row] success:^(NSDictionary *dic) {
            [self.dataArray removeAllObjects];
            _tableView.tag=200;
            NSMutableArray * content =[dic objectForKey:@"content"];
            
            for (NSDictionary * dicc in content) {
                NSString * shengName =[dicc objectForKey:@"name"];
                
                [self.dataArray addObject:shengName];
            }
            [_tableView reloadData];
            
        } error:nil];
    }
    if (tableView.tag==200) {
        NSString * ss =[NSString stringWithFormat:@"%@(全部)",_dataArray[indexPath.row]];
        [namebtn setTitle:ss forState:0];
        //[namebtn setTitle:_dataArray[indexPath.row] forState:0];
        
        [view addSubview:namebtn];
        if (_zhi) {
            [[NSUserDefaults standardUserDefaults]setObject:_dataArray[indexPath.row] forKey:@"shi1"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        } if (_yuyuebtn) {
            [[NSUserDefaults standardUserDefaults]setObject:_dataArray[indexPath.row] forKey:@"shiyu"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else{
            [[NSUserDefaults standardUserDefaults]setObject:_dataArray[indexPath.row] forKey:@"shi2"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
        
        
        [ShuJuModel getXianAll:_dataArray[indexPath.row] success:^(NSDictionary *dic) {
            [self.dataArray removeAllObjects];
            _tableView.tag=300;
            NSMutableArray * content =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in content) {
                NSString * shengName =[dicc objectForKey:@"name"];
                
                [self.dataArray addObject:shengName];
            }
            [_tableView reloadData];
        } error:^(NSError *error) {
            
        }];
        
    }
    if (tableView.tag==300) {
        if (_zhi) {
            [[NSUserDefaults standardUserDefaults]setObject:_dataArray[indexPath.row] forKey:@"xian1"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else if (_yuyuebtn) {
            [[NSUserDefaults standardUserDefaults]setObject:_dataArray[indexPath.row] forKey:@"xianyu"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else{
//            NSString * sheng =[[NSUserDefaults standardUserDefaults]objectForKey:@"sheng2"];
//            NSString * shi =[[NSUserDefaults standardUserDefaults]objectForKey:@"shi2"];
          //  self.pswNameBlock(sheng,shi,_dataArray[indexPath.row]);
        }
        
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    
    
    
    
}

-(void)buttonBtn:(UIButton*)btn
{
    
    
    if (_tableView.tag==100) {
        //   NSLog(@"100000");
       
        
    }else{
        
        if (_yuyuebtn) {
            
        }
        else if(_zhi){
            //都不能点击
        }
        else {
//            NSString * sheng =[[NSUserDefaults standardUserDefaults]objectForKey:@"sheng2"];
//            NSString * shi =[[NSUserDefaults standardUserDefaults]objectForKey:@"shi2"];
            
            if (btn.tag==10) {
                return;
            }else{
                // NSLog(@"输出看看%@",_shengArr[btn.tag]);
               // self.pswNameBlock(sheng,shi,_shengArr[btn.tag]);
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sheng2"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shi2"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xian2"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
-(void)backClink:(UIButton*)btn
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xianyu"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shiyu"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shengyu"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xian1"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shi1"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sheng1"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
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
