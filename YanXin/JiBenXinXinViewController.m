//
//  JiBenXinXinViewController.m
//  YanXin
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JiBenXinXinViewController.h"
#import "JIBenXInXICell.h"
#import "MessageModel.h"
#import "WhoYanYuanModel.h"

@interface JiBenXinXinViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * array1;
   // WhoYanYuanModel * model;
}
@property(nonatomic,retain)NSMutableArray * dataArr;
@property(nonatomic,retain)NSMutableArray * dataModelArr;
@property(nonatomic,retain)NSMutableArray * messageArr;
@property(nonatomic,retain)NSMutableArray * jianJieArr;
@property(nonatomic,retain)NSMutableArray * jingLiArr;
@end

@implementation JiBenXinXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lianjieClink:) name:@"pianyi" object:nil];
//    
    
    _dataArr=[NSMutableArray new];
    _dataModelArr=[NSMutableArray new];
    _messageArr=[NSMutableArray new];
    _jianJieArr=[NSMutableArray new];
    _jingLiArr=[NSMutableArray new];
    
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-60) style:UITableViewStylePlain];
     [self jiexi];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
     array1=[[NSMutableArray alloc]initWithObjects:@"姓   名:",@"性   别:",@"标   签:",@"手机号:",@"地   区:", nil];
   

}
-(void)jiexi
{
   // NSLog(@"手机号>>>%@",_shui);
    [ShuJuModel whoWithYanyuan:_shui success:^(NSDictionary *dic) {
       //NSLog(@"查询演员%@",dic);
       NSDictionary * contentDic =[dic objectForKey:@"content"];
       WhoYanYuanModel* model=[[WhoYanYuanModel alloc]initWithDic:contentDic];
        [_jianJieArr addObject:model.myjianjie];
        [_jingLiArr addObject:model.myjingli];
        [_messageArr addObject:model.name];
        [_messageArr addObject:model.sex];
        [_messageArr addObject:model.biaoqian];
        [_messageArr addObject:model.phoneNumber];
        [_messageArr addObject:model.diqu];
        
         [_dataModelArr addObject:_messageArr];
         [_dataModelArr addObject:_jianJieArr];
         [_dataModelArr addObject:_jingLiArr];
        [_tableView reloadData];
        
    } error:^(NSError *error) {
       
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

   return _dataModelArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSArray * arr =_dataModelArr[section];

    return arr.count;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JIBenXInXICell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[JIBenXInXICell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSArray * arr =_dataModelArr[indexPath.section];
    if (indexPath.section==0) {
        cell.leftLabel.hidden=NO;
        cell.nameLabel.hidden=NO;
        cell.jianJieLabel.hidden=YES;
        cell.leftLabel.text=array1[indexPath.row];
        cell.nameLabel.text=arr[indexPath.row];
    }else if(indexPath.section==1){
        cell.leftLabel.hidden=YES;
        cell.nameLabel.hidden=YES;
        cell.text=arr[0];
    }else{
        cell.leftLabel.hidden=YES;
        cell.nameLabel.hidden=YES;
        cell.text=arr[0];
    }
      return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else{
         return 30;
    }
  
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray * arr =@[@"",@"个人简介",@"演艺经历"];
    UIView * bgview =[UIView new];
    bgview.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    
    UIImageView * imageview =[UIImageView new];
    UILabel * label =[UILabel new];
    label.textColor=[UIColor blackColor];
    label.text=arr[section];
    imageview.image=[UIImage imageNamed:@"竖线"];
    
    [bgview sd_addSubviews:@[imageview,label]];
    
    imageview.sd_layout
    .leftSpaceToView(bgview,10)
    .widthIs(1)
    .heightIs(20)
    .topSpaceToView(bgview,5);
    label.sd_layout
    .leftSpaceToView(imageview,15)
    .topSpaceToView(bgview,5)
    .heightIs(20);
    [label setSingleLineAutoResizeWithMaxWidth:375];
    
    
    return bgview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {
        return 44;
    }else{
        
         NSArray * arr =_dataModelArr[indexPath.section];
        return [_tableView cellHeightForIndexPath:indexPath model:arr[0] keyPath:@"text" cellClass:[JIBenXInXICell class] contentViewWidth:[self  cellContentViewWith]];
    }
    //return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    WhoYanYuanModel
   
   //
    if (indexPath.section==0)
    {
          NSArray * arr =_dataModelArr[indexPath.section];
        if (indexPath.row==3)
        {
            NSString * num=arr[indexPath.row];
            [ShuJuModel tellPhone:num];
        }
    }
    
    
    
  
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
-(void)chakan:(UIButton*)btn
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"温馨提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"username"]){
        NSLog(@"请登录");
        
        alertController.message=@"您还没有登录，请登录后查看";
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
    
    NSString* huiyuan=  [[NSUserDefaults standardUserDefaults]objectForKey:@"huiyuanma"];
   // NSLog(@"%@",huiyuan);
    if ([huiyuan isEqualToString:@"0"] || huiyuan==nil) {
        NSLog(@"不是会员");
        
        //UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
      //  UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您还不是会员，请开通会员在查看" preferredStyle:UIAlertControllerStyleAlert];
        alertController.message=@"您还不是演员，请升级演员在查看";
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"升级演员" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            ZhiFuViewController * vc =[ZhiFuViewController new];
//            [self.navigationController pushViewController:vc animated:YES];
            
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }else{
         btn.selected=!btn.selected;
        if (btn.selected==NO) {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"chak"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"chak" forKey:@"chak"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

    }
    }
       [_tableView reloadData];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chak"];
    [[NSUserDefaults standardUserDefaults]synchronize];
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
- (void)lianjieClink:(NSNotification *)notification {
    
    // _tableView.scrollEnabled = NO;
    NSDictionary *dic = notification.userInfo;
    NSString *value = [dic objectForKey:@"key2"];
    if ([value isEqualToString:@"-20"]) {
        _tableView.scrollEnabled =NO;
        
    }else {
        _tableView.scrollEnabled =YES;
    }
}
@end
