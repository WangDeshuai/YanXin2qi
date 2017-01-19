//
//  YanYuanXiangQingVC.m
//  YanXin
//
//  Created by Macx on 16/12/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YanYuanXiangQingVC.h"
#import "NavHeadTitleView.h"
#import "HeadImageView.h"
#import "HeadLineView.h"
#import "JiBenMessageCell.h"//基本信息
#import "DongTaiTableViewCell.h"//动态
#import "XiangCeTableViewCell.h"
#import "WhoYanYuanModel.h"//基本动态model
#import "PhotoViewController.h"//相册
#import "PhotoYuLanView.h"//放大预览
@interface YanYuanXiangQingVC ()<UITableViewDataSource,UITableViewDelegate,headLineDelegate,NavHeadTitleViewDelegate>
{
    //头像
    UIImageView *_headerImg;
    //昵称
    UILabel *_nickLabel;
    NSMutableArray *_dataArray0;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
}
@property(nonatomic,strong)UIImageView *backgroundImgV;//背景图
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,assign)float backImgOrgy;
@property(nonatomic,strong)NavHeadTitleView *NavView;//导航栏
@property(nonatomic,strong)HeadImageView *headImageView;//头视图
@property(nonatomic,strong)HeadLineView *headLineView;//
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,assign)int rowHeight;

@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, assign) CGFloat alphaMemory;
@property(nonatomic,strong) UIButton*  leftBtn;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
//存放基本资料的
@property(nonatomic,strong)NSArray * jibenArr;
//存放动态的
@property(nonatomic,strong)NSMutableArray * dongTaiArr;
//获取照片
@property(nonatomic,strong)NSMutableArray * imageArray;
//获取视频
@property(nonatomic,strong)NSMutableArray * vivtoArray;
@end

@implementation YanYuanXiangQingVC
-(void)viewWillAppear:(BOOL)animated
{

     self.navigationController.navigationBarHidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden=NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    _imageArray=[NSMutableArray new];
    _vivtoArray=[NSMutableArray new];
    //拉伸顶部图片
    [self lashenBgView];
    //创建导航栏
    [self createNav];
    //初始化数据源
    [self loadData];
    //创建TableView
    [self createTableView];
    [self getJiBenZiLiaoData];
}
#pragma mark --获取基本资料数据
-(void)getJiBenZiLiaoData{
    [Engine ChaKanJiBenZiLiaoAccount:_phoneNum success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            WhoYanYuanModel * model=[[WhoYanYuanModel alloc]initWithDic:contentDic];
            NSArray * arr1 =@[model.name,model.sex,model.phoneNumber,model.diqu,model.biaoqian];
            NSArray * arr2 =@[model.myjianjie];
            NSArray * arr3 =@[model.myjingli];
            _jibenArr=@[arr1,arr2,arr3];
            [_tableView reloadData];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --获取动态信息
-(void)getDongTaiMessageDataPage:(NSString*)page{
    [Engine ChaKanYanYuanDongTaiPage:page Account:_phoneNum success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            NSMutableArray * array2 =[NSMutableArray new];
            for (NSDictionary * dicc in contentArr) {
                WhoYanYuanModel * md =[[WhoYanYuanModel alloc]initWithDongTaiDic:dicc];
                [array2 addObject:md];
            }
            
            if (self.myRefreshView == _tableView.header) {
                _dongTaiArr = array2;
                _tableView.footer.hidden = _dongTaiArr.count==0?YES:NO;
            }else if(self.myRefreshView == _tableView.footer){
                [_dongTaiArr addObjectsFromArray:array2];
            }

        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        
        [_tableView reloadData];
        [_myRefreshView  endRefreshing];
        
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --获取相册视频
-(void)getXiangCeVivo{
    //1图片，2视频
    [_imageArray removeAllObjects];
    [_vivtoArray removeAllObjects];
     [_myRefreshView  endRefreshing];
    [Engine ChaKanYanYuanPhotoVitioAccount:_phoneNum Type:@"1" Page:@"1" PageNum:@"6" success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            
            for (NSDictionary * dicc in contentArr) {
                NSString * urlStr =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"url"]]];
                [_imageArray addObject:urlStr];
            }
            
            //获取视频
            [Engine ChaKanYanYuanPhotoVitioAccount:_phoneNum Type:@"2" Page:@"1" PageNum:@"6" success:^(NSDictionary *dic) {
                NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                if ([code isEqualToString:@"1"]) {
                    NSArray * contentArr =[dic objectForKey:@"content"];
                    
                    for (NSDictionary * dicc in contentArr) {
                        NSString * urlStr =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"url"]]];
                        [_vivtoArray addObject:urlStr];
                    }
                    [_tableView reloadData];
                }else
                {
                    [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                }
            } error:^(NSError *error) {
                
            }];
            
            
            
           // [_tableView reloadData];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
}



