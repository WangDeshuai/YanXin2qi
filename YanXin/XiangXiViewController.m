//
//  XiangXiViewController.m
//  YanXin
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XiangXiViewController.h"
#import "ThiredVC.h"
#import "UMSocial.h"
@interface XiangXiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView * _bigScroller;
    UILabel * neiRongLab;
    CGFloat maxContentLabelHeight;
    UIImageView * imageview;
}
@end

@implementation XiangXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    self.title=_model.titleName;
    _bigScroller =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    _bigScroller.contentSize=CGSizeMake(0, GAO+200);
    [self.view addSubview:_bigScroller];
   
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
    UIButton*right=[UIButton buttonWithType:UIButtonTypeCustom];
    //right.backgroundColor=[UIColor redColor];
    right.frame=CGRectMake(KUAN-35,27, 17, 17);
    [right setBackgroundImage:[UIImage imageNamed:@"Share"] forState:0];
    [right addTarget:self action:@selector(rightbtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightbtn =[[UIBarButtonItem alloc]initWithCustomView:right];
    self.navigationItem.rightBarButtonItem=rightbtn;

    
    
    
    imageview =[[UIImageView alloc]init];//WithFrame:CGRectMake(0, 0, KUAN, 222)];
    [imageview  sd_setImageWithURL:[NSURL URLWithString:_model.imageName] placeholderImage:[UIImage imageNamed:@"主题背景"]];
    
    imageview.image=[self compressImageWith:imageview.image width:imageview.image.size.width height:imageview.image.size.height];
    imageview.frame=CGRectMake(0, 0, KUAN, KUAN*imageview.image.size.height/imageview.image.size.width);
    CGFloat aa =KUAN*imageview.image.size.height/imageview.image.size.width;
    [_bigScroller addSubview:imageview];
   // NSLog(@"Y坐标是%f",imageview.image.size.height);
    UILabel * titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(10,aa , 150, 30)];
    titleLabel.text=@"公司简介";
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.textColor=[UIColor colorWithRed:121/255.0 green:145/255.0 blue:255/255.0 alpha:1];
    [_bigScroller addSubview:titleLabel];
    
    neiRongLab =[[UILabel alloc]init];
    neiRongLab.text=_model.jianJie;
    neiRongLab.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1];
    
    neiRongLab.font=[UIFont systemFontOfSize:15];
    
    UILabel * titleLabel2 =[[UILabel alloc]init];
    titleLabel2.font=[UIFont systemFontOfSize:18];
    titleLabel2.text=@"成功案例";
    titleLabel2.textColor=[UIColor colorWithRed:121/255.0 green:145/255.0 blue:255/255.0 alpha:1];
    
    UILabel * titleLabel3 =[[UILabel alloc]init];
    titleLabel3.font=[UIFont systemFontOfSize:18];
    titleLabel3.text=@"联系方式";
    titleLabel3.textColor=[UIColor colorWithRed:121/255.0 green:145/255.0 blue:255/255.0 alpha:1];
     UILabel * lianxi1 =[[UILabel alloc]init];
     UIButton * lianxi2 =[[UIButton alloc]init];
     UILabel * lianxi3 =[[UILabel alloc]init];
    lianxi1.font=[UIFont systemFontOfSize:15];
    lianxi2.titleLabel.font=[UIFont systemFontOfSize:15];
    lianxi3.font=[UIFont systemFontOfSize:15];
    lianxi1.text= [NSString stringWithFormat:@"联系人: %@",_model.name];
    NSString * btnStr =[NSString stringWithFormat:@"联系电话: %@",_model.phone];
    //lianxi2.text=[NSString stringWithFormat:@"联系电话: %@",_model.phone];
    [lianxi2 setTitle:btnStr forState:0];
    lianxi3.text=[NSString stringWithFormat:@"公司地址: %@",_model.dizhi];
    
    lianxi1.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1];
   // lianxi2.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1];
    [lianxi2 setTitleColor:[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1] forState:0];
    
    lianxi3.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1];
    
    
    
    UITableView * tableview =[[UITableView alloc]init];
    tableview.dataSource=self;
    tableview.delegate=self;
    [_bigScroller sd_addSubviews:@[neiRongLab,titleLabel2,tableview,titleLabel3,lianxi1,lianxi2,lianxi3]];
    
    
    neiRongLab.sd_layout
    .topSpaceToView(titleLabel,0)
    .leftSpaceToView(_bigScroller,10)
    .rightSpaceToView(_bigScroller,5)
    .autoHeightRatio(0);
    
    titleLabel2.sd_layout
    .topSpaceToView(neiRongLab,10)
    .leftEqualToView(titleLabel)
    .widthRatioToView(titleLabel,1)
    .heightRatioToView(titleLabel,1);
    
    tableview.sd_layout
    .topSpaceToView(titleLabel2,0)
    .leftSpaceToView(_bigScroller,0)
    .rightSpaceToView(_bigScroller,0)
    .heightIs(30*_model.anliArr.count);
    
    titleLabel3.sd_layout
    .topSpaceToView(tableview,20)
    .leftEqualToView(titleLabel)
    .widthRatioToView(titleLabel,1)
    .heightRatioToView(titleLabel,1);
    
    lianxi1.sd_layout
    .topSpaceToView(titleLabel3,0)
    .leftSpaceToView(_bigScroller,10)
    .rightSpaceToView(_bigScroller,10)
    .heightIs(30);
    lianxi2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    lianxi2.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [lianxi2 addTarget:self action:@selector(tapp) forControlEvents:UIControlEventTouchUpInside];
    lianxi2.sd_layout
    .topSpaceToView(lianxi1,0)
    .leftSpaceToView(_bigScroller,10)
    .rightSpaceToView(_bigScroller,10)
    .heightIs(30);
    
    lianxi3.sd_layout
    .topSpaceToView(lianxi2,0)
    .leftSpaceToView(_bigScroller,10)
    .rightSpaceToView(_bigScroller,10)
    .heightIs(30);
    
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)tapp{
   // NSLog(@"电话%@",_model.phone);
    [ShuJuModel tellPhone:_model.phone];
    
}
-(void)rightbtn:(UIButton*)btn
{
   
   // UIImageView * image1 =[UIImageView new];
    
    
    
    
    [UMSocialData defaultData].extConfig.title = _model.titleName;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://itunes.apple.com/cn/app/yan-xin-zhong-guo-yan-chu-wang/id1112389632?mt=8";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57200c43e0f55afeba001afb"
                                      shareText:_model.jianJie
                                     shareImage:imageview.image
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:nil];
  
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"57200c43e0f55afeba001afb"
//                                      shareText:_model.titleName
//                                     shareImage:[UIImage imageNamed:@"Icon"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil]
//                                       delegate:self];

    
    
    
    
}
-(void)backClink

{
    [self.navigationController popViewControllerAnimated:YES];
}
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _model.anliArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    NSDictionary * dic=  _model.anliArr[indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"title"];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.textColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1];
    cell.imageView.image=[UIImage imageNamed:@"成功案例button"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSDictionary * dic=  _model.anliArr[indexPath.row];
    ThiredVC * vc =[[ThiredVC alloc]init];
    vc.hidesBottomBarWhenPushed=YES;
    vc.urlStr=[dic objectForKey:@"linkurl"];
   [self.navigationController pushViewController:vc animated:YES];
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
