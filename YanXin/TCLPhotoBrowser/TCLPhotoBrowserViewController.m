//
//  TCLPhotoBrowserViewController.m
//  TCLPhotoBrowser
//
//  Created by TCL on 16/1/13.
//  Copyright © 2016年 alitan2014. All rights reserved.
//

#import "TCLPhotoBrowserViewController.h"
#import "TCLPhotoBrowserCell.h"
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define IPHINE_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface TCLPhotoBrowserViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@end

@implementation TCLPhotoBrowserViewController
{
    BOOL _isFrist;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
}
/**
 *  创建UI
 */
-(void)initUI{
    /* FlowLayout */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing=0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    
    /**
     collectionView
     */
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH+20, IPHINE_HEIGHT) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled=YES;
    self.collectionView.showsVerticalScrollIndicator=YES;
    self.collectionView.bounces=YES;
    [self.collectionView registerClass:[TCLPhotoBrowserCell class] forCellWithReuseIdentifier:@"cell"];
    /**
     *  当点击最后一张图片进入时 修正frame的位置
     */
    CGRect frame = self.collectionView.frame;
    if (self.currentPage==self.photos.count-1) {
        frame.origin.x=-20;
        self.collectionView.frame=frame;
    }else{
        frame.origin.x=0;
        self.collectionView.frame=frame;
    }
    self.collectionView.contentOffset=CGPointMake((IPHONE_WIDTH+20)*self.currentPage, 0);
    [self.view addSubview:self.collectionView];
    
    /**
     pageLabel 第几张图片
     */
    self.pageLabel = [[UILabel alloc]initWithFrame:CGRectMake((IPHONE_WIDTH-100)/2, IPHINE_HEIGHT-64, 100, 30)];
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.currentPage+1,self.photos.count];
    self.pageLabel.textColor = [UIColor whiteColor];
    self.pageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.pageLabel];
}
/**
返回 有几张图片 item
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}
/**
 显示每张图片
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TCLPhotoBrowserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell =[[TCLPhotoBrowserCell alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHINE_HEIGHT)];
    }
    if (!_isFrist) {
        [cell setPhotoViewImage:[self.photos objectAtIndex:self.currentPage] withTapBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        _isFrist =YES;
    }
    [cell setPhotoViewImage:[self.photos objectAtIndex:indexPath.row] withTapBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    return cell;
}
/**
 将要停止滑动
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/IPHONE_WIDTH;
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",page+1,self.photos.count];
}
/**
 滑动停止后 改变PageLabel  text 内容
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/IPHONE_WIDTH;
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",page+1,self.photos.count];
    CGRect frame = self.collectionView.frame;
    if (page==self.photos.count-1) {
        frame.origin.x=-20;
        [UIView animateWithDuration:0.01 animations:^{
            self.collectionView.frame=frame;
        }];
        
    }else{
        frame.origin.x=0;
        [UIView animateWithDuration:0.01 animations:^{
            self.collectionView.frame=frame;
        }];
        
    }
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
