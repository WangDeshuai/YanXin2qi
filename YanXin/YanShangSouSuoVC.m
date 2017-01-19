//
//  YanShangSouSuoVC.m
//  YanXin
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YanShangSouSuoVC.h"
#import "ShuJuDataModel.h"
#import "YanShangModel.h"
#import "XiangXiViewController.h"
#import "ChangDier.h"
@interface YanShangSouSuoVC ()<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate>
{
    UITableView * _tableView;
    NSInteger  _selectedScope;
    UISearchDisplayController * disPlayController;
    YanShangModel * model;
}



@property(nonatomic,retain)NSMutableArray * dataArray;
@property(nonatomic,retain)NSMutableArray * modelArray;
@property(nonatomic,retain)NSMutableArray * typeArray;
@property(nonatomic,retain)NSMutableArray * resultsArray;
@property(nonatomic,retain)UISearchBar * searchBar;

@end

@implementation YanShangSouSuoVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 64)];
    UIButton * backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    UILabel * titleLable =[[UILabel alloc]initWithFrame:CGRectMake(KUAN/2-50, 27, 100, 30)];
    titleLable.text=@"搜索";
    titleLable.textAlignment=1;
    titleLable.textColor=[UIColor whiteColor];
    [view addSubview:titleLable];
    view.backgroundColor=[UIColor colorWithRed:37/255.0 green:180/255.0 blue:237/255.0 alpha:1];
    [self.view addSubview:view];
    
    
    _dataArray =[[NSMutableArray alloc]init];
    _modelArray =[[NSMutableArray alloc]init];
    _typeArray =[[NSMutableArray alloc]init];
    _resultsArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self jiexiShuju];
    
    // UISearchBar 搜索框
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, KUAN, self.view.frame.size.height-64-44)];
    _tableView.tag = 10086;
    _tableView.delegate =self;
    _tableView.dataSource  =self;
    [self.view addSubview:_tableView];
    
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, KUAN, 44)];
    // 设置搜索范围的标题
    _searchBar.scopeButtonTitles = @[@"按首字符搜索",@"按包含搜索"];
    _searchBar.placeholder = @"请输入您想要搜索的内容";
    // 用来显示搜索结果的
    
    disPlayController = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    disPlayController.delegate =self;
    
    // 设置searchResultsDelegate,为了显示搜索结果
    disPlayController.searchResultsDataSource = self;
    disPlayController.searchResultsDelegate = self;
    
    [self.view addSubview:_searchBar];
    
    
}


-(void)jiexiShuju
{
    [ShuJuDataModel huoquSencondType:@"0" yeShu:@"0" success:^(NSDictionary *dic) {
        NSMutableArray * contenArr =[dic objectForKey:@"content"];
        for (NSDictionary * dicc in contenArr) {
            NSString * title = [dicc objectForKey:@"name"];
            NSString * type =[dicc objectForKey:@"usertype"];
            [_typeArray addObject:type];
            [_dataArray addObject:title];
           
            model=[[YanShangModel alloc]initWithDic:dicc];
            [_modelArray addObject:model];
            
        }
        [_tableView reloadData];
        
    } error:^(NSError *error) {
        
    }];
}
// 切换搜索范围时调用
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // 记录选择的是那种搜索方式
    _selectedScope = searchOption;
    // 切换搜索方式,需要重新搜索一遍
    // _searchBar.text 获取搜索框内容
    [self searchDisplayController:controller shouldReloadTableForSearchString:_searchBar.text];
    return YES;
}
// 搜索内容改变时,调用的方法
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // 搜索之前需要上次搜索结果数据清空
    [_resultsArray removeAllObjects];
    // NSLog(@"%@",searchString);
    // 判断
    if (_selectedScope == 0) {
        // 按照首字符搜索
        for (NSString * string in _dataArray) {
            
            // 按首字符搜索
            // 判断字符串是否以XX开头的
            // Prefix前缀
            // 是以searchString为前缀的,返回YES,否则返回NO
            BOOL isOK =  [string hasPrefix:searchString];
            // 说明从数组中取出的string是以搜索的字符串searchString开头的
            // 符合条件,加到结果数组中
            if (isOK == YES) {
                
                [_resultsArray addObject:string];
            }
            
            // NSLog(@"%@",_resultsArray);
        }
    }
    // 按照包含搜索
    if (_selectedScope == 1) {
        // 从数据源中搜索
        for (NSString * string in _dataArray)
        {
            // 判断searchString在数据源string中是否存在
            // NSRange 范围
            NSRange range = [string rangeOfString:searchString];
            // 不等于没找到
            if (range.location != NSNotFound)
            {
                // 把条件成立的字符串添加到数组中
                [_resultsArray addObject:string];
            }
        }
    }
    
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 10086) {
        return 0;// _dataArray.count;
    }else
    {
        return _resultsArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    if (tableView.tag == 10086) {
        // cell.textLabel.text = _dataArray[indexPath.row];
    }else
    {
        cell.textLabel.text = _resultsArray[indexPath.row];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (int i = 0 ; i<_dataArray.count; i++)
    {
        //随便取出一个名字
          NSString * name = _dataArray[i];
       //如果取出来的和搜索出来的名字一样的话
        if ([name isEqualToString:_resultsArray[indexPath.row]])
        {   //就能得到这个名字的位置（到底搜索出来的是第几个）
          //  NSLog(@"这是第几个元素%d",i);
            //根据位置再取出type，看看是不是5（演出场地）
            NSString * type=  _typeArray[i];
            NSString * tpeStr =[NSString stringWithFormat:@"%@",type];
            //如果是5的话，就进入演出场地的界面，不是的话就进入其他界面
            if ([tpeStr isEqualToString:@"5"]) {
              //  NSLog(@"演出场地界面");
                ChangDier * cvc =[[ChangDier alloc]init];
                cvc.model=_modelArray[i];
                [self.navigationController pushViewController:cvc animated:YES];
            }
            else
            {
                XiangXiViewController * xvc=[[XiangXiViewController alloc]init];
                xvc.model=_modelArray[i];
                xvc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:xvc animated:YES];
            }
            
        }
    }
    
    
    /*
     DidSelectVC * did = [[DidSelectVC alloc]init];
     for (int i = 0 ; i<_dataArray.count; i++) {
     NSString * name = _dataArray[i];
     if ([name isEqualToString:_resultsArray[indexPath.row]]) {
     NSLog(@"这是第几个元素%d",i);
     FirstModel * md =_modelArray[i];
     did.model=md;
     [self.navigationController pushViewController:did animated:YES];
     }
     
     }
     
     
     
     
     
     */
}
-(void)backClink
{
    [self.navigationController popViewControllerAnimated:YES];
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
