//
//  TanKuangYanYuan.m
//  YanXin
//
//  Created by Macx on 17/1/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanKuangYanYuan.h"
@interface TanKuangYanYuan()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation TanKuangYanYuan

-(id)initWithTitle:(NSMutableArray*)titleArr cacleBtn:(NSString*)btnName{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=10;
        self.clipsToBounds=YES;
        self.bounds=CGRectMake(0, 0, ScreenWidth-180, ScreenHight-300);
        _dataArray=titleArr;
        [self CreatTabelView];
    }
    
    return self;
}

-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.tableFooterView=[UIView new];
    [self addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * nameLabel =[UILabel new];
        nameLabel.tag=10;
        [cell sd_addSubviews:@[nameLabel]];
    }
    NewYanYuanModel * md =_dataArray[indexPath.row];
    UILabel * nameLabel =[cell viewWithTag:10];
    nameLabel.text=md.biaoQianName;
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.7;
    
    nameLabel.sd_layout
    .centerXEqualToView(cell)
    .centerYEqualToView(cell)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:220];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.nameBlock(_dataArray[indexPath.row]);
    
}



//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}
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
