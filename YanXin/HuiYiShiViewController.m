//
//  HuiYiShiViewController.m
//  YanXin
//
//  Created by mac on 16/3/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HuiYiShiViewController.h"
#import "HuiKeTableViewCell.h"
#import "TanKuang2.h"
@interface HuiYiShiViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    TanKuang2 * tvc;
    UIView * huiView;
}
@property(nonatomic,retain)UITableView * tableView;
@end

@implementation HuiYiShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification1:) name:@"TestNotification1" object:nil];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64-44) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
   
       
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HuiKeTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[HuiKeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSDictionary * dic = _dataArray[indexPath.row];
    cell.dictionary=dic;
    [cell.buttonSelect addTarget:self action:@selector(buttonlianjie:) forControlEvents:UIControlEventTouchUpInside];
    cell.buttonSelect.tag=indexPath.row;
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