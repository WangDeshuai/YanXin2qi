//
//  ShouYeViewController.m
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ShouYeViewController.h"
#import "FirstCustom.h"
#import "ButtonSeclt.h"
#import "ImageBtn.h"
#import "MMZCViewController.h"
#import "DidSelectVC.h"
#import "XLPopMenuViewModel.h"
#import "XLPopMenuViewSingleton.h"
#import "FirstModel.h"
#import "SouSuoVC.h"
#import "ChooseCityViewController.h"
#import "YuDingChangDiViewController.h"
#import "LrdOutputView.h"
#import "ProvNameCityVC.h"
@interface ShouYeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,LrdOutputViewDelegate,SDCycleScrollViewDelegate>
{
    //城市Label
    UILabel * cityLab;
    //城市箭头
    UIImageView * imageCity;
}
@property (nonatomic,strong) NSArray *menuTitleArr;//下拉菜单数据
@property (nonatomic,strong) NSMutableArray *dataArray;//数据源数组
@property (nonatomic,strong) NSArray *menuArr;//下拉菜单数组
@property(nonatomic,copy)NSString * menuName;//记录下拉菜单选中的字
@property(nonatomic,copy)NSString * menuCode;//记录下拉菜单选中的字
@property (nonatomic, strong) LrdOutputView *outputView;
@property(nonatomic,strong)UITableView  * tableView;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@end

@implementation ShouYeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
     [self CraetDaoHangLeftBtn];//导航条左右按钮
     [self CreatTabelView];//创建表
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    [self.navigationItem setTitle:@"首页"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
   
    _menuCode=@"0";
    
  
    _dataArray=[NSMutableArray new];
   
    [self CreatMenu];//下拉菜单数据源
}

#pragma mark --导航条做按钮
-(void)CraetDaoHangLeftBtn{
    //创建商品商户按钮
   UIButton * leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"全国" forState:0];
    [leftBtn setImage:[UIImage imageNamed:@"home_down"] forState:0];
    //leftBtn.backgroundColor=[UIColor redColor];
    leftBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    
        NSString * sheng =[[NSUserDefaults standardUserDefaults]objectForKey:@"shengz"];
        NSString *shi = [[NSUserDefaults standardUserDefaults]objectForKey:@"shiz"];
        NSString *xian = [[NSUserDefaults standardUserDefaults]objectForKey:@"xianz"];
    
        if (sheng) {
            [leftBtn setTitle:sheng forState:0];
        } if (shi){
            [leftBtn setTitle:shi forState:0];
        } if (xian){
            [leftBtn setTitle:xian forState:0];
        }
        if(shi==nil && sheng==nil&& xian==nil){
            [leftBtn setTitle:@"全国" forState:0];
        }
    
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    leftBtn.frame=CGRectMake(0, 0, 75, 20);
    
    NSDictionary * attr =@{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGFloat k =[leftBtn.titleLabel.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width+15;
    leftBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, k, 0, -11)];
    
    
   // [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -11, 0, 11)];
