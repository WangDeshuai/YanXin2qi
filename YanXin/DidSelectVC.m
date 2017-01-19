//
//  DidSelectVC.m
//  YanXin
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DidSelectVC.h"
@interface DidSelectVC ()

@property(nonatomic,retain) NSMutableArray * daraArray;
@property(nonatomic,retain) UIScrollView * bgScroller;
@end

@implementation DidSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"演出公告";
    self.view.backgroundColor=[UIColor whiteColor];

    _bgScroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    [self.view addSubview:_bgScroller];
    
    UILabel * titleLabel =[UILabel new];
    titleLabel.text=_model.titleLabel;
    titleLabel.textAlignment=1;
    titleLabel.font=[UIFont systemFontOfSize:19];

    UILabel * timeLabel = [UILabel new];
    timeLabel.text=[NSString stringWithFormat:@"发布时间:  %@",_model.nowTime];
    timeLabel.textColor=[UIColor grayColor];
    timeLabel.alpha=.9;
    timeLabel.font=[UIFont systemFontOfSize:15];

    UIImageView * imageview =[UIImageView new];
    [imageview sd_setImageWithURL:[NSURL URLWithString:_model.imageview] placeholderImage:[UIImage imageNamed:@"主题背景"]];
    imageview.image= [self compressImageWith:imageview.image width:imageview.image.size.width height:imageview.image.size.height];
    
  
    
    
    UILabel * pubTimeLabel =[UILabel new];
    pubTimeLabel.text=@"演出时间:";
    UILabel *pubTimeLabel1=[UILabel new];
    pubTimeLabel1.text=_model.fabuTime;
    [self textFoundColor:pubTimeLabel];

    
    
    
    
    UILabel * addressLabel =[UILabel new];
    addressLabel.text=@"演出地点:";
     UILabel * addressLabel1 =[UILabel new];
     addressLabel1.text=_model.didianLabel;
     [self textFoundColor:addressLabel];
    NSLog(@"演出地点%@",_model.didianLabel);
    
    UILabel * xiangXiLable =[UILabel new];
    xiangXiLable.text=@"详细地点:";
    [self textFoundColor:xiangXiLable];
   
    UILabel * xiangXiLable1 =[UILabel new];
    xiangXiLable1.text=_model.xiangXi;
    
    
    UILabel * yaoqiuLabel =[UILabel new];
    yaoqiuLabel.text=@"演出要求:";
    UILabel *yaoqiu1 =[UILabel new];
    yaoqiu1.text=_model.neirongLabel;
    [self textFoundColor:yaoqiuLabel];
    
    
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=@"联 系 人:";
    UILabel * nameLabel1 =[UILabel new];
    nameLabel1.text=_model.nameLabel;
    [self textFoundColor:nameLabel];
    
    
    UILabel * phoneLabel =[UILabel new];
    phoneLabel.text=@"联系方式:";
    UIButton * phoneLabel1 =[UIButton new];
    [phoneLabel1 setTitle:_model.phoneLabel forState:0];
    [phoneLabel1 setTitleColor:[UIColor blackColor] forState:0];
