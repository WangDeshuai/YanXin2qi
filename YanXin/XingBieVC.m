//
//  XingBieVC.m
//  YanXin
//
//  Created by Macx on 17/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XingBieVC.h"

@interface XingBieVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray* dataArray;
@end

@implementation XingBieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    
    _dataArray=[[NSMutableArray alloc]initWithObjects:@"女",@"男", nil];
    [self CreatTabelView];
}

-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
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
    nameLabel.text=_dataArray[indexPath.row];
    nameLabel.sd_layout
    .centerXEqualToView(cell)
    .centerYEqualToView(cell)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:220];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    self.XingBieBlock(_dataArray[indexPath.row],[NSString stringWithFormat:@"%lu",indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
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
    self.title=@"性别";
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
