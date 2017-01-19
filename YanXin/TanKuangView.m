//
//  TanKuangView.m
//  YanXin
//
//  Created by Macx on 17/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanKuangView.h"
@interface TanKuangView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@end
@implementation TanKuangView
//认证说明
-(id)initWithTitle:(NSString*)title cacleBtn:(NSString*)btnName{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5;
        self.clipsToBounds=YES;
         self.bounds=CGRectMake(0, 0, ScreenWidth-60, ScreenHight-300);
        [self CreatKongJianName:title BtnName:btnName];
        [self CraetData];
        [self CreatTabelView];
    }
    
    return self;
}

//充值认证
-(id)initWithChongZhiTitle:(NSString*)title ContentName:(NSString*)content cacleBtn:(NSString*)btnName{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=5;
        self.clipsToBounds=YES;
         self.bounds=CGRectMake(0, 0, ScreenWidth-100, ScreenHight-480);
        //title
        UILabel * nameLabel =[UILabel new];
        nameLabel.font=[UIFont systemFontOfSize:14];
        nameLabel.alpha=.7;
        nameLabel.text=title;
        [self sd_addSubviews:@[nameLabel]];
        nameLabel.sd_layout
        .leftSpaceToView(self,25)
        .rightSpaceToView(self,25)
        .topSpaceToView(self,20)
        .autoHeightRatio(0);
        //content
        UILabel * contentLabel =[UILabel new];
        contentLabel.font=[UIFont systemFontOfSize:14];
        contentLabel.alpha=.7;
        contentLabel.textColor=DAO_COLOR;
        contentLabel.text=content;
        [self sd_addSubviews:@[contentLabel]];
        contentLabel.sd_layout
        .leftSpaceToView(self,25)
        .rightSpaceToView(self,25)
        .topSpaceToView(nameLabel,10)
        .autoHeightRatio(0);
        
        //创建按钮
        UIButton * knowBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        knowBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [knowBtn addTarget:self action:@selector(btnClicknn:) forControlEvents:UIControlEventTouchUpInside];
        [knowBtn setTitleColor:[UIColor blackColor] forState:0];
        [knowBtn setTitle:btnName forState:0];
        [self sd_addSubviews:@[knowBtn]];
        knowBtn.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .bottomSpaceToView(self,0)
        .heightIs(40);
    }
    return self;
}




#pragma mark --创建控件
-(void)CreatKongJianName:(NSString*)name BtnName:(NSString*)btnNameText{
    //创建标题
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=name;
    nameLabel.alpha=.8;
    [self sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self,15)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:220];
    //创建按钮
    UIButton * knowBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    knowBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [knowBtn addTarget:self action:@selector(btnClicknn:) forControlEvents:UIControlEventTouchUpInside];
    [knowBtn setTitleColor:DAO_COLOR forState:0];
    [knowBtn setTitle:btnNameText forState:0];
    [self sd_addSubviews:@[knowBtn]];
    knowBtn.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .heightIs(40);
}

#pragma mark --按钮点击
-(void)btnClicknn:(UIButton*)btn{
    self.BtnClickBlock(btn);
}
-(void)CraetData{
    NSArray * arr1 =@[@"1.基本信息准确无误;",@"2.上传的身份证照片;"];
    NSArray * arr2 =@[@"1.实名认证通过后可以获得已实名的图标;",@"2.实名认证后填写得演员信息不可随意修改;",@"3.实名认证后索索结果靠前,机会越多"];
    _dataArray=@[arr1,arr2];
}


-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.tableFooterView=[UIView new];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,44)
    .bottomSpaceToView(self,44);
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
        nameLabel.tag=10;
        [cell sd_addSubviews:@[nameLabel]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UILabel * namelable =[cell viewWithTag:10];
    namelable.text=_dataArray[indexPath.section][indexPath.row];
    namelable.font=[UIFont systemFontOfSize:14];
    namelable.alpha=.7;
    namelable.sd_layout
    .leftSpaceToView(cell,20)
    .centerYEqualToView(cell)
    .heightIs(20);
    [namelable setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView =[UIView new];
    headView.backgroundColor=COLOR;
    
    UILabel * namelabel =[UILabel new];
    namelabel.font=[UIFont systemFontOfSize:16];
    namelabel.textColor=DAO_COLOR;
    [headView sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(headView,15)
    .centerYEqualToView(headView)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:220];
    if (section==0) {
        namelabel.text=@"认证说明";
    }else{
        namelabel.text=@"认证通过后";
    }
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ToolClass HeightForText:_dataArray[indexPath.section][indexPath.row] withSizeOfLabelFont:15 withWidthOfContent:self.frame.size.width-40]+20;
}



- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    //设置中心点
    self.center = window.center;
   
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    view.tag=1000;
    [window addSubview:view];
    [window addSubview:self];
    
}
-(void)dissmiss{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView * view =[window viewWithTag:1000];
    [view removeFromSuperview];
    [self removeFromSuperview];
    
}
@end
