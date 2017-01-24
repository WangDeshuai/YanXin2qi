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
@property(nonatomic,strong) UITextField * priceText;//提现金额
@property(nonatomic,strong)UILabel * priceLable;//当前积分
@end

@implementation KeJiSuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray=@[@"支付宝账号:",@"支付宝姓名:"];
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
   // [bgView sd_addSubviews:@[caiFuBtn]];
    caiFuBtn.sd_layout
    .rightSpaceToView(bgView,15)
    .centerYEqualToView(nameLabel)
    .widthIs(66)
    .heightIs(15);
    
    //price
     _priceLable =[UILabel new];
    _priceLable.text=@"1114.05";
    _priceLable.font=[UIFont systemFontOfSize:50 weight:.01];
    _priceLable.textColor=JXColor(75, 157, 249, 1);
    _priceLable.textAlignment=1;
    [bgView sd_addSubviews:@[_priceLable]];
    _priceLable.sd_layout
    .centerYEqualToView(bgView)
    .centerXEqualToView(bgView)
    .heightIs(40);
    [_priceLable setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    //查询积分
    [Engine ChaXunShengYuJiFensuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            _priceLable.text=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]]];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    return headView;
}


-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64+50, ScreenWidth, ScreenHight-64-50) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableHeaderView=[self CraetTabelViewHead];
     self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.tableFooterView=[UIView new];
    _tableView.rowHeight=50;
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
        UITextField * textfield =[[UITextField alloc]init];
        textfield.tag=2;
        [cell sd_addSubviews:@[textfield]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UILabel * namelabel =[cell viewWithTag:1];
    namelabel.alpha=.7;
    namelabel.font=[UIFont systemFontOfSize:15];
    namelabel.text=_dataArray[indexPath.row];
    namelabel.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:220];
    
    UITextField * textfield =[cell viewWithTag:2];
    textfield.font=[UIFont systemFontOfSize:15];
    textfield.placeholder=@"未填写";
    textfield.sd_layout
    .leftSpaceToView(namelabel,10)
    .rightSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .heightIs(40);
    return cell;
}

-(void)CreatView{
    
    UITableViewCell * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CGRect rect =[self.view convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    int d =rect.origin.y -64+5;
    //
    UIView * bgview =[UIView new];
    bgview.backgroundColor=[UIColor whiteColor];
    bgview.frame=CGRectMake(0, d, ScreenWidth, 250);
    [_tableView addSubview:bgview];
    
    UILabel *nameLabel =[UILabel new];
    nameLabel.text=@"提现积分";
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
    _priceText =[UITextField new];
    _priceText.placeholder=@"请输入提现积分";
    _priceText.font=[UIFont systemFontOfSize:16];
    _priceText.keyboardType=UIKeyboardTypeNumberPad;
    [bgview sd_addSubviews:@[_priceText]];
    _priceText.sd_layout
    .leftSpaceToView(price,15)
    .rightSpaceToView(bgview,20)
    .centerYEqualToView(price)
    .heightIs(30);
    //底部价格
    UILabel * botmLabel =[UILabel new];
    botmLabel.font=[UIFont systemFontOfSize:15];
    botmLabel.alpha=.6;
    [bgview sd_addSubviews:@[botmLabel]];
    botmLabel.sd_layout
    .centerXEqualToView(bgview)
    .heightIs(20)
    .topSpaceToView(_priceText,20);
    [botmLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    //查询积分
    [Engine ChaXunShengYuJiFensuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
             botmLabel.text=[NSString stringWithFormat:@"可用提取财富%@",[dic objectForKey:@"content"]];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    
    
    
    UIButton *tiXianBtn =[UIButton buttonWithType: UIButtonTypeCustom];
    tiXianBtn.sd_cornerRadius=@(5);
    tiXianBtn.backgroundColor=DAO_COLOR;
    tiXianBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [tiXianBtn setTitle:@"立即提现" forState:0];
    [tiXianBtn addTarget:self action:@selector(tixianButton) forControlEvents:UIControlEventTouchUpInside];
    [tiXianBtn setTitleColor:[UIColor whiteColor] forState:0];
    [bgview setupAutoHeightWithBottomView:tiXianBtn bottomMargin:10];
    [bgview sd_addSubviews:@[tiXianBtn]];
    tiXianBtn.sd_layout
    .topSpaceToView(botmLabel,20)
    .leftSpaceToView(bgview,30)
    .rightSpaceToView(bgview,30)
    .heightIs(45);

}
#pragma mark --提现按钮
-(void)tixianButton{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSLog(@"输出日期%@",DateTime);
    if ([DateTime isEqualToString:@"5"] || [DateTime isEqualToString:@"15"] ||[DateTime isEqualToString:@"25"]) {
        //支付宝账号
        UITableViewCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        //支付宝姓名
        UITableViewCell * cell2 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        //提现金额_priceText
        
        UITextField * text1 =[cell1 viewWithTag:2];
        UITextField * text2 =[cell2 viewWithTag:2];
        
        
        
        [Engine tixianMoneyPrice:[ToolClass isString:[NSString stringWithFormat:@"%@",_priceText.text]] ZhiFuBaoPay:[ToolClass isString:[NSString stringWithFormat:@"%@",text1.text]] ZhiFuBaoName:[ToolClass isString:[NSString stringWithFormat:@"%@",text2.text]] success:^(NSDictionary *dic)
         {
             [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
             NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
             if ([code isEqualToString:@"1"]) {
                 _priceLable.text=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]]];
                 UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"提现成功，请等待客服人员与您联系" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"好" style:0 handler:nil];
                 [actionView addAction:action2];
                 [self presentViewController:actionView animated:YES completion:nil];

             }else
             {
                 [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
             }
         } error:^(NSError *error) {
             
         }];
    }
    else{
        UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请于每月5日 15日 25日申请提现" preferredStyle:UIAlertControllerStyleAlert];
     
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"好" style:0 handler:nil];
        [actionView addAction:action2];
        [self presentViewController:actionView animated:YES completion:nil];

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

@end
