//
//  JianJieViC.m
//  YanXin
//
//  Created by Macx on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "JianJieViC.h"
#import "MyFrieldsCell.h"
#import "MyFriendsModel.h"
@interface JianJieViC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation JianJieViC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     _dataArray=[NSMutableArray new];
    [self CreatTabelView];
}
#pragma mark --获取直接好友数据
-(void)huoQuMyFriendsPage:(NSString*)page{
    //1.直接好友 2.间接好友3.其他好友
    [Engine ChaXunMyFriendsZhiJie:@"2" Page:page success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        NSMutableArray * array2 =[NSMutableArray new];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in contentArr) {
                MyFriendsModel * md =[[MyFriendsModel alloc]initWithZhiJieDic:dicc];
                [array2 addObject:md];
            }
            
            if (self.myRefreshView == _tableView.header) {
                _dataArray = array2;
                _tableView.footer.hidden = _dataArray.count==0?YES:NO;
            }else if(self.myRefreshView == _tableView.footer){
                [_dataArray addObjectsFromArray:array2];
            }
            
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        [_tableView reloadData];
        [_myRefreshView  endRefreshing];
        
    } error:^(NSError *error) {
        [LCProgressHUD  hide];
    }];
}


-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, ScreenWidth, ScreenHight-64-50) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"往下拉了");
        _AAA=1;
        weakSelf.myRefreshView = weakSelf.tableView.header;
        [self huoQuMyFriendsPage:[NSString stringWithFormat:@"%d",_AAA]];
    }];
    
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了加载更多");
        _AAA=_AAA+1;
        [self huoQuMyFriendsPage:[NSString stringWithFormat:@"%d",_AAA]];
        
    }];
    _tableView.footer.hidden = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFrieldsCell* cell =[MyFrieldsCell cellWithTableView:_tableView CellID:@"Cell"];
     cell.model=_dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
