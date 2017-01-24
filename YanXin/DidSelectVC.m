//
//  DidSelectVC.m
//  YanXin
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DidSelectVC.h"
@interface DidSelectVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain) NSArray * daraArray;
@property(nonatomic,retain) UIScrollView * bgScroller;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * nameArray;
@property(nonatomic,strong)NSArray * imageArray;
@end

@implementation DidSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor whiteColor];
     [self daohangTiao];
    _nameArray=@[@"演出时间:",@"演出城市:",@"详细地址:",@"联  系  人:",@"联系方式:",@"详细要求:"];
    _imageArray=@[@"ycgg_time",@"ycgg_place",@"ycgg_person",@"ycgg_phone",@"ycgg_lubiao",@"ycgg_xuqiu"];
   
    _daraArray=@[_model.fabuTime,_model.didianLabel,_model.xiangXi,_model.nameLabel,_model.phoneLabel,_model.neirongLabel];
    
    
    [self  CreatTabelView];
}

#pragma mark --创建区头
-(UIView*)CreatTableViewHead{
    UIView * headView =[UIView new];
    headView.backgroundColor=[UIColor whiteColor];
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .heightIs(290);
    //标题
    UILabel * titleLabel =[UILabel new];
    titleLabel.font=[UIFont systemFontOfSize:19];
    titleLabel.alpha=.6;
    titleLabel.text=_model.titleLabel;
    [headView sd_addSubviews:@[titleLabel]];
    titleLabel.sd_layout
    .centerXEqualToView(headView)
    .topSpaceToView(headView,15)
    .heightIs(20);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    //发布时间
    UILabel * timeLabel =[UILabel new];
    timeLabel.font=[UIFont systemFontOfSize:14];
    timeLabel.alpha=.4;
    timeLabel.text=[NSString stringWithFormat:@"发布时间:  %@",_model.nowTime];
    [headView sd_addSubviews:@[timeLabel]];
    timeLabel.sd_layout
    .leftSpaceToView(headView,20)
    .topSpaceToView(titleLabel,15)
    .heightIs(20);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    //图片
    UIImageView * imageView =[UIImageView new];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_model.imageview] placeholderImage:[UIImage imageNamed:@"messege_bg"]];//181 158
    [headView sd_addSubviews:@[imageView]];
    imageView.sd_layout
    .leftSpaceToView(headView,0)
    .rightSpaceToView(headView,0)
    .topSpaceToView(timeLabel,10)
    .heightIs(200);
    
    
    
    
    return headView;
}

#pragma mark --创建表
-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.rowHeight=44;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView=[self CreatTableViewHead];
    _tableView.tableFooterView=[UIView new];
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _daraArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIImageView * imageview =[UIImageView new];
        imageview.tag=1;
        [cell sd_addSubviews:@[imageview]];
        
        UILabel * nameLabel =[UILabel new];
        nameLabel.tag=2;
        [cell sd_addSubviews:@[nameLabel]];
        
        UILabel * contentLabel =[UILabel new];
        contentLabel.tag=3;
        [cell sd_addSubviews:@[contentLabel]];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIImageView * imageview =[cell viewWithTag:1];
    UILabel * nameLabel =[cell viewWithTag:2];
    UILabel * contentLabel =[cell viewWithTag:3];
    
    imageview.image=[UIImage imageNamed:_imageArray[indexPath.row]];
    imageview.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .widthIs(14)
    .heightIs(14);
    
    nameLabel.text=_nameArray[indexPath.row];
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.6;
    nameLabel.sd_layout
    .leftSpaceToView(imageview,15)
    .centerYEqualToView(cell)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:220];
    
    contentLabel.text=_daraArray[indexPath.row];
    contentLabel.font=[UIFont systemFontOfSize:15];
    contentLabel.alpha=.8;
    contentLabel.sd_layout
    .leftSpaceToView(nameLabel,15)
    .centerYEqualToView(cell)
    .autoHeightRatio(0);
    [contentLabel setSingleLineAutoResizeWithMaxWidth:220];
   
    if (indexPath.row==4) {
        contentLabel.textColor=DAO_COLOR;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        NSLog(@"%@",_daraArray[3]);
        
        NSString * str =[NSString stringWithFormat:@"拨打%@",_daraArray[3]];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==5) {
        
        
        return [ToolClass HeightForText:_model.neirongLabel withSizeOfLabelFont:18 withWidthOfContent:220]+20;
    }else{
        return 44;
    }
}
//-(void)phoneCell{
//    [ShuJuModel tellPhone:_model.phoneLabel];
//}
//
//
//-(void)backClink
//{
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}
-(UIImage *)compressImageWith:(UIImage *)image width:(float)width height:(float)height
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //[newImage retain];
    [newImage copy];
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
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
#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=COLOR;
    self.title=@"演出公告";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    //返回按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink2) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
}
-(void)backClink2{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
