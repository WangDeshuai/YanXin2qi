//
//  XianViewController.m
//  YanXin
//
//  Created by Macx on 16/7/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XianViewController.h"

@interface XianViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * view;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation XianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohang];
    [self CreatViewBtn];
    [self CreatshuJuData];
    [self CreatTableView];
}
-(void)CreatViewBtn{
    _dataArray=[NSMutableArray new];
    view=[UIView new];
    view.frame=CGRectMake(0, 64, KUAN, 44);
    UIButton * namebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    namebtn.backgroundColor=[UIColor whiteColor];
    namebtn.frame=CGRectMake(0, 2,KUAN, 40);
    NSString * str =[NSString stringWithFormat:@"%@(全部)",_xianName];
    [namebtn setTitle:str forState:0];
    namebtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [namebtn setTitleColor:[UIColor blackColor] forState:0];
    namebtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    namebtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    [namebtn addTarget:self action:@selector(buttonBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:namebtn];
    [self.view addSubview:view];
    
}
-(void)CreatshuJuData{
    
    [ShuJuModel getXianAll:_xianName success:^(NSDictionary *dic) {
        NSMutableArray * content =[dic objectForKey:@"content"];
        for (NSDictionary * dicc in content) {
            NSString * shengName =[dicc objectForKey:@"name"];
            [self.dataArray addObject:shengName];
     }
            [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];;
    
}

-(void)CreatTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 44+64+10, KUAN, GAO-64-44) style:UITableViewStylePlain];
    _tableView.tag=100;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.xianBlock(_dataArray[indexPath.row],@"300");
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)buttonBtn:(UIButton*)btn{
    
     self.xianBlock(_xianName,@"3");
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
-(void)daohang{
    self.view.backgroundColor=[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [self.navigationItem setTitle:@"城市选择"];
//    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    backBtn.hidden=YES;
    self.navigationItem.leftBarButtonItem=leftBtn;
}
-(void)backClink{
   // [self.navigationController popViewControllerAnimated:YES];
}
@end
