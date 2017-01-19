//
//  HotViewController.m
//  01-网易新闻
//
//  Created by 1 on 15/12/13.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "HotViewController.h"
#import "DongTaiCell.h"
#import "WhoDongTaiModel.h"
@interface HotViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView*_tableView;
//    NSMutableArray * conutArr;
//    NSMutableArray *timeArr;
    NSMutableArray * dataArray;
    WhoDongTaiModel * model;
}

@end

@implementation HotViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lianjieClink:) name:@"pianyi" object:nil];
    dataArray =[[NSMutableArray alloc]init];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
   
    [self jixiData:@"1" Who:_shui];
    //下拉刷新 上拉加载
  //  _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];

    
    
    
    
}
-(void)jixiData:(NSString*)page Who:(NSString*)who;
{
    [ShuJuModel whoWithDongTai:who Page:page Tiaoshu:@"10" success:^(NSDictionary *dic) {
        NSMutableArray * contentArr =[dic objectForKey:@"content"];
        for (NSDictionary * dict  in contentArr) {
            model=[[WhoDongTaiModel alloc]initWithDic:dict];
            [dataArray addObject:model];
        }
        
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

//-(void)headerRefresh
//{
//   // [_tableView.header endRefreshing];
//    
//    
//    
//}
-(void)footerRefresh
{
    [_tableView.footer endRefreshing];
    static int a = 1;
    a=a+1;
    NSString * conde =[NSString stringWithFormat:@"%d",a];
    [self jixiData:conde Who:_shui];
    
}






-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DongTaiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[DongTaiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    cell.model=dataArray[indexPath.row];
    [cell.deleteBtn addTarget:self action:@selector(deleteClinck:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag=indexPath.row;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)deleteClinck:(UIButton*)btn{
    UIAlertController * alertView=nil;
    if (alertView==nil) {
        alertView =[UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除" preferredStyle:UIAlertControllerStyleAlert];
    }
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WhoDongTaiModel *md =dataArray[btn.tag];
        [self deleteMessageID:md];
    }];
    UIAlertAction * action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertView addAction:action1];
    [alertView addAction:action2];
    [self presentViewController:alertView animated:YES completion:nil];
    
}

-(void)deleteMessageID:(WhoDongTaiModel*)messid{
    [ShuJuModel shanChuMymessageID:messid.messageID success:^(NSDictionary *dic) {
        NSLog(@"看一下%@",dic);
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            
            [dataArray removeObject:messid];
            
            [_tableView reloadData];
        }
        
    } error:^(NSError *error) {
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    return [_tableView cellHeightForIndexPath:indexPath model:dataArray[indexPath.row] keyPath:@"model" cellClass:[DongTaiCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
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
- (void)lianjieClink:(NSNotification *)notification {
    
    // _tableView.scrollEnabled = NO;
    NSDictionary *dic = notification.userInfo;
    NSString *value = [dic objectForKey:@"key2"];
    if ([value isEqualToString:@"-20"]) {
        _tableView.scrollEnabled =NO;
        
    }else {
        _tableView.scrollEnabled =YES;
    }
}
@end
