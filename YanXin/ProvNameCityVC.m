//
//  ProvNameCityVC.m
//  YanXin
//
//  Created by Macx on 17/1/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ProvNameCityVC.h"

@interface ProvNameCityVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;//最左边的表
@property(nonatomic,strong)UITableView * centerTableView;//中间边的表
@property(nonatomic,strong)UITableView * rightTableView;//最右边的表

@property(nonatomic,strong)NSMutableArray * dataArray1;
@property(nonatomic,strong)NSMutableArray * dataArray2;
@property(nonatomic,strong)NSMutableArray * dataArray3;
////用来记录省市县的,block的时候容易传回去
@property(nonatomic,copy)NSString * shengName;
@property(nonatomic,copy)NSString * shiName;
@end

@implementation ProvNameCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    _dataArray1=[NSMutableArray new];
    _dataArray2=[NSMutableArray new];
    _dataArray3=[NSMutableArray new];
    [self getShengFenData];//获取省份
    [self CreatTabelView];
}
#pragma mark --获取省份
-(void)getShengFenData{
      [_dataArray1 addObject:@"全国"];
    [ShuJuModel getshengAllsuccess:^(NSDictionary *dic) {
        NSMutableArray * content =[dic objectForKey:@"content"];
        for (NSDictionary * dicc in content) {
            NSString * shengName =[dicc objectForKey:@"name"];
            
            [self.dataArray1 addObject:shengName];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
    
}
#pragma mark --获取城市
-(void)CreatshuJuData:(NSString*)shengName{
      [_dataArray2 addObject:shengName];
    [ShuJuModel getcityAll:shengName success:^(NSDictionary *dic) {
        NSMutableArray * content =[dic objectForKey:@"content"];
        
        for (NSDictionary * dicc in content) {
            NSString * shengName =[dicc objectForKey:@"name"];
            
            [_dataArray2 addObject:shengName];
        }
        [_centerTableView reloadData];
        
    } error:nil];
    
    
}

#pragma mark --获取县
-(void)CreatDataXian:(NSString*)cityName{
    [_dataArray3 addObject:cityName];
    [ShuJuModel getXianAll:cityName success:^(NSDictionary *dic) {
        NSMutableArray * content =[dic objectForKey:@"content"];
        
        for (NSDictionary * dicc in content) {
            NSString * shengName =[dicc objectForKey:@"name"];
            
            [_dataArray3 addObject:shengName];
        }
        [_rightTableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --创建最左边的表格
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, ScreenHight) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
    
}
#pragma mark --创建中间的表格
-(void)CreatCenterTabelView{
    [_centerTableView removeFromSuperview];
    _centerTableView=nil;
    if (!_centerTableView) {
        _centerTableView=[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/3, 64, ScreenWidth/3, ScreenHight-64) style:UITableViewStylePlain];
    }
    _centerTableView.dataSource=self;
    _centerTableView.delegate=self;
    _centerTableView.backgroundColor=COLOR;
    _centerTableView.tableFooterView=[UIView new];
    [self.view addSubview:_centerTableView];
    
}

#pragma mark --创建最右边的表格
-(void)CreatRightTableView{
    [_rightTableView removeFromSuperview];
    _rightTableView=nil;
    if (!_rightTableView) {
        _rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/3*2, 64, ScreenWidth/3, ScreenHight-64) style:UITableViewStylePlain];
    }
    _rightTableView.dataSource=self;
    _rightTableView.delegate=self;
    _rightTableView.backgroundColor=COLOR;
    _rightTableView.tableFooterView=[UIView new];
    [self.view addSubview:_rightTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if (tableView==_tableView) {
        return _dataArray1.count;
    }else if (tableView==_centerTableView){
        return _dataArray2.count;
    }else{
        return _dataArray3.count;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * nameLabel =[UILabel new];
        nameLabel.tag=1;
        [cell sd_addSubviews:@[nameLabel]];
    }
    UILabel * nameLabel =[cell viewWithTag:1];
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.7;
    nameLabel.sd_layout
    .centerXEqualToView(cell)
    .centerYEqualToView(cell)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:220];
    if (tableView==_tableView) {
        nameLabel.text=_dataArray1[indexPath.row];
    }else if (tableView==_centerTableView){
        nameLabel.text=_dataArray2[indexPath.row];
    }else{
        nameLabel.text=_dataArray3[indexPath.row];
    }
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        if (indexPath.row==0) {
            //全国
            [_rightTableView removeFromSuperview];
            [_centerTableView removeFromSuperview];
            _shengName=_dataArray1[indexPath.row];
             [NSUSE_DEFO removeObjectForKey:@"shiz"];
             [NSUSE_DEFO removeObjectForKey:@"xianz"];
             [NSUSE_DEFO removeObjectForKey:@"shengz"];
             [NSUSE_DEFO synchronize];
            self.Block(nil,nil,nil);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            //点击第一列的时候移除，第三列
            [_rightTableView removeFromSuperview];
            [self CreatCenterTabelView];
            [_dataArray2 removeAllObjects];
            _shengName=_dataArray1[indexPath.row];
            [self CreatshuJuData:_dataArray1[indexPath.row]];
        }
       
    }else if (tableView==_centerTableView){
        if (indexPath.row==0) {
            [_rightTableView removeFromSuperview];
            _shiName=_dataArray2[indexPath.row];
            [NSUSE_DEFO removeObjectForKey:@"xianz"];
            [NSUSE_DEFO removeObjectForKey:@"shiz"];
            [NSUSE_DEFO setObject:_shengName forKey:@"shengz"];
             [NSUSE_DEFO synchronize];
            self.Block(_shengName,nil,nil);
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self CreatRightTableView];
            [_dataArray3 removeAllObjects];
            _shiName=_dataArray2[indexPath.row];
            [self CreatDataXian:_dataArray2[indexPath.row]];
        }
        
    }else{
        NSString * xianName =_dataArray3[indexPath.row];
         NSLog(@"shengName%@,cityName%@,xianName%@",_shengName,_shiName,xianName);
        [NSUSE_DEFO removeObjectForKey:@"shiz"];
        [NSUSE_DEFO setObject:_shengName forKey:@"shengz"];
        if (![_shengName isEqualToString:_shiName]) {
             [NSUSE_DEFO removeObjectForKey:@"xianz"];
             [NSUSE_DEFO setObject:_shiName forKey:@"shiz"];
        }
       
        if (![_shiName isEqualToString:xianName]) {
            [NSUSE_DEFO setObject:_dataArray3[indexPath.row] forKey:@"xianz"];
        }
       
        [NSUSE_DEFO synchronize];
        self.Block(_shengName,_shiName,_dataArray3[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
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
#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=COLOR;
    self.title=@"选择地区";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    //返回按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
}
-(void)backClink{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
