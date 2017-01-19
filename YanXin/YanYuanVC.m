//
//  YanYuanVC.m
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "YanYuanVC.h"
#import "CuestmYanYuan.h"
#import "YanYuanKongJian.h"
#import "yanyuanModel.h"
#import "SoSuoYanYuanViewController.h"
#import "YanYuanXiangQingVC.h"
#import "NewYanYuanModel.h"//新建演员model
#import "TanKuangYanYuan.h"//二级分类弹框
@interface YanYuanVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UIView * linView;
    UISearchBar * searchBar;
}
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)UIButton * lastBtn;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSString * leiMu;
@property(nonatomic,strong)NSMutableArray * biaoQianArr;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * subArray;//用来存放演员二级分类
@end

@implementation YanYuanVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
     aaaa=1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _biaoQianArr=[NSMutableArray new];
    _dataArray=[NSMutableArray new];
    _subArray=[NSMutableArray new];
    _leiMu=@"0";
    [self daoHangTiao];//导航条
    
    [self CreatTabelView];
    [self CreatRightBtn];//创建右按钮

//

//    
//    
//
}


#pragma mark --创建搜索按钮
-(void)CreatRightBtn{
    //右按钮
    UIButton * souBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    souBtn.frame=CGRectMake(0, 0,20, 20);
    [souBtn setBackgroundImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateNormal];
    [souBtn addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:souBtn];
    self.navigationItem.rightBarButtonItem=right;
    //返回顶端
    UIButton * topBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame=CGRectMake(ScreenWidth-20-40, ScreenHight-56-40, 40, 40);
    [topBtn setBackgroundImage:[UIImage imageNamed:@"向上箭头"] forState:0];
    [topBtn addTarget:self action:@selector(dingduan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topBtn];
}
#pragma mark --返回顶部
-(void)dingduan{
    [_tableView setContentOffset:CGPointMake(0, -64) animated:YES];
}
#pragma mark --右按钮
-(void)sousuo
{
    SoSuoYanYuanViewController * svc =[[SoSuoYanYuanViewController alloc]init];
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
}
#pragma mark --获取演员标签
-(void)getYanYuanBiaoQian{
    [Engine chaXunYanYuanOneClassAll:@"1" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in contentArr) {
                NewYanYuanModel * md =[[NewYanYuanModel alloc]initWithBiaoQianDic:dicc];
                [_biaoQianArr addObject:md];
            }
            _tableView.tableHeaderView=[self CreatHeadView:_biaoQianArr];
            [_tableView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
//    [ShuJuModel huoquyanyuanWihBiaoQian:@"1" success:^(NSDictionary *dic) {
//        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
//        if ([code isEqualToString:@"1"]) {
//            NSArray * contentArr =[dic objectForKey:@"content"];
//            for (NSDictionary * dicc in contentArr) {
//                NewYanYuanModel * md =[[NewYanYuanModel alloc]initWithBiaoQianDic:dicc];
//                [_biaoQianArr addObject:md];
//            }
//            _tableView.tableHeaderView=[self CreatHeadView:_biaoQianArr];
//            [_tableView reloadData];
//        }else{
//            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
//        }
//    } error:^(NSError *error) {
//        
//    }];
}
#pragma mark --获取演员内容
-(void)getYanYuanContentDataPage:(NSString*)page LeiMu:(NSString*)leimu{
    
    [Engine chaXunYanYuanContentCategory:leimu Page:page success:^(NSDictionary *dic) {
                NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                if ([code isEqualToString:@"1"]) {
                    NSArray * contentArr =[dic objectForKey:@"content"];
                    NSMutableArray * array2 =[NSMutableArray new];
                    for (NSDictionary * dicc in contentArr) {
                        yanyuanModel * md =[[yanyuanModel alloc]initWithDic:dicc];
                        [array2 addObject:md];
                    }
                    if (self.myRefreshView == _tableView.header) {
                        _dataArray = array2;
                        _tableView.footer.hidden = _dataArray.count==0?YES:NO;
                    }else if(self.myRefreshView == _tableView.footer){
                        [_dataArray addObjectsFromArray:array2];
                    }
        
                }else{
                    [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                }
                
                [_tableView reloadData];
                [_myRefreshView  endRefreshing];
    } error:^(NSError *error) {
        
    }];
    
//    [ShuJuModel chaxunYanyiquanPage:page Tiaogshu:@"10" Leimu:leimu success:^(NSDictionary *dic) {
//        
//        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
//        if ([code isEqualToString:@"1"]) {
//            NSArray * contentArr =[dic objectForKey:@"content"];
//            NSMutableArray * array2 =[NSMutableArray new];
//            for (NSDictionary * dicc in contentArr) {
//                yanyuanModel * md =[[yanyuanModel alloc]initWithDic:dicc];
//                [array2 addObject:md];
//            }
//            if (self.myRefreshView == _tableView.header) {
//                _dataArray = array2;
//                _tableView.footer.hidden = _dataArray.count==0?YES:NO;
//            }else if(self.myRefreshView == _tableView.footer){
//                [_dataArray addObjectsFromArray:array2];
//            }
//
//        }else{
//            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
//        }
//        
//        [_tableView reloadData];
//        [_myRefreshView  endRefreshing];
//    } error:^(NSError *error) {
//        
//    }];
}
#pragma mark --创建表头
-(UIView*)CreatHeadView:(NSMutableArray*)array{
    UIView * headView =[UIView new];
    headView.backgroundColor=COLOR;
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .heightIs(250);
   
    
    int zk =ScreenWidth-30;
    int d =(zk-108*3)/2;
    for (int i =0; i<array.count; i++) {
         NewYanYuanModel * md=array[i];
        UIButton * clickBtn =[UIButton new];
        clickBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [clickBtn setTitle:md.biaoQianName forState:0];
        [clickBtn setTitleColor:DAO_COLOR forState:UIControlStateNormal];
        [clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [clickBtn setBackgroundImage:[UIImage imageNamed:@"yanyuan_bg"] forState:UIControlStateNormal];
          [clickBtn setBackgroundImage:[UIImage imageNamed:@"yanyuan_bg_click"] forState:UIControlStateSelected];
        [headView sd_addSubviews:@[clickBtn]];
        [clickBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        clickBtn.tag=i;
        clickBtn.sd_layout
        .leftSpaceToView(headView,15+(d+108)*(i%3))
        .topSpaceToView(headView,15+(10+28)*(i/3))
        .widthIs(108)
        .heightIs(28);
        if (i==0) {
            clickBtn.selected=YES;
            _lastBtn=clickBtn;
        }
        
    }
    
    return headView;
}
#pragma mark --点击按钮
-(void)clickButton:(UIButton*)btn{
    _lastBtn.selected=NO;
    btn.selected=YES;
    _lastBtn=btn;
    NewYanYuanModel * md =_biaoQianArr[btn.tag];
    [self huoQuYanYuanerJiClass:md];

}
#pragma mark --获取演员二级分类
-(void)huoQuYanYuanerJiClass:(NewYanYuanModel*)md{
    [_subArray removeAllObjects];
    [_subArray addObject:md];
    [Engine chaXunerJiClassNum:md.biaoQianTag All:@"0" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in contentArr) {
                NewYanYuanModel * md =[[NewYanYuanModel alloc]initWithBiaoQianDic:dicc];
                [_subArray addObject:md];
            }
            TanKuangYanYuan * tk =[[TanKuangYanYuan alloc]initWithTitle:_subArray cacleBtn:@""];
            tk.nameBlock=^(NewYanYuanModel*mdd){
                [_lastBtn setTitle:mdd.biaoQianName forState:0];
                [tk dissmiss];
                _leiMu=mdd.biaoQianTag;
                [_dataArray removeAllObjects];
                _AAA=1;
                [self getYanYuanContentDataPage:[NSString stringWithFormat:@"%d",_AAA] LeiMu:mdd.biaoQianTag];
            };
            [tk show];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
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
    [self getYanYuanBiaoQian];//获取演员标签
    
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"往下拉了");
        _AAA=1;
        weakSelf.myRefreshView = weakSelf.tableView.header;
        [self getYanYuanContentDataPage:[NSString stringWithFormat:@"%d",_AAA] LeiMu:_leiMu];
    }];
   
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了加载更多");
        _AAA=_AAA+1;
         NSLog(@"数出标签%@",_leiMu);
        [self getYanYuanContentDataPage:[NSString stringWithFormat:@"%d",_AAA] LeiMu:_leiMu];
    }];
    _tableView.footer.hidden = YES;

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CuestmYanYuan * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[CuestmYanYuan alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
     cell.model=_dataArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

   yanyuanModel *str = _dataArray[indexPath.row];
    return [_tableView cellHeightForIndexPath:indexPath model:str keyPath:@"model" cellClass:[CuestmYanYuan class] contentViewWidth:[ToolClass  cellContentViewWith]];
}



#pragma mark --表格的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    YanYuanXiangQingVC * vc =[YanYuanXiangQingVC new];
    yanyuanModel * md =_dataArray[indexPath.row];
    vc.phoneNum=md.whoPhone;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
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
#pragma mark--创建导航
-(void)daoHangTiao{
    self.view.backgroundColor=COLOR;
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    self.title=@"演员";
}
@end
