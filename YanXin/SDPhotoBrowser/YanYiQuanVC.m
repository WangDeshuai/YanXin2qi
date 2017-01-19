//
//  YanYiQuanVC.m
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "YanYiQuanVC.h"
#import "YYQTableViewCell.h"
#import "YanYiQuanModel.h"
#import "PublishVC.h"
#import "SDTimeLineCellCommentView.h"
#import "YanYuanKongJian.h"
#import "UIButtonImageWithLable.h"
#import "JPUSHService.h"
#import "CommentsViewController.h"
#define kTimeLineTableViewCellId @"SDTimeLineCell"
static CGFloat textFieldH = 40;

@interface YanYiQuanVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
   // UITableView * _tableView;
    NSMutableArray * dataArr;
    NSArray *iconImageNamesArray;
    NSArray *namesArray;
    NSArray *textArray;
    NSMutableArray *moArr;
    NSArray *picImageNamesArray;
    NSInteger qitaID;
    CGFloat _totalKeybordHeight;
   
}
@property (nonatomic, copy) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, copy) NSString *commentToUser;
@property (nonatomic, copy) NSString *commentToID;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property(nonatomic,retain)NSMutableArray * bageArr;
@property(nonatomic,retain)NSMutableArray * geshuArr;
@end

@implementation YanYiQuanVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // 获取通知中心,添加观察者
        [_geshuArr removeAllObjects];
        _geshuArr=[NSMutableArray new];
//        self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
//        [self.view addSubview:[self tv]];
       // NSLog(@"wwwwwwwwwwwwwwwwwww");
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"123456" object:nil];
       
        
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_textField resignFirstResponder];
    [_textField removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
  NSString*s=[[NSUserDefaults standardUserDefaults]objectForKey:@"Jpush"];
    if (s) {
         _tableView.tableHeaderView=[self headTableview:_geshuArr];
    }else{
         _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor=[UIColor grayColor];
    self.title=@"演艺圈";
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
  //  self.tabBarItem.badgeValue=nil;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    moArr=[[NSMutableArray alloc]init];
    dataArr=[[NSMutableArray alloc]init];
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    //右按钮
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(fabu)];
    
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    [self.view addSubview:[self tv]];
    [self setupTextField];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
   
    UIButton * xiangShangBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    xiangShangBtn.frame=CGRectMake(KUAN-20-40, GAO-56-40, 40, 40);
    
    [xiangShangBtn setBackgroundImage:[UIImage imageNamed:@"向上箭头"] forState:0];
    [xiangShangBtn addTarget:self action:@selector(dingduan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiangShangBtn];
}

-(void)dingduan:(UIButton*)btn{
    [_tableView setContentOffset:CGPointMake(0, -64) animated:YES];
}
- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
   
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}


-(UITableView*)tv{
  
//    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor=[UIColor redColor];
//    btn.frame=CGRectMake(KUAN/2-60, 64, 120, 30);
//    [self.view addSubview:btn];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[YYQTableViewCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
      
        __weak typeof (self) weakSelf =self;
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //[dataArr removeAllObjects];
            // [weakSelf.tableView reloadData];
            weakSelf.myRefreshView = weakSelf.tableView.header;
            aaa=1;
            [self jiexiData:[NSString stringWithFormat:@"%d",aaa]];
          //  NSLog(@"往下拉了");
//            NSString* ss=[[NSUserDefaults standardUserDefaults]objectForKey:@"Jpush"];
//            if (ss) {
//                self.tabBarItem.badgeValue=@"1";
//                _tableView.tableHeaderView=[self headTableview];
//            }

        }];
        
        // 马上进入刷新状态
        [_tableView.header beginRefreshing];
        //..上拉刷新
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.myRefreshView = weakSelf.tv.footer;
            aaa=aaa+1;
            [self jiexiData:[NSString stringWithFormat:@"%d",aaa]];
        }];
        
        _tableView.footer.hidden = YES;
        
    }
    
    return _tableView;
}
-(UIView *)headTableview:(NSMutableArray*)arr{
    
    
    NSString * ad =[NSString stringWithFormat:@"%lu",_geshuArr.count];
    self.tabBarItem.badgeValue=ad;
    
    NSString * ss =[NSString stringWithFormat:@"%lu条未读消息",_geshuArr.count];
    UIView * headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 50)];
     headView.backgroundColor=[UIColor whiteColor];
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeInfoLight];
    btn.backgroundColor=[UIColor lightGrayColor];
    btn.frame=CGRectMake(KUAN/2-60, 10, 120, 30);
    [btn setTitle:ss forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    [btn setBackgroundImage:[UIImage imageNamed:@"Icon111"] forState:0];
    [btn addTarget:self action:@selector(btnClink) forControlEvents:UIControlEventTouchUpInside];
    //top, left, bottom, right
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 90) ];
   // top, left, bottom, right
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0 , 0, 0)];
    
    [headView addSubview:btn];
    return headView;
}


