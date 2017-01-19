//
//  MineVC.m
//  YanXin
//
//  Created by Macx on 17/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MineVC.h"
#import "MineModel.h"
#import "ShenJiVipVC.h"//第一次充值
#import "MyCaiFuVC.h"//我的财富
#import "MyFrieldsVC.h"//我的好友
#import "YanYuanXiangQingVC.h"//演员详情(我的主页)
#import "MyMessageVC.h"//个人信息
#import "SheZhiVC.h"
#import "ChongZhiSectionVC.h"//第二次充值升级会员
@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)NSArray * imageArr;
@property(nonatomic,strong)MineModel * md;
@end

@implementation MineVC
-(void)viewWillAppear:(BOOL)animated{
    if ([ToolClass isLogin]==YES) {
        [self chaXunMyMessage];
    }else{
         _tableView.tableHeaderView=[self CreatTableHead:_md];
    }
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];//导航条
    [self CreatData];
    [self CreatTableView];
    
}

-(void)CreatData{
    NSArray * arr1 =@[@"我的主页"];
    NSArray * arr2 =@[@"升级演员",@"邀请分享"];
    NSArray * arr3 =@[@"设置",@"帮助",@"检验更新"];
    _titleArr=@[arr1,arr2,arr3];
    
    NSArray * arr11 =@[@"my_home"];
    NSArray * arr22 =@[@"my_huyuan",@"my_share"];
    NSArray * arr33 =@[@"my_set",@"my_help",@"my_jiance"];
    _imageArr=@[arr11,arr22,arr33];
    
}
#pragma mark --请求我的资料
-(void)chaXunMyMessage{
    [Engine ChaXunMyMessageAccount:[NSUSE_DEFO objectForKey:@"username"] success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            _md =[[MineModel alloc]initWithMessageDic:contentDic];
            _tableView.tableHeaderView=[self CreatTableHead:_md];
            [_tableView reloadData];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --表头
-(UIView*)CreatTableHead:(MineModel*)md{
    UIView * headView =[UIView new];
    headView.backgroundColor=COLOR;;
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,0);
   
    
    //view1
    UIView * view1 =[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(headView,0)
    .heightIs(80);
    //头像
    UIImageView * lineImage =[UIImageView new];
    lineImage.image=[UIImage imageNamed:@"my_pic"];//
    [view1 sd_addSubviews:@[lineImage]];
    lineImage.sd_layout
    .topSpaceToView(view1,23)
    .leftSpaceToView(view1,15)
    .widthIs(140/2)
    .heightIs(140/2);
    //姓名
    UILabel * nameLabel =[UILabel new];
  
    nameLabel.alpha=.7;
    nameLabel.font=[UIFont systemFontOfSize:15];
    [view1 sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(lineImage,15)
    .topSpaceToView(view1,20)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:120];
    //认证图标
    UIImageView * renZhengImage =[UIImageView new];
   ;//181 158
    [view1 sd_addSubviews:@[renZhengImage]];
    renZhengImage.sd_layout
    .leftSpaceToView(nameLabel,10)
    .centerYEqualToView(nameLabel)
    .widthIs(85/2)
    .heightIs(27/2);
    //VIP图标
    UIImageView * vipImage =[UIImageView new];
   
    [view1 sd_addSubviews:@[vipImage]];
    vipImage.sd_layout
    .centerYEqualToView(renZhengImage)
    .leftSpaceToView(renZhengImage,10)
    .widthIs(79/2)
    .heightIs(26/2);
    
    //右箭头
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"my_arrow"] forState:0];
    [view1 sd_addSubviews:@[button]];
    button.sd_layout
    .rightSpaceToView(view1,15)
    .centerYEqualToView(view1)
    .widthIs(20/2)
    .heightIs(35/2);

    //演信号
    UILabel * numberHao =[UILabel new];
   
    numberHao.alpha=.7;
    numberHao.font=[UIFont systemFontOfSize:15];
    [view1 sd_addSubviews:@[numberHao]];
    numberHao.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(nameLabel,5)
    .heightIs(20);
    [numberHao setSingleLineAutoResizeWithMaxWidth:120];
    //加入时间
    UILabel * timeLabel =[UILabel new];
    timeLabel.alpha=.7;
    timeLabel.font=[UIFont systemFontOfSize:15];
    [view1 sd_addSubviews:@[timeLabel]];
    timeLabel.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(numberHao,5)
    .heightIs(20);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:220];
    [view1 setupAutoHeightWithBottomView:lineImage bottomMargin:23];
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view1Click)];
    [view1 addGestureRecognizer:tap];
    
    if ([ToolClass isLogin]==NO) {
        nameLabel.text=@"";
        numberHao.text=@"未登录";
        timeLabel.text=@"";
        headView.sd_layout.heightIs(203-93);
        return headView;
    }
    

    
    
    UIView * view2 =[UIView new];
    view2.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[view2]];
    view2.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(view1,1)
    .heightIs(186/2);
    
    NSArray * imageA=@[@"my_fr1",@"my_money1-2"];
    //2个按钮
    for (int i =0; i<2; i++) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imageA[i]] forState:0];
        button.tag=i;
        [button addTarget:self action:@selector(twoClick:) forControlEvents:UIControlEventTouchUpInside];
        [view2 sd_addSubviews:@[button]];
        button.sd_layout
        .leftSpaceToView(view2,ScreenWidth/2*i)
        .centerYEqualToView(view2)
        .widthIs(ScreenWidth/2)
        .heightIs(186/2);
       // [view2 setupAutoHeightWithBottomView:button bottomMargin:10];
    }
    
    if ([_md.usertype isEqualToString:@"1"]) {
        //普通用户
        headView.sd_layout.heightIs(203-93);
        view2.hidden=YES;
        nameLabel.text=md.name;
        numberHao.text=@"";
        timeLabel.text=[NSUSE_DEFO objectForKey:@"username"];
        nameLabel.sd_layout
        .leftSpaceToView(lineImage,15)
        .topSpaceToView(view1,35)
        .heightIs(20);
        [nameLabel setSingleLineAutoResizeWithMaxWidth:120];
        timeLabel.sd_layout
        .leftEqualToView(nameLabel)
        .topSpaceToView(nameLabel,10)
        .heightIs(20);
        [timeLabel setSingleLineAutoResizeWithMaxWidth:220];
        
    }else{
        //2演员
        headView.sd_layout.heightIs(207);
        view2.hidden=NO;
        nameLabel.text=md.name;
        renZhengImage.image=[UIImage imageNamed:@"my_shiming"];
        vipImage.image=md.vipImage;
        numberHao.text=[NSString stringWithFormat:@"演信号:%@",md.yanXinnum];
        timeLabel.text=[NSString stringWithFormat:@"加入时间:%@",md.time];
    }

    
    
    
    return headView;
}