//    int dd =[ToolClass WidthForString: leftBtn.titleLabel.text withSizeOfFont:15];
//     [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, dd, 0, -11)];
    UIBarButtonItem * leftBtn2 =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems=@[leftBtn2];

    //右按钮（搜索）
      UIButton * souBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      souBtn.frame=CGRectMake(0, 3,20, 20);
      [souBtn setBackgroundImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateNormal];
    [souBtn addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:souBtn];
       self.navigationItem.rightBarButtonItem=right;

}
#pragma mark --左按钮点击事件
-(void)leftBtnClick:(UIButton*)btn{
    ProvNameCityVC * vc =[ProvNameCityVC new];
    vc.hidesBottomBarWhenPushed=YES;
    vc.Block=^(NSString * sheng,NSString*shi,NSString*xian){
        if (shi) {
            [btn setTitle:shi forState:0];
        }else if (sheng){
              [btn setTitle:sheng forState:0];
        }else if (xian){
              [btn setTitle:xian forState:0];
        }else{
             [btn setTitle:@"全国" forState:0];
        }
        NSDictionary * attr =@{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat k =[btn.titleLabel.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width+15;
        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, k, 0, -11)];

        _AAA=1;
        _menuCode=0;
        [self jieXiPublic:[NSString stringWithFormat:@"%d",_AAA] tiao:@"0"];
    };
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark --右按钮
//右按钮
-(void)sousuo
{
   
    SouSuoVC * svc =[[SouSuoVC alloc]init];
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark --解析演出公告
-(void)jieXiPublic:(NSString*)page tiao:(NSString*)type
{
    NSString * sheng =[[NSUserDefaults standardUserDefaults]objectForKey:@"shengz"];
    NSString *shi = [[NSUserDefaults standardUserDefaults]objectForKey:@"shiz"];
    NSString *xian = [[NSUserDefaults standardUserDefaults]objectForKey:@"xianz"];
    NSLog(@"%@%@%@",sheng,shi,xian);
  //  [LCProgressHUD showLoading:@"请稍后..."];
    [ShuJuModel huoquFirstPage:page Tiao:type provname:sheng cityname:shi districtname:xian success:^(NSDictionary *dic) {
        [LCProgressHUD  hide];
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSMutableArray * conArr= [dic objectForKey:@"content"];
            NSMutableArray * array2=[NSMutableArray new];
            for (NSDictionary * dicd in conArr) {
                FirstModel * firstModel =[[FirstModel alloc]initWithDic:dicd];
                [array2 addObject:firstModel];
            }
            NSLog(@"一开始数组的个数%lu",_dataArray.count);
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
        [LCProgressHUD  hide];
    }];



}
#pragma mark --创建表头
-(UIView*)CreatHeadView{
    UIView * headView =[UIView new];
    headView.backgroundColor=[UIColor whiteColor];
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .heightIs(375+35);
    if (ScreenWidth==414) {
       headView.sd_layout.heightIs(375+35);
    }else{
       headView.sd_layout.heightIs(375);
    }
    
    //轮播图
    NSArray * arr =@[@"1@2x.jpg"];
    SDCycleScrollView* cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200*GAO/667) delegate:self placeholderImage:[UIImage imageNamed:@"1@2x.jpg"]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    [headView addSubview:cycleScrollView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = arr;
    });
    cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
         NSLog(@">>>>>  %ld", (long)index);
        
    };
    NSMutableArray * imageArray =[NSMutableArray new];
    NSMutableArray * titleArray =[NSMutableArray new];
    [ShuJuModel getFirstImage:@"1" success:^(NSDictionary *dic) {
        NSArray *arr2 =[dic objectForKey:@"content"];
        NSMutableArray * jumpUrl =[NSMutableArray new];
        for (NSDictionary * bgDic2 in arr2){
            Model1 *model1 = [[Model1 alloc]initWithDic:bgDic2];
            [imageArray addObject:model1.picUrl];
            [titleArray addObject:model1.titleName];
            [jumpUrl addObject:model1.jumpUrl];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView.imageURLStringsGroup = imageArray;
            cycleScrollView.titlesGroup = titleArray;
        });
        
        //视频
        cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
            NSLog(@">>>>>  %ld", (long)index);
            NSURL *movieUrl = [NSURL URLWithString:jumpUrl[index]];
            [[UIApplication sharedApplication] openURL:movieUrl];
        };
       
        
        
    } error:^(NSError *error) {
                
    }];
    NSArray * imageArr=@[@"yan-chu",@"yan-yuan",@"she-bei",@"chang-di"];
    //创建4个按钮
    int k =KUAN/2-15;
    int d =(ScreenWidth-k*2)/3;
    int g=KUAN/5;
    for (int i =0; i<4; i++) {
        UIButton * btnfor=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnfor setBackgroundImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        btnfor.tag=i;
        [headView sd_addSubviews:@[btnfor]];
        [btnfor addTarget:self action:@selector(btnClink:) forControlEvents:UIControlEventTouchUpInside];
        btnfor.sd_layout
        .leftSpaceToView(headView,d+3+(5+k)*(i%2))
        .topSpaceToView(cycleScrollView,10+(g+5)*(i/2))
        .widthIs(k)
        .heightIs(g);
    }
    
    
    
    
    return headView;
}
#pragma mark --4个按钮点击状态
-(void)btnClink:(UIButton*)button{
        NSString *na =   [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        if (na==nil) {
            MMZCViewController * vc =[MMZCViewController new];
            [self presentViewController:vc animated:YES completion:nil];
        }
        else{
            NSLog(@"tag》》》%lu",button.tag);
            if ( button.tag==3) {
                [LCProgressHUD showMessage:@"正在开发中..."];
                return;
            }
                ButtonSeclt * vc =[[ButtonSeclt alloc]init];
                vc.hidesBottomBarWhenPushed=YES;
                vc.number=button.tag;
                [self.navigationController pushViewController:vc animated:YES];
        }

}
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-49) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.tableHeaderView=[self CreatHeadView];
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"往下拉了");
        _AAA=1;
        weakSelf.myRefreshView = weakSelf.tableView.header;
        [self jieXiPublic:[NSString stringWithFormat:@"%d",_AAA] tiao:[self stringText:_menuCode Text2:@"1"]];
    }];
    
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了加载更多");
        _AAA=_AAA+1;
        
         [self jieXiPublic:[NSString stringWithFormat:@"%d",_AAA] tiao:[self stringText:_menuCode Text2:@"1"]];;
    }];
    _tableView.footer.hidden = YES;
    

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstCustom * cell =[FirstCustom cellWithTableView:tableView CellID:[NSString stringWithFormat:@"%lu%lu",indexPath.section,indexPath.row]];
    FirstModel * mode=_dataArray[indexPath.row];
    cell.model=mode;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        FirstModel * md =_dataArray[indexPath.row];
        DidSelectVC * vc =[DidSelectVC new];
        vc.model=md;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView =[UIView new];
    bgView.backgroundColor=COLOR;
   
 //图标
    UIImageView * imageView =[UIImageView new];
    imageView.image=[UIImage imageNamed:@"homei_laba"];
    [bgView sd_addSubviews:@[imageView]];
    imageView.sd_layout
    .leftSpaceToView(bgView,15)
    .centerYEqualToView(bgView)
    .widthIs(23)
    .heightIs(21);
    //文字
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"热门公告";
    nameLabel.textColor=JXColor(0, 170, 238, 1);
    [bgView sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(imageView,10)
    .centerYEqualToView(bgView)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:250];
    
   UIButton * menuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setTitle:[self stringText:_menuName Text2:@"全部"] forState:0];
    [menuBtn  setImage:[UIImage imageNamed:@"home_arrow"] forState:0];
    [menuBtn addTarget:self action:@selector(buttonBtnClinck:) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn setTitleColor:JXColor(0, 170, 238, 1) forState:0];
    menuBtn.titleLabel.font=[UIFont systemFontOfSize:14];
     menuBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView sd_addSubviews:@[menuBtn]];
    if ([menuBtn.titleLabel.text isEqualToString:@"全部"]) {
        menuBtn.sd_layout
        .rightSpaceToView(bgView,15)
        .centerYEqualToView(bgView)
        .widthIs(70)
        .heightIs(30);
    }else{
        menuBtn.sd_layout
        .rightSpaceToView(bgView,15)
        .centerYEqualToView(bgView)
        .widthIs(90)
        .heightIs(30);
    }
    
    
    
   
    NSDictionary * attr =@{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    
    CGFloat k =[menuBtn.titleLabel.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width+15;
    
    
    menuBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [menuBtn setImageEdgeInsets:UIEdgeInsetsMake(0, k, 0, -11)];
    
    
    
    return bgView;
}
#pragma mark --下拉菜单数据源
-(void)CreatMenu{
    
    _menuTitleArr=@[@"全部",@"演出公告",@"演员公告",@"设备公告",@"场地公告"];
    LrdCellModel *one = [[LrdCellModel alloc] initWithTitle:@"全部" imageName:@"all"];
    LrdCellModel *two = [[LrdCellModel alloc] initWithTitle:@"演出公告" imageName:@"yanchugongao"];
    LrdCellModel *three = [[LrdCellModel alloc] initWithTitle:@"演员公告" imageName:@"yanyuan"];
    LrdCellModel *four = [[LrdCellModel alloc] initWithTitle:@"设备公告" imageName:@"shebei"];
    LrdCellModel *five = [[LrdCellModel alloc] initWithTitle:@"场地公告" imageName:@"changdi1"];
    self.menuArr=@[one,two,three,four,five];
    
    
}

#pragma mark --下拉菜单点击事件
-(void)buttonBtnClinck:(UIButton*)btn{
    FirstCustom * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGRect rect =[self.view convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    NSLog(@">>>%f",rect.origin.y);
    CGFloat x = btn.center.x+35;
    CGFloat yy;
    NSLog(@"食醋胡个是%lu",_dataArray.count);
    if (_dataArray.count==0) {
        yy=375+40;
    }
    else if (rect.origin.y<=104) {
        yy=64+30;
    }else{
        yy=rect.origin.y;
    }
    
    _outputView = [[LrdOutputView alloc] initWithDataArray:self.menuArr origin:CGPointMake(x, yy) width:125 height:44 direction:kLrdOutputViewDirectionRight];
    _outputView.delegate = self;
    _outputView.dismissOperation = ^(){
        //设置成nil，以防内存泄露
        _outputView = nil;
    };
    [_outputView pop];

    
}
#pragma mark--下拉菜单选择方法（did）
- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    _menuName=_menuTitleArr[indexPath.row];
    _menuCode=[NSString stringWithFormat:@"%lu",indexPath.row];
    _AAA=1;
    [self jieXiPublic:[NSString stringWithFormat:@"%d",_AAA] tiao:[NSString stringWithFormat:@"%lu",indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row] keyPath:@"model" cellClass:[FirstCustom class] contentViewWidth:[self  cellContentViewWith]];
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



//text1是从后面界面传过来的，text2是从上个界面过来的_model
-(NSString *)stringText:(NSString*)text1 Text2:(NSString*)text2{
    
    NSString * xx;
    if (text1) {
        xx=text1;
    }else{
        xx=text2;
    }
    
    return xx;
}



//
//-(void)setup
//{
//    if ([CLLocationManager locationServicesEnabled]) {
//        //NSLog(@"定位服务可用");
//        _coder = [[CLGeocoder alloc]init];
//        _manager = [[CLLocationManager alloc] init] ;
//        _manager.delegate = self;
//        //设置定位精度
//        _manager.desiredAccuracy=kCLLocationAccuracyBest;
//        _manager.distanceFilter = kCLLocationAccuracyHundredMeters;//每隔多少米定位一次（这里的设置为每隔百米)
//        if (IOS8) {
//            //使用应用程序期间允许访问位置数据
//            [_manager requestWhenInUseAuthorization];
//        }
//        // 开始定位
//        [_manager startUpdatingLocation];
//        
//    }
//    else
//    {
//        NSLog(@"定位服务不可用");
//    }
//    
//    
//}
//
//
//
//
////位置发生改变的时候调用
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    CLLocation * location =[locations lastObject];
//    //  NSLog(@"维度是%f精度是%f",location.coordinate.latitude,location.coordinate.longitude);
//    //维度
//    CLLocationDegrees lat = location.coordinate.latitude;
//    //精度
//    CLLocationDegrees lon = location.coordinate.longitude;
//    
//    if([[NSUserDefaults standardUserDefaults]objectForKey:@"youyou"]){
//    
//        return;
//    }else{
//        [[NSUserDefaults standardUserDefaults]setObject:@"youl" forKey:@"youyou"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        [WINDOW showHUDWithText:@"定位中..." Type:ShowLoading Enabled:YES];
//       
//        CLLocation * aLoc = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
//        [_coder reverseGeocodeLocation:aLoc completionHandler:^(NSArray *placemarks, NSError *error) {
//            
//            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * mark, NSUInteger idx, BOOL *stop) {
//                NSString * shenga =[mark.addressDictionary objectForKey:@"Country"];
//                 [WINDOW showHUDWithText:@"定位成功" Type:ShowDismiss Enabled:YES];
//              //NSLog(@"Country%@",[mark.addressDictionary objectForKey:@"Country"]);
//                [btnDW setTitle:shenga forState:0];
//               // [self jieXiPublic:@"1" tiao:@"0"];
//            }];
//            
//        }];
//
//    }
//    
//    
//}
//
//

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
