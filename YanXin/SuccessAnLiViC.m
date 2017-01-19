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
#import "DFThemeNav.h"
#import "DFBrowserController.h"
#
static NSString *headerViewIdentifier = @"hederview";
@interface SuccessAnLiViC ()<UICollectionViewDelegate,UICollectionViewDataSource,DFAssetDelegate, DFPhotoBrowserDelegate, DFPresentedProtocol>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
@property (nonatomic, strong) NSArray *photoArray;
@property (nonatomic, strong) DFBrowserAnimator *borwserAnimator;

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
    self.borwserAnimator = [[DFBrowserAnimator alloc] init];
    [self CreatCollectionView];
    [self getWangLuoQingQiu];
    [self getWangLuoQingQiuVidoPage];
    
}
#pragma mark --获取网络请求
//图片
-(void)getWangLuoQingQiu{
    //_accountPhone
    [Engine ChanKanYanShangAnLiAccount:@"15032735032" Type:@"1" Page:@"1" success:^(NSDictionary *dic) {
        
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
    
    [Engine ChanKanYanShangAnLiAccount:@"15032735032" Type:@"2" Page:@"1" success:^(NSDictionary *dic) {
        
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
    cell.backgroundColor=[UIColor magentaColor];
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.6;
    [bgView sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(imageView,10)
    .centerYEqualToView(bgView)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:220];
    if (indexpath.section==0) {
        imageView.image=[UIImage imageNamed:@"messege_photo"];
        nameLabel.text=@"案例图片";
    }else{
        imageView.image=[UIImage imageNamed:@"messege_shipin"];
        nameLabel.text=@"案例视频";
    }
    
    return bgView;
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
