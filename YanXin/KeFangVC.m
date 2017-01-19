//
//  KeFangVC.m
//  YanXin
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "KeFangVC.h"
#import "HuiKeTableViewCell.h"
@interface KeFangVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView * _tableView;
}
@end

@implementation KeFangVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.view.backgroundColor=[UIColor yellowColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification1:) name:@"TestNotification1" object:nil];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64-44) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray1.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HuiKeTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[HuiKeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSDictionary * dicc =_dataArray1[indexPath.row];
    cell.dictionary=dicc;
    
    [cell.buttonSelect addTarget:self action:@selector(buttonlianjie:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)buttonlianjie:(UIButton*)btn
{
    self.pswNameBlock(btn.tag);
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
- (void)receiveNotification1:(NSNotification *)notification {
    
    // _tableView.scrollEnabled = NO;
    NSDictionary *dic = notification.userInfo;
    NSString *value = [dic objectForKey:@"key1"];
    if ([value isEqualToString:@"-64"]) {
        _tableView.scrollEnabled =NO;
        
    }else {
        _tableView.scrollEnabled =YES;
    }
}
@end