#pragma mark --头像点击事件
-(void)view1Click{
    if ([ToolClass isLogin]==NO) {
        MMZCViewController * vc =[MMZCViewController new];
        vc.hidesBottomBarWhenPushed=YES;
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        MyMessageVC * vc =[MyMessageVC new];
        vc.model=_md;
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
 
    }
    
}
#pragma mark --我的财富，我的好友
-(void)twoClick:(UIButton*)btn{
    if (btn.tag==0) {
        //我的好友
        MyFrieldsVC * vc =[MyFrieldsVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //我的财富
        MyCaiFuVC * vc =[MyCaiFuVC new];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[UIView new];
    if (_md==nil) {
        _tableView.tableHeaderView=[self CreatTableHead:nil];
    }
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [_titleArr[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString * idcell =[NSString stringWithFormat:@"%lu%lu",indexPath.section,indexPath.row];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:idcell];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idcell];
        UIButton * imageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.tag=1;
        [cell sd_addSubviews:@[imageBtn]];
        UILabel * label =[UILabel new];
        label.tag=2;
        [cell sd_addSubviews:@[label]];
        
    }
    UIButton *imageBtn =[cell viewWithTag:1];
    imageBtn.showsTouchWhenHighlighted=YES;
    [imageBtn setImage:[UIImage imageNamed:_imageArr[indexPath.section][indexPath.row]] forState:0];
    imageBtn.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .widthIs(80/3)
    .heightIs(80/3);
    UILabel * label =[cell viewWithTag:2];
    label.font=[UIFont systemFontOfSize:15];
    label.text=_titleArr[indexPath.section][indexPath.row];
    label.alpha=.7;
    label.sd_layout
    .leftSpaceToView(imageBtn,10)
    .centerYEqualToView(cell)
    .heightIs(20);
    [label setSingleLineAutoResizeWithMaxWidth:200];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([ToolClass isLogin]==NO) {
        [LCProgressHUD showMessage:@"您还没有登录，请登录"];
        
        return;
    }else{
        
        if (indexPath.section==0) {
            //我的主页
            YanYuanXiangQingVC * vc =[YanYuanXiangQingVC new];
            vc.phoneNum=[NSUSE_DEFO objectForKey:@"username"];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.section==1){
            if (indexPath.row==0) {
                /*
                 升级会员冲值，就ShenJiVipVC
                 第二次是，ChongZhiSectionVC
                 */
                if ([_md.usertype isEqualToString:@"1"]) {
                    ShenJiVipVC * vc =[ShenJiVipVC new];
                    vc.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    ChongZhiSectionVC * vc =[ChongZhiSectionVC new];
                    vc.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            }else{
                //邀请分享
            }
        }else if (indexPath.section==2){
            if (indexPath.row==0) {
                //设置
                SheZhiVC * vc =[SheZhiVC new];
                vc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row==1){
                //帮助
            }else{
                //检验更新
            }
        }
 
        
        
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=COLOR;
    self.title=@"我";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
}
@end