//    phoneLabel1.text=_model.phoneLabel;
     [self textFoundColor:phoneLabel];
    
    [_bgScroller sd_addSubviews:@[titleLabel,timeLabel,imageview,pubTimeLabel,addressLabel,addressLabel1,pubTimeLabel1,yaoqiuLabel,nameLabel,nameLabel1,phoneLabel,yaoqiu1,phoneLabel1,xiangXiLable,xiangXiLable1]];
    
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
     self.navigationItem.leftBarButtonItem=leftBtn;
    
    pubTimeLabel1.font=[UIFont systemFontOfSize:15];
     addressLabel1.font=[UIFont systemFontOfSize:15];
     yaoqiu1.font=[UIFont systemFontOfSize:15];
     nameLabel1.font=[UIFont systemFontOfSize:15];
    phoneLabel1.titleLabel.font=[UIFont systemFontOfSize:15];
     xiangXiLable1.font=[UIFont systemFontOfSize:15];
  
    titleLabel.sd_layout
    .topSpaceToView(_bgScroller,10)
    .leftSpaceToView(_bgScroller,30)
    .rightSpaceToView(_bgScroller,30)
    .autoHeightRatio(0);
    
    timeLabel.sd_layout
    .leftSpaceToView(_bgScroller,10)
    .rightSpaceToView(_bgScroller,10)
    .topSpaceToView(titleLabel,10)
    .autoHeightRatio(0);
    
    imageview.sd_layout
    .leftSpaceToView(_bgScroller,0)
    .rightSpaceToView(_bgScroller,0)
    .topSpaceToView(timeLabel,15)
    .heightIs(KUAN*imageview.image.size.height/imageview.image.size.width);
    

    
    
    phoneLabel1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    phoneLabel1.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [phoneLabel1 addTarget:self action:@selector(phoneCell) forControlEvents:UIControlEventTouchUpInside];
    
    pubTimeLabel.sd_layout
    .topSpaceToView(imageview,15)
    .leftEqualToView(timeLabel)
    .autoWhiteRatio(0)
    .autoHeightRatio(0);
    
    pubTimeLabel1.sd_layout
    .topSpaceToView(pubTimeLabel,5)
    .leftEqualToView(pubTimeLabel)
    .autoHeightRatio(0);
    [pubTimeLabel1 setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    
    addressLabel.sd_layout
    .topSpaceToView(pubTimeLabel1,5)
    .leftEqualToView(timeLabel)
    .autoWhiteRatio(0)
    .autoHeightRatio(0);
    
  
    
    
    
    addressLabel1.sd_layout
    .topSpaceToView(addressLabel,5)
    .leftEqualToView(addressLabel)
    .autoHeightRatio(0);
    [addressLabel1 setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    xiangXiLable.sd_layout
    .topSpaceToView(addressLabel1,5)
    .leftEqualToView(addressLabel)
    .autoWhiteRatio(0)
    .autoHeightRatio(0);
    
    
    xiangXiLable1.sd_layout
    .topSpaceToView(xiangXiLable,5)
    .leftEqualToView(xiangXiLable)
    .autoHeightRatio(0);
    [xiangXiLable1 setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    
    
    
    
    
    
    
    
    
    
    
    yaoqiuLabel.sd_layout
    .topSpaceToView(xiangXiLable1,5)
    .leftEqualToView(timeLabel)
    .autoWhiteRatio(0)
    .autoHeightRatio(0);
  
    yaoqiu1.sd_layout
    .topSpaceToView(yaoqiuLabel,5)
    .leftEqualToView(yaoqiuLabel)
    .autoHeightRatio(0);
    [yaoqiu1 setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    nameLabel.sd_layout
    .topSpaceToView(yaoqiu1,5)
    .leftEqualToView(timeLabel)
    .autoWhiteRatio(0)
    .autoHeightRatio(0);
    
    nameLabel1.sd_layout
    .topSpaceToView(nameLabel,5)
    .leftEqualToView(nameLabel)
    .autoHeightRatio(0);
    [nameLabel1 setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    phoneLabel.sd_layout
    .topSpaceToView(nameLabel1,5)
    .leftEqualToView(timeLabel)
    .rightEqualToView(timeLabel)
    .autoHeightRatio(0);
    
    phoneLabel1.sd_layout
    .topSpaceToView(phoneLabel,5)
    .leftEqualToView(phoneLabel)
    .rightSpaceToView(_bgScroller,10)
    .heightIs(20);
//    .autoHeightRatio(0);
    //[phoneLabel1.titleLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    phoneLabel1.didFinishAutoLayoutBlock=^(CGRect aaa){
     // NSLog(@">>>%f",aaa.origin.y);
        
       _bgScroller.contentSize=CGSizeMake(KUAN, aaa.origin.y+aaa.size.height+50);
        
        
    };
    
    }

-(void)textFoundColor:(UILabel * )label{
    label.textColor=[UIColor colorWithRed:37/255.0 green:181/255.0 blue:239/255.0 alpha:1];
    label.font=[UIFont systemFontOfSize:18];
    
}
-(void)phoneCell{
    [ShuJuModel tellPhone:_model.phoneLabel];
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


-(void)jieXi
{
//    [ShuJuModel huoquFirstPage:page Tiao:type success:^(NSDictionary *dic) {
//        
//        NSMutableArray * conArr= [dic objectForKey:@"content"];
//        for (NSDictionary * dicd in conArr) {
//            firstModel =[[FirstModel alloc]initWithDic:dicd];
//            [_dataArray addObject:firstModel];
//        }
//       
//        
//    } error:^(NSError *error) {
//        
//    }];

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
