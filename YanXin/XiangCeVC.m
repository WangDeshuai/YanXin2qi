//
//  XiangCeVC.m
//  YanXin
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XiangCeVC.h"
#import "XiangCeCollectionViewCell.h"
#import "TCLPhotoBrowserViewController.h"
#import "ImgScrollView.h"
#import "TapImageView.h"
@interface XiangCeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,TapImageViewDelegate,ImgScrollViewDelegate>
{
    UICollectionView * collectionview;
    UITableView *myTable;
    UIScrollView *myScrollView;
    NSInteger currentIndex;
    
    UIView *markView;
    UIView *scrollPanel;
    UITableViewCell *tapCell;
    
    ImgScrollView *lastImgScrollView;
}
@property(nonatomic,retain)NSMutableArray * srcStringArray;
@end

@implementation XiangCeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lianjieClink:) name:@"pianyi" object:nil];
   // NSLog(@"%@>>>>",_shui);
    _srcStringArray =[NSMutableArray new];
    
    
   
    

    
    scrollPanel = [[UIView alloc] initWithFrame:self.view.bounds];
    scrollPanel.backgroundColor = [UIColor clearColor];
    scrollPanel.alpha = 0;
    [_DeLiSelf.view addSubview:scrollPanel];
    
    markView = [[UIView alloc] initWithFrame:scrollPanel.bounds];
    markView.backgroundColor = [UIColor blackColor];
    markView.alpha = 0.0;
    [scrollPanel addSubview:markView];
    
//    _yelerView.backgroundColor=[UIColor yellowColor];
//    _yelerView.frame=CGRectMake(0, 0, KUAN, GAO);
//    [];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollPanel addSubview:myScrollView];
    myScrollView.pagingEnabled = YES;
    myScrollView.delegate = self;
    CGSize contentSize = myScrollView.contentSize;
    contentSize.height = self.view.bounds.size.height;
    contentSize.width = KUAN * 3;
    myScrollView.contentSize = contentSize;
    