-(void)changeColor:(NSNotification*)notification{
    NSLog(@"我草 通知呢%@",notification.userInfo);
    
    NSString *sting = [notification.userInfo valueForKey:@"business_msg"];
    [_geshuArr addObject:sting];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"123456" object:nil];
   
    _tableView.tableHeaderView=[self headTableview:_geshuArr];
    
}

-(void)btnClink{
     self.tabBarItem.badgeValue=nil;
    CommentsViewController * vc =[[CommentsViewController alloc]init];
    vc.hidesBottomBarWhenPushed=YES;
    vc.dataArray=_geshuArr;
    [self.navigationController pushViewController:vc animated:YES];
    [self dissmiss];
}


-(void)dissmiss{
    //清空数组的个数（是用来显示角标的数组）
    [_geshuArr removeAllObjects];
    //清空推送消息的存储
     [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Jpush"];
     [[NSUserDefaults standardUserDefaults]synchronize];
    
    //把未读消息清空隐藏
     _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    
    
    
}
-(void)jiexiData:(NSString*)page
{
    [ShuJuModel huoquWithPage:page Tiaoshu:@"10" success:^(NSDictionary *dic) {
        NSMutableArray *arrayM =[NSMutableArray new];
        NSArray * temArray= [dic objectForKey:@"content"];
        for (NSDictionary * dicc in temArray) {
            YanYiQuanModel*  model = [[YanYiQuanModel alloc]initWithDic:dicc];
            [arrayM addObject:model];
        }
        
        if (self.myRefreshView == _tableView.header) {
            dataArr = arrayM;
            _tableView.footer.hidden = dataArr.count==0?YES:NO;
        }else if(self.myRefreshView == _tableView.footer){
            [dataArr addObjectsFromArray:arrayM];
        }
        
        
        [_tableView reloadData];
        [self doneWithView:self.myRefreshView];
    } error:^(NSError *error) {
        
    }];


}


#pragma mark -  回调刷新
-(void)doneWithView:(MJRefreshComponent*)refreshView{
    [_tableView reloadData];
    [_myRefreshView  endRefreshing];
}
-(NSArray*)setup1:(YanYiQuanModel*)model
{
    NSMutableArray * resArr=[NSMutableArray new];
     NSMutableArray *tempComments = [NSMutableArray new];
    
   
    for(NSDictionary * dicc in model.pingLun){
        SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
        commentItemModel.firstUserName=[dicc objectForKey:@"disname"];
        commentItemModel.firstUserId = [dicc objectForKey:@"disaccount"];
        commentItemModel.secondUserName=[dicc objectForKey:@"berepliedname"];
        commentItemModel.secondUserId=[dicc objectForKey:@"berepliedaccount"];
        commentItemModel.commentString =[dicc objectForKey:@"content"];
        [tempComments addObject:commentItemModel];
        
    }
     model.commentItemsArray = [tempComments copy];
    
    
    NSMutableArray *tempLikes = [NSMutableArray new];
     for(NSDictionary * zandicc in model.zan){
        SDTimeLineCellLikeItemModel *zan =[SDTimeLineCellLikeItemModel new];
         zan.userName=[zandicc objectForKey:@"name"];
         zan.userId=[NSString stringWithFormat:@"%@",[zandicc objectForKey:@"account"]];
        [tempLikes addObject:zan];
    }
     model.likeItemsArray = [tempLikes copy];
    
//    for (int i = 0;  i<tempLikes.count; i++) {
//        NSLog(@"%@",tempLikes[i]);
//    }
    
    
    
    [resArr addObject:model];
    
    return [resArr copy];
}

-(void)headerRefresh
{
    [_tableView.header endRefreshing];
    aaa=1;
      [dataArr removeAllObjects];
      [_tableView reloadData];
      [self jiexiData:@"1"];
  
}
-(void)footerRefresh
{
    [_tableView.footer endRefreshing];
//    static int a = 1;
//    a=a+1;
     aaa++;
    NSString * conde =[NSString stringWithFormat:@"%d",aaa];
     //[dataArr removeAllObjects];
    [self jiexiData:conde];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   //NSLog(@"里面数组的歌是%d",dataArr.count);
    return dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYQTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
     YanYiQuanModel * mm = dataArr[indexPath.row];
   // NSLog(@">>>mm.name=%@",mm.msgContent);
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            YanYiQuanModel *model1 = dataArr[indexPath.row];
            model1.isOpening = !model1.isOpening;
            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        }];
    }
