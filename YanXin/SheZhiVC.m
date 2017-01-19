//
//  SheZhiVC.m
//  YanXin
//
//  Created by Macx on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SheZhiVC.h"
#import "XiuGaiPassWordVC.h"
@interface SheZhiVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation SheZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    [self CreatData];
    [self CreatTabelView];
    [self CreatButton];
}
#pragma mark --创建数据源
-(void)CreatData{
    NSArray * arr1 =@[@"修改密码",@"清楚缓存"];
    NSArray * arr2 =@[@"联系我们",@"关于"];
    _dataArray=[[NSMutableArray alloc]initWithObjects:arr1,arr2, nil];
    
}

#pragma mark --创建按钮
-(void)CreatButton{
    UITableViewCell * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1 ]];
    
    CGRect rect =[self.view convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    
    UIButton * tuiChuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    tuiChuBtn.backgroundColor=DAO_COLOR;
    [tuiChuBtn setTitle:@"退出当前账号" forState:0];
    [tuiChuBtn setTitleColor:[UIColor whiteColor] forState:0];
    tuiChuBtn.frame=CGRectMake(20, rect.size.height+rect.origin.y+30, ScreenWidth-40, 45);
    [tuiChuBtn addTarget:self action:@selector(tuiChuBtn) forControlEvents:UIControlEventTouchUpInside];
    tuiChuBtn.layer.cornerRadius=5;
    tuiChuBtn.clipsToBounds=YES;
    [_tableView addSubview:tuiChuBtn];

    
}
#pragma mark --退出
-(void)tuiChuBtn{
    UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"" message:@"是否确认退出" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"是" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [NSUSE_DEFO removeObjectForKey:@"username"];
        [NSUSE_DEFO removeObjectForKey:@"benrenname"];
        [NSUSE_DEFO synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"否" style:0 handler:nil];
    [actionView addAction:action2];
    [actionView addAction:action1];
    [self presentViewController:actionView animated:YES completion:nil];

   }

#pragma mark --创建表
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * nameLabel =[UILabel new];
        nameLabel.tag=1;
        [cell sd_addSubviews:@[nameLabel]];
        UILabel * dextLabel =[UILabel new];
        dextLabel.tag=2;
        [cell sd_addSubviews:@[dextLabel]];
    }
    UILabel * nameLabel =[cell viewWithTag:1];
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.8;
    nameLabel.text=_dataArray[indexPath.section][indexPath.row];
    nameLabel.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:120];
    UILabel * dextLabel =[cell viewWithTag:2];
    dextLabel.font=[UIFont systemFontOfSize:15];
    dextLabel.alpha=.8;
   
    dextLabel.sd_layout
    .rightSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .heightIs(20);
    [dextLabel setSingleLineAutoResizeWithMaxWidth:320];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //修改密码
        }else{
        //缓存
            dextLabel.text=[NSString stringWithFormat:@"清除缓存(%.2fM)",[NSString getFileSizeWithPath:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches"]]]];
        }
    }else if (indexPath.section==1) {
        if (indexPath.row==0) {
            //联系我们
            dextLabel.text=@"18519186222";
        }else{
            //关于
            dextLabel.text=@"版本号2.0.0";
        }
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //修改密码
            XiuGaiPassWordVC * vc =[XiuGaiPassWordVC new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1){
            //清楚缓存
            UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否清楚缓存" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"是" style:0 handler:^(UIAlertAction * _Nonnull action) {
                NSString * str =[NSString stringWithFormat:@"清理成功，共清理(%.2fM)垃圾",[NSString getFileSizeWithPath:[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches"]]]];
                [LCProgressHUD showMessage:str];
                
                NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                
                NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                
                for (NSString *p in files) {
                    NSError *error;
                    NSString *path = [cachPath stringByAppendingPathComponent:p];
                    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                    }}
                [_tableView reloadData];
            }];
            UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"否" style:0 handler:nil];
            [actionView addAction:action2];
            [actionView addAction:action1];
            [self presentViewController:actionView animated:YES completion:nil];

        }
    }else{
        if (indexPath.row==0) {
            //联系我们
            UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确认拨打" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"是" style:0 handler:^(UIAlertAction * _Nonnull action) {
                [ToolClass tellPhone:@"18519186222"];
            }];
            UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"否" style:0 handler:nil];
            [actionView addAction:action2];
            [actionView addAction:action1];
            [self presentViewController:actionView animated:YES completion:nil];


        }else if (indexPath.row==1){
            //关于
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=COLOR;
    self.title=@"设置";
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