//    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KUAN, GAO-280)];
//    myTable.dataSource = self;
//    myTable.delegate = self;
//    [self.view addSubview:myTable];

    
   [self yeshu:@"1" tiaoshu:@"6"];
    
    UICollectionViewFlowLayout * flowLayout =[UICollectionViewFlowLayout new];
    flowLayout.itemSize=CGSizeMake(121, 121);
    flowLayout.minimumInteritemSpacing=6;
    flowLayout.minimumLineSpacing=6;
    //上左下右
    flowLayout.sectionInset=UIEdgeInsetsMake(6, 0, 0, 0);
   collectionview =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-280) collectionViewLayout:flowLayout];
    collectionview.backgroundColor=[UIColor whiteColor];
    collectionview.pagingEnabled = YES;
    collectionview.delegate = self;
    collectionview.dataSource = self;
    [collectionview registerClass:[XiangCeCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:collectionview];
    
     collectionview.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

-(void)yeshu:(NSString*)page tiaoshu:(NSString*)tiaoshu
{
    
    [ShuJuModel xiangceGetXiangCe:_shui YeShu:page Tiaoshu:tiaoshu success:^(NSDictionary *dic) {
        NSMutableArray * contentArr =[dic objectForKey:@"content"];

        
        for (NSDictionary * dicc in contentArr) {
            NSString * imageurl= [dicc objectForKey:@"imgurl"];
            [_srcStringArray addObject:imageurl];
            
        }
        [collectionview reloadData];
        
    } error:^(NSError *error) {
        
    }];

}
-(void)footerRefresh
{
    [collectionview.footer endRefreshing];
    static int a = 1;
    a=a+1;
    NSString * conde =[NSString stringWithFormat:@"%d",a];
    [self yeshu:conde tiaoshu:@"3"];
}
//#pragma mark - custom method
//- (void) addSubImgView
//{
//    for (UIView *tmpView in myScrollView.subviews)
//    {
//        [tmpView removeFromSuperview];
//    }
//    
//    for (int i = 0; i < 3; i ++)
//    {
//        if (i == currentIndex)
//        {
//            continue;
//        }
//        
//        TapImageView *tmpView = (TapImageView *)[tapCell viewWithTag:10 + i];
//        
//        //转换后的rect
//        CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:_DeLiSelf.view];
//        
//        ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){i*myScrollView.bounds.size.width,0,myScrollView.bounds.size}];
//        [tmpImgScrollView setContentWithFrame:convertRect];
//        [tmpImgScrollView setImage:tmpView.image];
//        [myScrollView addSubview:tmpImgScrollView];
//        tmpImgScrollView.i_delegate = self;
//        
//        [tmpImgScrollView setAnimationRect];
//    }
//}
//
//- (void) setOriginFrame:(ImgScrollView *) sender
//{
//    [UIView animateWithDuration:0.4 animations:^{
//        [sender setAnimationRect];
//        markView.alpha = 1.0;
//    }];
//}

//#pragma mark - custom delegate
//- (void) tappedWithObject:(id)sender
//{
//    [self.view bringSubviewToFront:scrollPanel];
//    scrollPanel.alpha = 1.0;
//    
//    TapImageView *tmpView = sender;
//    currentIndex = tmpView.tag - 10;
//    
//    tapCell = tmpView.identifier;
//    
//    //转换后的rect
//    CGRect convertRect = [[tmpView superview] convertRect:tmpView.frame toView:_DeLiSelf.view];
//    
//    CGPoint contentOffset = myScrollView.contentOffset;
//    contentOffset.x = currentIndex*KUAN;
//    myScrollView.contentOffset = contentOffset;
//    
//    //添加
//    [self addSubImgView];
//    
//    ImgScrollView *tmpImgScrollView = [[ImgScrollView alloc] initWithFrame:(CGRect){contentOffset,myScrollView.bounds.size}];
//    [tmpImgScrollView setContentWithFrame:convertRect];
//    [tmpImgScrollView setImage:tmpView.image];
//    [myScrollView addSubview:tmpImgScrollView];
//    tmpImgScrollView.i_delegate = self;
//    
//    [self performSelector:@selector(setOriginFrame:) withObject:tmpImgScrollView afterDelay:0.1];
//}

//- (void) tapImageViewTappedWithObject:(id)sender
//{
//    
//    ImgScrollView *tmpImgView = sender;
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        markView.alpha = 0;
//        [tmpImgView rechangeInitRdct];
//    } completion:^(BOOL finished) {
//        scrollPanel.alpha = 0;
//    }];
//    
//}
//#pragma mark - scroll delegate
//- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGFloat pageWidth = scrollView.frame.size.width;
//    currentIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _srcStringArray.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"UICollectionViewCell";
    XiangCeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    [cell.image1 sd_setImageWithURL:[NSURL URLWithString:_srcStringArray[indexPath.row]]];
    UIImage *im =[self compressImageWith:cell.image1.image width:121 height:121];
    cell.image1.image=im;
    cell.image1.clipsToBounds=YES;
    cell.image1.contentMode=UIViewContentModeScaleAspectFill;
   // cell.backgroundColor=[UIColor greenColor];
//
     return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TCLPhotoBrowserViewController *photo = [[TCLPhotoBrowserViewController alloc]init];
    photo.photos=_srcStringArray;
    photo.currentPage=indexPath.row;
    [self presentViewController:photo animated:YES completion:nil];
}

-(void)scanBigPicture:(UIButton *)button
{
   
    
//    _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    _backgroundView.backgroundColor = [UIColor blackColor];
//    
//    UIScrollView * scroll = [[UIScrollView alloc]init];
//    scroll.frame = CGRectMake(0, (self.view.frame.size.height-250-64)/2, self.view.frame.size.width, 250);
//    //scroll.frame = _backgroundView.frame;
//    
//    for (int i = 0; i < self.imagesUrlArray.count; i++) {
//        UIImageView *imageView = [[UIImageView alloc] init];
//        
//        imageView.frame = CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width,250);
//        
//        //  NSLog(@"********%@",self.imagesUrlArray[i]);
//        [imageView sd_setImageWithURL:self.imagesUrlArray[i]];
//        
//        [scroll addSubview:imageView];
//        
//    }
//    scroll.contentSize = CGSizeMake(self.view.frame.size.width*self.imagesUrlArray.count-1, 250);
//    scroll.pagingEnabled = YES;
//    scroll.backgroundColor = [UIColor blackColor];
//    scroll.contentOffset = CGPointMake(self.view.frame.size.width*button.tag, 0);
//    [_backgroundView addSubview:scroll];
//    
//    
//    
//    [self.view addSubview:_backgroundView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_backgroundView removeFromSuperview];
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
//

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
    
//    NSDictionary *dic = notification.userInfo;
//    NSString *value = [dic objectForKey:@"key2"];
//    if ([value isEqualToString:@"-20"]) {
//       collectionview.scrollEnabled =NO;
//        
//    }else {
//        collectionview.scrollEnabled =YES;
//    }
}
@end