//创建数据源
-(void)loadData{
    _currentIndex=0;
    
  
    _dataArray2=[[NSMutableArray alloc]init];
    NSArray * arr1 =@[@"姓       名:",@"性       别:",@"联系方式:",@"地       区:",@"职业分类:"];
    NSArray * arr2 =@[@""];
    NSArray * arr3 =@[@""];;
   _dataArray0=[[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3, nil];
   _dataArray1=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3", nil];
  _dataArray2=[[NSMutableArray alloc]initWithObjects:@"11",@"22",@"33", nil];
}

#pragma mark --拉伸顶部图片
//拉伸顶部图片
-(void)lashenBgView{
    UIImage *image=[UIImage imageNamed:@"messege_bg"];
    //图片的宽度设为屏幕的宽度，高度自适应
    NSLog(@"%f",image.size.height);
    _backgroundImgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, image.size.height+40)];
    _backgroundImgV.image=image;
    _backgroundImgV.userInteractionEnabled=YES;
    [self.view addSubview:_backgroundImgV];
    _backImgHeight=_backgroundImgV.frame.size.height;
    _backImgWidth=_backgroundImgV.frame.size.width;
    _backImgOrgy=_backgroundImgV.frame.origin.y;
}
#pragma mark --创建表
-(void)createTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHight-64) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    [_tableView setTableHeaderView:[self headImageView]];
  
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    UIView *targetview = sender.view;
    if(targetview.tag == 1) {
        return;
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (_currentIndex>1) {
            return;
        }
        _currentIndex++;
    }else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (_currentIndex<=0) {
            return;
        }
        _currentIndex--;
    }
    [_headLineView setCurrentIndex:_currentIndex];
}
#pragma mark --区头三个按钮点击事件
-(void)refreshHeadLine:(NSInteger)currentIndex
{
    _currentIndex=currentIndex;
    if (_currentIndex==0) {
        _tableView.header.hidden=YES;
         _tableView.footer.hidden = YES;
    }else if (_currentIndex==1){
        //刷新操作
        __weak typeof (self) weakSelf =self;
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            NSLog(@"往下拉了");
            _AAA=1;
            weakSelf.myRefreshView = weakSelf.tableView.header;
            [self getDongTaiMessageDataPage:[NSString stringWithFormat:@"%d",_AAA]];
        }];
        
        // 马上进入刷新状态
        [_tableView.header beginRefreshing];
        //..上拉刷新
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.myRefreshView = weakSelf.tableView.footer;
            NSLog(@"往上拉了加载更多");
            _AAA=_AAA+1;
            [self getDongTaiMessageDataPage:[NSString stringWithFormat:@"%d",_AAA]];
            
        }];
        _tableView.footer.hidden = YES;
    }else{
        ///[_tableView setContentOffset:CGPointZero animated:YES];
        _tableView.header.hidden=YES;
        _tableView.footer.hidden = YES;
        [self getXiangCeVivo];
    }
    [_tableView reloadData];
}
#pragma mark --区头视图
-(HeadImageView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[HeadImageView alloc]init];
        _headImageView.frame=CGRectMake(0, 64, ScreenWidth, 170);
        _headImageView.backgroundColor=[UIColor clearColor];
        //头像
        _headerImg=[UIImageView new];
        [_headerImg sd_setImageWithURL:[NSURL URLWithString:@"http://img.bitscn.com/upimg/allimg/c160120/1453262R114060-155B6.jpg"] placeholderImage:[UIImage imageNamed:@"messege_big"]];
        _headerImg.sd_cornerRadius=@(78/2);
        [_headImageView sd_addSubviews:@[_headerImg]];
        _headerImg.sd_layout
        .centerXEqualToView(_headImageView)
        .topSpaceToView(_headImageView,5)
        .widthIs(78)
        .heightIs(78);
        //认证图标
        UIImageView * vipimage =[UIImageView new];
        vipimage.image=[UIImage imageNamed:@"messege_shiming"];//181 158
        [_headImageView sd_addSubviews:@[vipimage]];
        vipimage.sd_layout
        .leftSpaceToView(_headImageView,ScreenWidth/2-78/2-10)
        .topSpaceToView(_headerImg,10)
        .widthIs(42)
        .heightIs(13);
       //VIP图标
        UIImageView * renImage =[UIImageView new];
        renImage.image=[UIImage imageNamed:@"messege_vip1"];//181 158
        [_headImageView sd_addSubviews:@[renImage]];
        renImage.sd_layout
        .leftSpaceToView(vipimage,10)
        .topSpaceToView(_headerImg,10)
        .widthIs(42)
        .heightIs(13);
        //演信号
        UILabel * yanXinNumber =[UILabel new];
        yanXinNumber.text=@"演信号:254129572";
        yanXinNumber.font=[UIFont systemFontOfSize:15];
        yanXinNumber.textColor=[UIColor whiteColor];
        [_headImageView sd_addSubviews:@[yanXinNumber]];
        yanXinNumber.sd_layout
        .centerXEqualToView(_headerImg)
        .topSpaceToView(vipimage,10)
        .heightIs(15);
        [yanXinNumber setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        //加入时间
        UILabel * timeLabel =[UILabel new];
        timeLabel.text=@"加入时间:2017-01-13";
        timeLabel.font=[UIFont systemFontOfSize:15];
        timeLabel.textColor=[UIColor whiteColor];
        [_headImageView sd_addSubviews:@[timeLabel]];
        timeLabel.sd_layout
        .centerXEqualToView(_headerImg)
        .topSpaceToView(yanXinNumber,10)
        .heightIs(15);
        [timeLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];

        
        [Engine ChaKanJiBenZiLiaoAccount:_phoneNum success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                NSDictionary * contentDic =[dic objectForKey:@"content"];
                WhoYanYuanModel * model=[[WhoYanYuanModel alloc]initWithDic:contentDic];
                //头像
                [_headerImg sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"messege_big"]];
                //演信号
                yanXinNumber.text=[NSString stringWithFormat:@"演信号%@",model.yanXinNum];
                //vip
                renImage.image=model.vipImage;;
                //注册时间
                 timeLabel.text=[NSString stringWithFormat:@"加入时间%@",model.zhuCeTime];
            }else
            {
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
        } error:^(NSError *error) {
            
        }];
        
        

    }
    return _headImageView;
}
#pragma mark --导航条
-(void)createNav{
    self.NavView=[[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.NavView.title=@"个人中心";
    self.NavView.color=[UIColor whiteColor];
    self.NavView.backTitleImage=@"messege_arrow_left";
    self.NavView.delegate=self;
    [self.view addSubview:self.NavView];
}
//左按钮
-(void)NavHeadback{
    [self.navigationController popViewControllerAnimated:YES];
}
//右按钮回调
-(void)NavHeadToRight{
    NSLog(@"点击了右按钮");
}
#pragma mark ---- UITableViewDelegate ----
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48;
}
#pragma mark --返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex==0) {
        //基本信息
        if (indexPath.section==0) {
            return 44;
        }else{
            return 120;
        }
   
    }else if (_currentIndex==1){
        //动态
        return [_tableView cellHeightForIndexPath:indexPath model:_dongTaiArr[indexPath.row] keyPath:@"model" cellClass:[DongTaiTableViewCell class] contentViewWidth:[ToolClass  cellContentViewWith]];
    }else{
        //相册
        /*
         170是表头的高度
         44是表区头的高度
         44和34是瀑布流区头的高度
         */
        return ScreenHight-170-44-44-34;
    }
  
}
#pragma mark --返回多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentIndex==0) {
        return [_jibenArr[section] count];
    }else if(_currentIndex==1){
        return _dongTaiArr.count;
    }else{
        return 1;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_currentIndex==0) {
        return [_jibenArr count];
    }else{
        return 1;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (_currentIndex==0) {
        if (section==0) {
            if (!_headLineView) {
                _headLineView=[[HeadLineView alloc]init];
                _headLineView.frame=CGRectMake(0, 0, ScreenWidth, 48);
                _headLineView.delegate=self;
                [_headLineView setTitleArray:@[@"基本信息",@"动态",@"相册"]];
            }
        }else if (section==1){
            UIView * newView =[UIView new];
            newView.backgroundColor=COLOR;
            UILabel * nameLabel =[UILabel new];
            nameLabel.text=@"个人简介";
            nameLabel.alpha=.6;
            nameLabel.font=[UIFont systemFontOfSize:16];
            [newView sd_addSubviews:@[nameLabel]];
            nameLabel.sd_layout
            .leftSpaceToView(newView,15)
            .centerYEqualToView(newView)
            .heightIs(20);
            [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
            return newView;
        }
        else{
            UIView * newView =[UIView new];
            newView.backgroundColor=COLOR;
            UILabel * nameLabel =[UILabel new];
            nameLabel.text=@"演艺经历";
            nameLabel.alpha=.6;
            nameLabel.font=[UIFont systemFontOfSize:16];
            [newView sd_addSubviews:@[nameLabel]];
            nameLabel.sd_layout
            .leftSpaceToView(newView,15)
            .centerYEqualToView(newView)
            .heightIs(20);
            [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
            return newView;
        }
        
        
        
        return _headLineView;
    }else{
        if (!_headLineView) {
            _headLineView=[[HeadLineView alloc]init];
            _headLineView.frame=CGRectMake(0, 0, ScreenWidth, 48);
            _headLineView.delegate=self;
            [_headLineView setTitleArray:@[@"基本信息",@"动态",@"相册"]];
        }
    
     return _headLineView;
    }


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_currentIndex==0) {
       
       JiBenMessageCell * cell1=[JiBenMessageCell cellWithTableView:_tableView CellID:@"Cell1"];
        cell1.titleLabel.text=_dataArray0[indexPath.section][indexPath.row];
        if (indexPath.section==0) {
            cell1.nameLabel.hidden=NO;
            cell1.nameLabel.text=_jibenArr[0][indexPath.row];
        }else if (indexPath.section==1){
            cell1.textview.hidden=NO;
            cell1.textview.text=_jibenArr[1][0];
        }else{
            cell1.textview.hidden=NO;
            cell1.textview.text=_jibenArr[2][0];
        }
      
        return cell1;
        
    }else if(_currentIndex==1){
        DongTaiTableViewCell * cell2 =[DongTaiTableViewCell cellWithTableView:_tableView CellID:@"Cell2"];
        cell2.model=_dongTaiArr[indexPath.row];
        return cell2;
    }else if(_currentIndex==2){
       

        
        XiangCeTableViewCell * cell3 =[XiangCeTableViewCell cellWithTableView:_tableView CellID:@"Cell3"];
        cell3.backgroundColor=[UIColor whiteColor];
        NSMutableArray * daArr =[NSMutableArray new];
        if (_imageArray.count!=0) {
             [daArr addObject:_imageArray];
        }
        if (_vivtoArray.count!=0) {
             [daArr addObject:_vivtoArray];
        }
        
        if (daArr.count!=0) {
            cell3.dataArr=daArr;
        }
        [self didPhotoYuLan:cell3];//点击图片预览
        [self moreBtn:cell3];//点击查看更多
        return cell3;
    }
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell被点击恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_currentIndex==0) {
    }else if (_currentIndex==1){
    }else{
    }
}