//
    [cell setDidClickCommentLabelBlock:^(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath,NSString * comidd) {
        weakSelf.textField.placeholder = [NSString stringWithFormat:@"  回复：%@", commentId];
        weakSelf.currentEditingIndexthPath = indexPath;
        [weakSelf.textField becomeFirstResponder];
        weakSelf.isReplayingComment = YES;
        weakSelf.commentToUser = commentId;
        weakSelf.commentToID=comidd;
        [weakSelf adjustTableViewToFitKeyboardWithRect:rectInWindow];
    }];
//
//
//    
    cell.indexPath=indexPath;
    cell.model=mm;
//    cell.model=dataArr[indexPath.row];
    [cell.operationButton addTarget:self action:@selector(pinglun:) forControlEvents:UIControlEventTouchUpInside];
    cell.operationButton.tag=mm.renjiaID;

    [cell.operationButton1 addTarget:self action:@selector(dianzan:) forControlEvents:UIControlEventTouchUpInside];
    cell.operationButton1.tag=mm.renjiaID;
    [cell.operationButton1 setBackgroundImage:[UIImage imageNamed:@"like2"] forState:UIControlStateSelected];
     [cell.operationButton1 setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    cell.operationButton1.selected=NO;
    
    [cell.iconView addTarget:self action:@selector(iconClink:) forControlEvents:UIControlEventTouchUpInside];
    cell.iconView.tag=indexPath.row;
    cell.nameLable.tag=indexPath.row;
    [cell.nameLable addTarget:self action:@selector(iconClink:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)iconClink:(UIButton*)btn{
    
    YanYuanKongJian * yanvc =[YanYuanKongJian new];
    YanYiQuanModel * mm = dataArr[btn.tag];
    yanvc.phone1=mm.zhucehao;
    [self.navigationController pushViewController:yanvc animated:YES];
  //  NSLog(@"输出注册号是%@",mm.zhucehao);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   id mod = dataArr[indexPath.row];
   
   
    return [_tableView cellHeightForIndexPath:indexPath model:mod keyPath:@"model" cellClass:[YYQTableViewCell class] contentViewWidth:[self cellContentViewWith]];
}





#pragma mark --点赞
-(void)dianzan:(UIButton*)sender{
    UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    NSString * huiyuan =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    if ([huiyuan isEqualToString:@"0"] || huiyuan==nil) {
        NSLog(@"没有登录");
        alerview.message=@"您还没有登录请登录,请先登录";
        [alerview addAction:action1];
        [self presentViewController:alerview animated:YES completion:nil];
    }else{
        
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"benrenname"]) {
            NSLog(@"请完善个人资料");
            alerview.message=@"请完善您的个人资料";
            [alerview addAction:action1];
            [self presentViewController:alerview animated:YES completion:nil];
        }else{
            UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
            NSIndexPath *index = [_tableView indexPathForCell:cell];
            YanYiQuanModel * md = dataArr[index.row];
            NSMutableArray *temp = [NSMutableArray arrayWithArray:md.likeItemsArray];
            NSString * idd =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
            
            if (!md.isLiked) {
                SDTimeLineCellLikeItemModel *likeModel = [SDTimeLineCellLikeItemModel new];
                likeModel.userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"benrenname"];
                likeModel.userId =idd;
                [temp addObject:likeModel];
                
                md.liked = YES;
            }else {
                SDTimeLineCellLikeItemModel *tempLikeModel = nil;
                for (SDTimeLineCellLikeItemModel *likeModel in md.likeItemsArray) {
                    if ([likeModel.userId isEqualToString:idd]) {
                        tempLikeModel = likeModel;
                        break;
                    }
                }
                [temp removeObject:tempLikeModel];
                md.liked = NO;
            }
            md.likeItemsArray = [temp copy];
            
            [ShuJuModel shangchuanzanLikedyid:[NSString stringWithFormat:@"%lu",sender.tag] success:^(NSDictionary *dic) {
                
            } error:nil];
            [_tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        }

            
        }
        
        
    
    
    
    
}

