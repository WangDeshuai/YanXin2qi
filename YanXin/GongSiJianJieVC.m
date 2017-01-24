//
//  GongSiJianJieVC.m
//  YanXin
//
//  Created by Macx on 17/1/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "GongSiJianJieVC.h"

@interface GongSiJianJieVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * nameArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * imageArray;
@end

@implementation GongSiJianJieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self CreatArray];
    [self CreatTabelView];
   
}
#pragma mark --创建数组
-(void)CreatArray{
    _nameArray=[[NSMutableArray alloc]initWithObjects:@"联  系  人:",@"联系电话:",@"联系地址:", nil];
    _dataArray=[NSMutableArray new];
    _imageArray=[[NSMutableArray alloc]initWithObjects:@"ycgg_person",@"ycgg_phone",@"ycgg_place", nil];
    
}

#pragma mark --解析数据公司简介
-(void)gongSiJianJieData{
    [Engine chaKanXiangQingMessageAccount:_accountPhone success:^(NSDictionary *dic) {
        
    } error:^(NSError *error) {
        
    }];
    
}



#pragma mark --表头文字
-(UIView*)CreatHeadView{
    UIView * headView =[UIView new];
    headView.backgroundColor=[UIColor whiteColor];
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64+216)
    .heightIs(150);
    
    UITextView * nameLabel =[UITextView new];
    nameLabel.text=@"安安安国看了噶看了咖喱公司了懒死了可能两个呢靓女懒啊安安安国看了噶看了咖喱公司了懒死了可能两个呢靓女懒啊安安安国看了噶看了咖喱公司了懒死了可能两个呢靓女懒啊";
    nameLabel.editable=NO;
    nameLabel.backgroundColor=[UIColor whiteColor];
    nameLabel.font=[UIFont systemFontOfSize:14];
    nameLabel.alpha=.6;
    [headView sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(headView,25)
    .rightSpaceToView(headView,25)
    .topSpaceToView(headView,40)
    .bottomSpaceToView(headView,10);
    
    
    //headView.backgroundColor=[UIColor redColor];
    UIView * linView =[UIView new];
    linView.backgroundColor=COLOR;
    [headView sd_addSubviews:@[linView]];
    linView.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(nameLabel,2)
    .heightIs(1);
    
    
    
    [Engine chaKanXiangQingMessageAccount:_accountPhone success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * dicc =[dic objectForKey:@"content"];
            nameLabel.text=[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"introduction"]]];
            [_dataArray addObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"linkman"]]]];
            [_dataArray addObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"connecttel"]]]];
            [_dataArray addObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"address"]]]];
            [_tableView reloadData];
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64+216, ScreenWidth, ScreenHight-64-216) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.tableHeaderView=[self CreatHeadView];
    _tableView.tableFooterView=[UIView new];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
        //图标
        UIImageView * imageview =[UIImageView new];
        imageview.tag=10;
        [cell sd_addSubviews:@[imageview]];
        //联系人
        UILabel * namelabel =[UILabel new];
        namelabel.tag=20;
        [cell sd_addSubviews:@[namelabel]];
        
        //数据data
        UILabel * shuJuLabel =[UILabel new];
        shuJuLabel.tag=30;
        [cell sd_addSubviews:@[shuJuLabel]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIImageView * imageview =[cell viewWithTag:10];
    imageview.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .widthIs(14)
    .heightIs(14);
    imageview.image=[UIImage imageNamed:_imageArray[indexPath.row]];
    
    UILabel * namelabel =[cell viewWithTag:20];
    namelabel.font=[UIFont systemFontOfSize:15];
    namelabel.alpha=.7;
    namelabel.text=_nameArray[indexPath.row];
    namelabel.sd_layout
    .leftSpaceToView(imageview,15)
    .centerYEqualToView(cell)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:220];
    
    UILabel * shuJuLabel =[cell viewWithTag:30];
    shuJuLabel.font=[UIFont systemFontOfSize:15];
    shuJuLabel.alpha=.7;
    shuJuLabel.text=_dataArray[indexPath.row];
    shuJuLabel.sd_layout
    .leftSpaceToView(namelabel,20)
    .centerYEqualToView(cell)
    .heightIs(20);
    [shuJuLabel setSingleLineAutoResizeWithMaxWidth:220];
    
    if (indexPath.row==1) {
        shuJuLabel.textColor=DAO_COLOR;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (indexPath.row==1) {
      NSString * str= [NSString stringWithFormat:@"拨打%@",_dataArray[1]];
        UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"是" style:0 handler:^(UIAlertAction * _Nonnull action) {
             [ToolClass tellPhone:str];
        }];
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"否" style:0 handler:nil];
        [actionView addAction:action2];
        [actionView addAction:action1];
        [self presentViewController:actionView animated:YES completion:nil];
    }
   

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
