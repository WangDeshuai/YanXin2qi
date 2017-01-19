//
//  KeJiSuanVC.m
//  YanXin
//
//  Created by Macx on 17/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "KeJiSuanVC.h"

@interface KeJiSuanVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation KeJiSuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray=@[@"银行卡号",@"持卡人姓名"];
    [self CreatTabelView];
    [self CreatView];
}
#pragma mark --创建表头
-(UIView*)CraetTabelViewHead{
    UIView * headView =[UIView new];
    headView.backgroundColor=COLOR;
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64+50)
    .heightIs(180);
    UIView * bgView =[UIView new];
    bgView.backgroundColor=[UIColor whiteColor];
    [headView sd_addSubviews:@[bgView]];
    bgView.sd_layout
    .leftSpaceToView(headView,5)
    .rightSpaceToView(headView,5)
    .topSpaceToView(headView,0)
    .bottomSpaceToView(headView,5);
    
    //namelabel
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"当前积分";
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.7;
    [bgView sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(bgView,15)
    .topSpaceToView(bgView,15)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:120];
    //财富明细
    UIButton * caiFuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [caiFuBtn setBackgroundImage:[UIImage imageNamed:@"cf_bt"] forState:0];
    [bgView sd_addSubviews:@[caiFuBtn]];
    caiFuBtn.sd_layout
    .rightSpaceToView(bgView,15)
    .centerYEqualToView(nameLabel)
    .widthIs(66)
    .heightIs(15);
    
    //price
    UILabel * priceLable =[UILabel new];
    priceLable.text=@"1114.05";
    priceLable.font=[UIFont systemFontOfSize:50 weight:.01];
    priceLable.textColor=JXColor(75, 157, 249, 1);
    [bgView sd_addSubviews:@[priceLable]];
    priceLable.sd_layout
    .centerYEqualToView(bgView)
    .centerXEqualToView(bgView)
    .heightIs(40);
    [priceLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    return headView;
}


-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64+50, ScreenWidth, ScreenHight-64-50) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor redColor];
    _tableView.tableHeaderView=[self CraetTabelViewHead];
     self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * namelabel =[UILabel new];
        namelabel.tag=1;
        [cell sd_addSubviews:@[namelabel]];
    }
    UILabel * namelabel =[cell viewWithTag:1];
    namelabel.alpha=.7;
    namelabel.font=[UIFont systemFontOfSize:15];
    namelabel.text=_dataArray[indexPath.row];
    namelabel.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:220];
    
    
    
    return cell;
}

-(void)CreatView{
    
    UITableViewCell * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CGRect rect =[self.view convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    int d =rect.origin.y -64+5;
    //
    UIView * bgview =[UIView new];
    bgview.backgroundColor=[UIColor whiteColor];
    bgview.frame=CGRectMake(0, d, ScreenWidth, 150);
    [_tableView addSubview:bgview];
    
    UILabel *nameLabel =[UILabel new];
    nameLabel.text=@"提现金额";
    nameLabel.font=[UIFont systemFontOfSize:14];
    nameLabel.alpha=.6;
    [bgview sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(bgview,15)
    .topSpaceToView(bgview,15)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:120];
//¥
    UILabel *price =[UILabel new];
    price.text=@"¥";
    price.font=[UIFont systemFontOfSize:25];
    [bgview sd_addSubviews:@[price]];
    price.sd_layout
    .leftSpaceToView(bgview,15)
    .topSpaceToView(nameLabel,20)
    .widthIs(20)
    .heightIs(20);
    
    //price
    UITextField * priceText =[UITextField new];
    priceText.placeholder=@"请输入提现金额";
    priceText.font=[UIFont systemFontOfSize:16];
    priceText.keyboardType=UIKeyboardTypeNumberPad;
    [bgview sd_addSubviews:@[priceText]];
    priceText.sd_layout
    .leftSpaceToView(price,15)
    .rightSpaceToView(bgview,20)
    .centerYEqualToView(price)
    .heightIs(30);
    //底部价格
    UILabel * botmLabel =[UILabel new];
    botmLabel.text=[NSString stringWithFormat:@"可用提取财富%@",priceText.text];
    botmLabel.font=[UIFont systemFontOfSize:15];
    botmLabel.alpha=.6;
    [bgview sd_addSubviews:@[botmLabel]];
    botmLabel.sd_layout
    .centerXEqualToView(bgview)
    .heightIs(20)
    .bottomSpaceToView(bgview,10);
    [botmLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];

}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
