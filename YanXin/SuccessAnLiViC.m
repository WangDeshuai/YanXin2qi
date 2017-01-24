//
//  SuccessAnLiViC.m
//  YanXin
//
//  Created by Macx on 17/1/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SuccessAnLiViC.h"
#import "QTCollectionReusableView.h"
#import "AddImageCCell.h"
#import "PhotoViewController.h"
#import "PhotoYuLanView.h"//点击放大
static NSString *headerViewIdentifier = @"hederview";
@interface SuccessAnLiViC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property (nonatomic, strong) NSArray *photoArray;

@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)NSMutableArray * vivtoArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation SuccessAnLiViC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor=[UIColor yellowColor];
    _vivtoArray=[NSMutableArray new];
    _imageArray=[NSMutableArray new];
    _dataArray=[NSMutableArray new];
    [self CreatCollectionView];
    [self getWangLuoQingQiu];
    [self getWangLuoQingQiuVidoPage];
    
}
#pragma mark --获取网络请求
//图片
-(void)getWangLuoQingQiu{
    //_accountPhone
    [Engine ChanKanYanShangAnLiAccount:_accountPhone Type:@"1" Page:@"1" PageNum:@"6" success:^(NSDictionary *dic) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in contentArr) {
                NSString * imageStr =[dicc objectForKey:@"case_url"];
                [_imageArray addObject:imageStr];
            }
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
         [_collectionView reloadData];
    } error:^(NSError *error) {
        
    }];
}
//视频
-(void)getWangLuoQingQiuVidoPage{
    
    [Engine ChanKanYanShangAnLiAccount:_accountPhone Type:@"2" Page:@"1" PageNum:@"6" success:^(NSDictionary *dic) {
        
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            for (NSDictionary * dicc in contentArr) {
                NSString * imageStr =[ToolClass isString:[NSString stringWithFormat:@"%@",[dicc objectForKey:@"cover_picture"]]];
                [_vivtoArray addObject:imageStr];
            }
            [_collectionView reloadData];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        
    } error:^(NSError *error) {
        
    }];
}


#pragma mark --创建瀑布流
-(void)CreatCollectionView{
    UICollectionViewFlowLayout * flowLawyou =[UICollectionViewFlowLayout new];
    int d =(ScreenWidth-(10*4))/3;
    //item大小
    flowLawyou.itemSize = CGSizeMake(d, d);
    //行间距
    flowLawyou.minimumLineSpacing=5;//行间距
    flowLawyou.minimumInteritemSpacing=10;//列间距
    flowLawyou.sectionInset = UIEdgeInsetsMake(10, 10, 20, 10);
    flowLawyou.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 44); //设置collectionView头视图的大小
    //集合 表（视图）继承与 UIScrollView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+216+30, ScreenWidth, ScreenHight-64-216) collectionViewLayout:flowLawyou];
    _collectionView.pagingEnabled = NO;
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    //默认是黑色的，需要设置才能显示
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[AddImageCCell class] forCellWithReuseIdentifier:@"cell"];
    //注册头视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section==0) {
        return _imageArray.count;
    }else{
        return _vivtoArray.count;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddImageCCell * cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    if (indexPath.section==0) {
       [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@""]];
       // cell.strUrl=_imageArray[indexPath.row];
        //cell.picContainerView.picPathStringsArray=_imageArray;
    }else{
        cell.picContainerView.hidden=YES;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_vivtoArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@""]];
    }
    
    return cell;
    
}
#pragma mark --点击放大
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        //图片
        /*
         tagg==1说明，数组中存的是url
         tagg==2说明，数组中存的是image,
         */
        PhotoYuLanView * vc =[[PhotoYuLanView alloc]initWithFangDa:_imageArray NSindex:indexPath.row Tagg:1];
        __weak __typeof(vc)weakSelf = vc;
        vc.dissBlock=^(){
            [weakSelf dissmiss];
        };
        [vc show];
    }else{
        //视频
        //视频
        NSURL *movieUrl = [NSURL URLWithString:_vivtoArray[indexPath.row]];
        [[UIApplication sharedApplication] openURL:movieUrl];
    }
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
        //头视图添加view
        [header addSubview:[self addContentIndex:indexPath]];
        return header;
    }
    
    return nil;
}

-(UIView*)addContentIndex:(NSIndexPath*)indexpath
{
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, ScreenWidth, 44);
    bgView.backgroundColor=[UIColor whiteColor];
    
    UIImageView * imageView =[UIImageView new];
    //181 158
    [bgView sd_addSubviews:@[imageView]];
    imageView.sd_layout
    .centerYEqualToView(bgView)
    .leftSpaceToView(bgView,15)
    .widthIs(16)
    .heightIs(13);
    
    
    UILabel * nameLabel =[UILabel new];
    nameLabel.font=[UIFont systemFontOfSize:13];
    nameLabel.alpha=.5;
    [bgView sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(imageView,10)
    .centerYEqualToView(bgView)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:220];
    
    UIButton * moreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"yanyuan_more"] forState:0];
    moreBtn.tag=indexpath.section;
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView sd_addSubviews:@[moreBtn]];
    
    moreBtn.sd_layout
    .rightSpaceToView(bgView,15)
    .centerYEqualToView(bgView)
    .widthIs(61)
    .heightIs(12);
    
    if (indexpath.section==0) {
        imageView.image=[UIImage imageNamed:@"messege_photo"];
        nameLabel.text=@"案例图片";
    }else{
        imageView.image=[UIImage imageNamed:@"messege_shipin"];
        nameLabel.text=@"案例视频";
    }
    

    
    return bgView;
}
#pragma mark --查看更多
-(void)moreBtnClick:(UIButton*)btn{
    PhotoViewController * vc =[PhotoViewController new];
    vc.numTag=2;//2代表是从演商公司进入
    vc.phoneNum=_accountPhone;
    vc.tagg=btn.tag+1;//1相册，2视频
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
