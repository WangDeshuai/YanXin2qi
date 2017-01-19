//
//  ZhiYeClassVC.m
//  YanXin
//
//  Created by Macx on 17/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ZhiYeClassVC.h"
#import "ZhiYeClassModel.h"
@interface ZhiYeClassVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * leftTableView;
@property(nonatomic,strong)UITableView * rightTableView;
@property(nonatomic,strong)NSMutableArray * dataArray1;
@property(nonatomic,strong)NSMutableArray * dataArray2;

@end

@implementation ZhiYeClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    _dataArray1=[NSMutableArray new];
    _dataArray2=[NSMutableArray new];
    
    [self CreatLeftTabelView];
    [self upDataOneClass];
}


#pragma mark --查询一级分类
-(void)upDataOneClass{
    //1全部，0不包含全部
    [Engine chaXunYanYuanOneClassAll:@"0" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            
            NSArray * contetnArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in contetnArr) {
                ZhiYeClassModel * md =[[ZhiYeClassModel alloc]initWithZhiYeClassDic:dicc];
                [_dataArray1 addObject:md];
            }
            [_leftTableView reloadData];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --查询演员二级分类
-(void)chaXunerJiClassNum:(ZhiYeClassModel*)md{
    // 1.包含 0.不包含
    [_dataArray2 addObject:md];
    [Engine chaXunerJiClassNum:md.zhiYeNum All:@"0" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contetnArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in contetnArr) {
                ZhiYeClassModel * md =[[ZhiYeClassModel alloc]initWithZhiYeClassDic:dicc];
                [_dataArray2 addObject:md];
            }
            [_rightTableView reloadData];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --创建左边的表格
-(void)CreatLeftTabelView{
    if (!_leftTableView) {
        _leftTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2.5, ScreenHight-64) style:UITableViewStylePlain];
    }
    _leftTableView.dataSource=self;
    _leftTableView.delegate=self;
    _leftTableView.backgroundColor=COLOR;
    _leftTableView.tableFooterView=[UIView new];
    [self.view addSubview:_leftTableView];
    
}
#pragma mark --创建右边的表格
-(void)CreatRightTabelView{
    if (!_rightTableView) {
        _rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth/2.5, 64, ScreenWidth/1.5, ScreenHight-64) style:UITableViewStylePlain];
    }
    _rightTableView.dataSource=self;
    _rightTableView.delegate=self;
    _rightTableView.backgroundColor=COLOR;
    _rightTableView.tableFooterView=[UIView new];
    [self.view addSubview:_rightTableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_leftTableView) {
        return _dataArray1.count;
    }else{
        return _dataArray2.count;
  
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
    if (tableView==_leftTableView) {
        ZhiYeClassModel * md =_dataArray1[indexPath.row];
        nameLabel.text=md.zhiYeName;
    }else if (tableView==_rightTableView){
        ZhiYeClassModel * md =_dataArray2[indexPath.row];
        nameLabel.text=md.zhiYeName;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTableView) {
        [_dataArray2 removeAllObjects];
        [self CreatRightTabelView];
        ZhiYeClassModel * md =_dataArray1[indexPath.row];
        [self chaXunerJiClassNum:md];
    }else{
         ZhiYeClassModel * md =_dataArray2[indexPath.row];
        self.classNameBlcok(md.zhiYeNum,md.zhiYeName);
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
    self.title=@"选择职业";
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
