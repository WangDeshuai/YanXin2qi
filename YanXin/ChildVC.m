//
//  ChildVC.m
//  YanXin
//
//  Created by mac on 16/2/19.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ChildVC.h"
#import "Custom.h"
#import "YanShangModel.h"
#import "YanShangXiQVC.h"

@interface ChildVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@end

@implementation ChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    _dataArray=[NSMutableArray new];
    [self CreatTabelView];
    
    
}

#pragma mark --网络请求数据源
-(void)InteNextDataPage:(NSString*)page{
    //3演出公司，4演出设备，5演出场地
    [Engine ChaXunYanShangPage:page Type:@"3" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
              NSMutableArray * array2=[NSMutableArray new];
            for (NSDictionary * dicc in contentArr) {
                YanShangModel * md =[[YanShangModel alloc]initWithYanChuCommnyDic:dicc];
                [array2 addObject:md];
               
            }
            if (self.myRefreshView == _tableView.header) {
                _dataArray = array2;
                _tableView.footer.hidden = _dataArray.count==0?YES:NO;
            }else if(self.myRefreshView == _tableView.footer){
                [_dataArray addObjectsFromArray:array2];
            }
            [_tableView reloadData];
            [_myRefreshView  endRefreshing];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}




#pragma mark --创建表头
-(UIView*)CreatHeadView{
    UIView * headView=[UIView new];
    headView.backgroundColor=[UIColor redColor];
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .heightIs(200*ScreenHight/667);
    
    
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200*ScreenHight/667) delegate:self placeholderImage:[UIImage imageNamed:@"1@2x.jpg"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    //
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    [headView addSubview:cycleScrollView2];
    
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
           
        };
    

    
    
   
        [ShuJuModel getFirstImage:@"2" success:^(NSDictionary *dic) {
            NSArray *arr2 =[dic objectForKey:@"content"];
            NSMutableArray * titleArr =[NSMutableArray new];
            NSMutableArray * picArray =[NSMutableArray new];
            NSMutableArray * jumpUrl =[NSMutableArray new];
            for (NSDictionary * bgDic2 in arr2){
                NSString * title =[bgDic2 objectForKey:@"title"];
                NSString * picUrl =[bgDic2 objectForKey:@"imgurl"];
                [titleArr addObject:title];
                [picArray addObject:picUrl];
                [jumpUrl addObject:[bgDic2 objectForKey:@"jumpUrl"]];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 cycleScrollView2.imageURLStringsGroup = picArray;
            });
            cycleScrollView2.titlesGroup = titleArr;
            
            
            cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
                NSURL *movieUrl = [NSURL URLWithString:jumpUrl[index]];
                [[UIApplication sharedApplication] openURL:movieUrl];
            };
            
            
            
        } error:^(NSError *error) {
            
        }];

    
    
    
    
    
    return headView;
}


#pragma mark --创建表
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight-49) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[UIView new];
    _tableView.tableHeaderView=[self CreatHeadView];;
    [self.view addSubview:_tableView];
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"往下拉了");
        _AAA=1;
        weakSelf.myRefreshView = weakSelf.tableView.header;
        [self InteNextDataPage:[NSString stringWithFormat:@"%d",_AAA]];
    }];
    
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了加载更多");
        _AAA=_AAA+1;
         [self InteNextDataPage:[NSString stringWithFormat:@"%d",_AAA]];
       
    }];
    _tableView.footer.hidden = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        Custom*cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell=[[Custom alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        YanShangModel * yanMd =_dataArray[indexPath.row];
        cell.model=yanMd;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row] keyPath:@"model" cellClass:[Custom class] contentViewWidth:[ToolClass  cellContentViewWith]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YanShangModel * md =_dataArray[indexPath.row];
    YanShangXiQVC * vc =[YanShangXiQVC new];
    vc.accountPhone=md.yanShangAccount;//把手机号传过去
    vc.titleImage=md.headImageUrl;//把公司图片url传过去
    vc.titleName=md.title;//把公司名字传到下级界面
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];;
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
