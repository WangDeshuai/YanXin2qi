//
//  CommentsViewController.m
//  YanXin
//
//  Created by Macx on 16/8/8.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentModel.h"
#import "CommentTableViewCell.h"

@interface CommentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * dataArr;
@end

@implementation CommentsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohang];
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArr=[[NSMutableArray alloc]init];
   
    NSLog(@"数组的个数%lu",_dataArray.count);
    [self CreatTableView];
     [self dataArrayData];
}
#pragma mark -- 数据解析
-(void)dataArrayData{
    if (_dataArray.count==0) {
        NSLog(@"数组没有个数");
        return;
    }
    
    for (NSString * sting in _dataArray) {
        NSData * jsonData =[sting dataUsingEncoding:NSUTF8StringEncoding];
         NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        CommentModel * model =[[CommentModel alloc]initWithDic:dic];
        [_dataArr addObject:model];
    }
    [_tableView reloadData];
}

-(void)CreatTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64)];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:_tableView];
    }
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.model=_dataArr[indexPath.row];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return [_tableView cellHeightForIndexPath:indexPath model:_dataArr[indexPath.row] keyPath:@"model" cellClass:[CommentTableViewCell class] contentViewWidth:[self  cellContentViewWith]];
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
-(void)daohang{
    //左按钮
    self.title=@"消息";
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
