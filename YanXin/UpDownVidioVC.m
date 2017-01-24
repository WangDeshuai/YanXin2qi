//
//  UpDownVidioVC.m
//  YanXin
//
//  Created by Macx on 17/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UpDownVidioVC.h"

@interface UpDownVidioVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * contentArray;
@end

@implementation UpDownVidioVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray=[[NSMutableArray alloc]init];
    [_dataArray addObject:@"连接"];
    _contentArray=[NSMutableArray new];
    [self daohangTiao];
    [self CreatTabelView];
}
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.tableFooterView=[UIView new];
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * nameLab =[UILabel new];
        nameLab.tag=10;
        [cell sd_addSubviews:@[nameLab]];
        UITextField * textfield =[UITextField new];
        textfield.tag=20;
        [cell sd_addSubviews:@[textfield]];
        UIButton * addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.tag=30;
        [cell sd_addSubviews:@[addBtn]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UILabel * nameLabel =[cell viewWithTag:10];
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.8;
    nameLabel.text=_dataArray[indexPath.row];
    nameLabel.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    
    UIButton * addBtn =[cell viewWithTag:30];
    [addBtn addTarget:self action:@selector(addbtn) forControlEvents:UIControlEventTouchUpInside];
    addBtn.sd_cornerRadius=@(10);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"link_add"] forState:0];
    addBtn.sd_layout
    .rightSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .widthIs(20)
    .heightIs(20);

    
    UITextField * textfield =[cell viewWithTag:20];
    textfield.placeholder=@"例如http://...";
    textfield.font=[UIFont systemFontOfSize:15];
    textfield.sd_layout
    .leftSpaceToView(nameLabel,15)
    .centerYEqualToView(nameLabel)
    .rightSpaceToView(cell,15)
    .heightIs(20);

    return cell;
}
#pragma mark--addBtn
-(void)addbtn{
    if (_dataArray.count>=3) {
        [LCProgressHUD showMessage:@"超出最大数目"];
    }else{
        [_dataArray addObject:@"连接"];
        [_tableView reloadData];
    }
    
}
#pragma mark --区尾
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view =[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    UILabel * namelabel =[UILabel new];
    namelabel.text=@"请粘贴复制您需要的连接到这里";
    namelabel.font=[UIFont systemFontOfSize:14];
    namelabel.alpha=.4;
    [view sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(view,15)
    .topSpaceToView(view,20)
    .rightSpaceToView(view,15)
    .heightIs(20);
    
    
    UIButton * nextBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.backgroundColor=DAO_COLOR;
    nextBtn.sd_cornerRadius=@(3);
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"renzheng_bt1"] forState:0];
    [nextBtn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [view sd_addSubviews:@[nextBtn]];
    nextBtn.sd_layout
    .centerXEqualToView(view)
    .widthIs(305)
    .heightIs(40)
    .bottomSpaceToView(view,20);
    return view;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--下一步
-(void)nextBtn{
   // [self.navigationController popViewControllerAnimated:YES];
    for (int i =0; i<_dataArray.count; i++) {
        UITableViewCell * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        UITextField * textfield =[cell viewWithTag:20];
        if ([textfield.text isEqualToString:@""] ||textfield.text==nil || textfield.text.length==0) {
            [LCProgressHUD showMessage:@"视频连接不能为空"];
            return;
        }
        [_contentArray addObject:textfield.text];
    }
    if (_contentArray.count!=0) {
       self.imageArrBlock(_contentArray);
       [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"填写视频连接";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    //返回按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
}
-(void)backClink{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