#pragma mark--点击查看更多(相册、视频)
-(void)moreBtn:(XiangCeTableViewCell*)cell{
    cell.moreBtnBlock=^(UIButton * btn){
    //照片
        PhotoViewController * vc =[PhotoViewController new];
        vc.phoneNum=_phoneNum;
        vc.tagg=btn.tag+1;//1相册，2视频
        [self.navigationController pushViewController:vc animated:YES];
       
    };


}

#pragma mark --点击图片放大预览
-(void)didPhotoYuLan:(XiangCeTableViewCell*)cell{
    cell.IndePathBlock=^(NSIndexPath*indepath){
       NSLog(@"点击状态%lu",indepath.row);
        PhotoYuLanView * vc =[[PhotoYuLanView alloc]initWithFangDa:_imageArray];
        vc.dissBlock=^(){
            [vc dissmiss];
        };
        [vc show];
        
    };
    
}




#pragma mark --滑动时的状态
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int contentOffsety = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y<=170) {
        self.NavView.headBgView.alpha=scrollView.contentOffset.y/170;
        self.NavView.backTitleImage=@"messege_arrow_left";
       
        self.NavView.color=[UIColor whiteColor];
        //状态栏字体白色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    }else{
        self.NavView.headBgView.alpha=1;
        //self.NavView.title
        self.NavView.backTitleImage=@"goback_back_orange_on";
      
        //隐藏黑线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        //状态栏字体黑色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    }
    if (contentOffsety<0) {
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight-contentOffsety;
        rect.size.width = _backImgWidth* (_backImgHeight-contentOffsety)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
    }else{
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight;
        rect.size.width = _backImgWidth;
        rect.origin.x = 0;
        rect.origin.y = -contentOffsety;
        _backgroundImgV.frame = rect;
        
    }
    
}