-(void)pinglun:(UIButton*)sender
{
   // NSLog(@"点击评论了");
    UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    NSString * huiyuan =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    if ([huiyuan isEqualToString:@"0"] || huiyuan==nil) {
        NSLog(@"没有登录");
        alerview.message=@"您还没有登录请登录,请先登录";
        [alerview addAction:action1];
        [self presentViewController:alerview animated:YES completion:nil];
        
        
    }else{
        
        if (![[NSUserDefaults standardUserDefaults]objectForKey:@"benrenname"]) {
            NSLog(@"请完善个人资料");
            alerview.message=@"请完善您的个人资料";
            [alerview addAction:action1];
            [self presentViewController:alerview animated:YES completion:nil];
            
            
        }else{
            qitaID=sender.tag;
            UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
            [_textField becomeFirstResponder];
            
            _currentEditingIndexthPath = [_tableView indexPathForCell:cell];
            [self adjustTableViewToFitKeyboard];
        
        }
   
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
         [_textField resignFirstResponder];
        YanYiQuanModel *dm =dataArr[_currentEditingIndexthPath.row];
        
         NSString * benren =[[NSUserDefaults standardUserDefaults]objectForKey:@"benrenname"];
        SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:dm.commentItemsArray];
        
        if (self.isReplayingComment) {
             NSLog(@"你回复人的名字是%@",self.commentToUser);
            NSLog(@"你回复人的ID是%@",self.commentToID);
    
            // NSLog(@"其他的ID是%lu",dm.renjiaID);
            commentItemModel.firstUserName = benren;
            commentItemModel.firstUserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
            commentItemModel.secondUserName = self.commentToUser;
            commentItemModel.secondUserId = self.commentToID;
            commentItemModel.commentString = textField.text;
            self.isReplayingComment = NO;
            
            [ShuJuModel huifupinglun:[NSString stringWithFormat:@"%lu",dm.renjiaID] Neirong:textField.text huifuren:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]] huifushui:self.commentToID success:^(NSDictionary *dic) {
                
            } error:^(NSError *error) {
                
            }];
        }else{
           // NSLog(@"你评论的");
                 //NSLog(@"www其他的ID是%lu",qitaID);
            commentItemModel.firstUserName = benren;
            commentItemModel.commentString = _textField.text;
            commentItemModel.firstUserId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
            NSLog(@"评论人的名字%@",_textField.text);
            NSLog(@"评论人的ID是%@",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]]);

            
            [ShuJuModel huifupinglun:[NSString stringWithFormat:@"%lu",qitaID] Neirong:textField.text huifuren:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]] huifushui:@"" success:^(NSDictionary *dic) {
                
            } error:^(NSError *error) {
                
            }];


        }
        
        [temp addObject:commentItemModel];
        dm.commentItemsArray = [temp copy];
        [_tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
        
        _textField.text = @"";
          _textField.placeholder = nil;
        return YES;
    }
    
    return NO;
}
- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _textField.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + textFieldH;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
}



- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
//    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
//    
//    CGPoint offset = _tableView.contentOffset;
//    offset.y += delta;
//    if (offset.y < 0) {
//        offset.y = 0;
//    }
//    
//    [_tableView setContentOffset:offset animated:YES];
}
- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = _tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [_tableView setContentOffset:offset animated:YES];
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
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_textField resignFirstResponder];
     _textField.placeholder = nil;
}
#pragma mark --右按钮发布动态
-(void)fabu
{
    
    UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    NSString * dengl =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
   
    if (!dengl) {
        alerview.message=@"您还没有登陆，请先登录";
        [alerview addAction:action1];
        [self presentViewController:alerview animated:YES completion:nil];
    }
    else{
    NSString * huiyuan =[[NSUserDefaults standardUserDefaults]objectForKey:@"huiyuanma"];
    if ([huiyuan isEqualToString:@"0"] || huiyuan==nil) {
       
             alerview.message=@"您还不是演员,请先升级为演员";
       
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"升级演员" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            ZhiFuViewController * vc =[ZhiFuViewController new];
//            [self.navigationController pushViewController:vc animated:YES];
        }];
        [alerview addAction:action1];
        [alerview addAction:action2];
        [self presentViewController:alerview animated:YES completion:nil];
    }else{
        PublishVC * vc =[PublishVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
   
    [_textField removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)backClink:(UIButton*)btn
{
    self.tabBarController.selectedIndex=0;
}
@end