//-(void)leftBtnClick{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//-(void)createNav{
//    self.NavView=[[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
//    self.NavView.title=@"个人中心";
//    self.NavView.color=[UIColor whiteColor];
//    self.NavView.backTitleImage=@"VIP1";
//    self.NavView.rightTitleImage=@"VIP2";
//    self.NavView.delegate=self;
//    [self.view addSubview:self.NavView];
//}
////左按钮
//-(void)NavHeadback{
//    NSLog(@"点击了左按钮");
//}
////右按钮回调
//-(void)NavHeadToRight{
//    NSLog(@"点击了右按钮");
//}
//
//#pragma mark--创建表头
//-(UIView*)CreatTableViewHead{
//    UIView * headView=[UIView new];
//    headView.backgroundColor=[UIColor redColor];
//    headView.sd_layout
//    .leftSpaceToView(self.view,0)
//    .rightSpaceToView(self.view,0)
//    .topSpaceToView(self.view,-44)
//    .heightIs(170);
//    return headView;
//}
//
//-(void)CreatTableView{
//    if (!_tableView) {
//        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) style:UITableViewStylePlain];
//    }
//    _tableView.dataSource=self;
//    _tableView.delegate=self;
//    _tableView.tableHeaderView=[self CreatTableViewHead];
//    _tableView.tableFooterView=[UIView new];
//    [self.view addSubview:_tableView];
//}
//
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (_currentIndex==0) {
//        return 10;
//    }else if (_currentIndex==1){
//        return 20;
//    }else{
//        return 30;
//    }
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    if (!cell) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
//    cell.textLabel.text=[NSString stringWithFormat:@"%lu",indexPath.row];
//    
//    return cell;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * view =[UIView new];
//    view.backgroundColor=[UIColor yellowColor];
//    for (int i =0; i<3; i++) {
//        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
//        [view sd_addSubviews:@[btn]];
//        btn.tag=i;
//        btn.backgroundColor=[UIColor greenColor];
//        [btn addTarget:self action:@selector(btnfor:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setTitle:[NSString stringWithFormat:@"%lu",section] forState:0];
//        btn.sd_layout
//        .leftSpaceToView(view,ScreenWidth/3*i)
//        .centerYEqualToView(view)
//        .widthIs(ScreenWidth/3)
//        .heightIs(35);
//    }
//    
//    return view;
////    if (!_headLineView) {
////        _headLineView=[[HeadLineView alloc]init];
////        _headLineView.frame=CGRectMake(0, 0, ScreenWidth, 48);
////        _headLineView.delegate=self;
////        [_headLineView setTitleArray:@[@"日鉴",@"阅读",@"物品"]];
////    }
////    //如果headLineView需要添加图片，请到HeadLineView.m中去设置就可以了，里面有注释
////    
//   // return _headLineView;
//}
//-(void)btnfor:(UIButton*)btn{
//    _currentIndex=btn.tag;
//    [_tableView reloadData];
//}
//-(void)refreshHeadLine:(NSInteger)currentIndex
//{
//    _currentIndex=currentIndex;
//    [_tableView reloadData];
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 48;
//}
//#pragma mark --滚动试图代理
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//  //  int contentOffsety = scrollView.contentOffset.y;
//    
//    if (scrollView.contentOffset.y<=170) {
//        self.NavView.headBgView.alpha=scrollView.contentOffset.y/170;
//        self.NavView.backTitleImage=@"Mail";
//        self.NavView.rightImageView=@"Setting";
//        self.NavView.color=[UIColor whiteColor];
//        //状态栏字体白色
//        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
//    }else{
//        self.NavView.headBgView.alpha=1;
//        //self.NavView.title
//        self.NavView.backTitleImage=@"Mail-click";
//        self.NavView.rightImageView=@"Setting-click";
//        self.NavView.color=JXColor(87, 173, 104, 1);
//        //隐藏黑线
//        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//        //状态栏字体黑色
//        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
//    }
//
//    
////    // NSLog(@"%.f",_bgScrollView.contentOffset.y);
////    CGFloat offsetY = scrollView.contentOffset.y;
//////    if (_tableView.contentOffset.y<-10) {
//////        self.navigationController.navigationBarHidden=YES;
//////    }else{
//////        self.navigationController.navigationBarHidden=NO;
//////    }
////   // if (offsetY>=0) {
////        //重新赋值 frame
////    int d=170;
////        if (offsetY<=d) {
////            self.navigationController.navigationBar.tintColor = [UIColor blackColor];
////            //self.navigationController.navigationBar.alpha=offsetY/170;
////            _alphaMemory = offsetY/(d) >= 1 ? 1 : offsetY/(d);
////            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_alphaMemory];
////            
////          
////            
////        }else if (offsetY>d){
////            _alphaMemory = 1;
////           // self.navigationController.navigationBar.alpha=1;
////            [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
////            //隐藏黑线
////            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
////           
////
////        }
////    //}
//    
//}

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
