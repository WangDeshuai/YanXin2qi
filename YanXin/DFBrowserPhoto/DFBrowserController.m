//
//  DFBrowserController.m
//  Technology
//
//  Created by user on 3/1/17.
//  Copyright © 2017年 DFF. All rights reserved.
//

#import "DFBrowserController.h"
#import "DFBrowserCCell.h"

@interface DFBrowserController ()<UICollectionViewDataSource, UICollectionViewDelegate, DFBrowserCCellDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *selectedBtn;   //是否选中按钮
@property (nonatomic, strong) NSMutableArray *selectedArray;  //选中的数组

@end

@implementation DFBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initCollectionView];
    [self initNavBar];
    
}

-(CGRect)imageViewFrameWithSize:(CGSize)size{
    if (size.width == 0) {
        return CGRectZero;
    }
    CGSize viewSize = self.view.bounds.size;
    float scale = (viewSize.width/viewSize.height) > (size.width/size.height) ? (viewSize.height / size.height) : (viewSize.width / size.width);
    if (scale == 0) {
        return CGRectZero;
    }
    return CGRectMake(0, 0, size.width * scale, size.height * scale);
}

- (void)initNavBar{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navView];
    
    UIButton *selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(navView.frame)-44, 20, 44, 44)];
    [selectedBtn setImage:[UIImage imageNamed:@"icon_dxx_b_pre.png"] forState:UIControlStateNormal];
    [selectedBtn setImage:[UIImage imageNamed:@"icon_dxx_b.png"] forState:UIControlStateSelected];
    [selectedBtn addTarget:self action:@selector(clickSelected:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:selectedBtn];
    self.selectedBtn = selectedBtn;
    
}

-(void)clickSelected:(UIButton *)sender{
    sender.selected = !sender.selected;
    DFAssetModel *model = self.photos[self.currentIndex];
    model.isSelected = sender.selected;
}

- (void)initCollectionView {
    self.automaticallyAdjustsScrollViewInsets = false;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = self.view.bounds.size;
    //    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-5, [UIScreen mainScreen].bounds.size.height-5);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *tempView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    tempView.backgroundColor = [UIColor blackColor];
    tempView.dataSource = self;
    tempView.delegate = self;
    tempView.pagingEnabled = YES;
    [self.view addSubview:tempView];
    self.collectionView = tempView;
    
    [tempView registerClass:[DFBrowserCCell class] forCellWithReuseIdentifier:@"DFBrowserCCell"];
    
    [self.collectionView setContentOffset:CGPointMake(self.view.bounds.size.width * self.currentIndex, 0)];
}


-(void)tap{
    if (self.assetDelegate) {
        NSMutableArray *selectedArray = [NSMutableArray array];
       
        for (DFAssetModel *model in self.photos) {
            if (model.isSelected) {
                [selectedArray addObject:model];
            }
        }
        [self.assetDelegate didSelectAssets:selectedArray];
    }
   
        [self dismissViewControllerAnimated:YES completion:nil]; 
    
   
}

#pragma mark UICollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    self.currentIndex = index;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identerfier = @"DFBrowserCCell";
    DFBrowserCCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:identerfier forIndexPath:indexPath];
    ccell.delegate = self;
    if (self.browserDelegate) {
        if ([self.browserDelegate respondsToSelector:@selector(photoBrowser: placeholderImageForIndex:)]){
            [ccell setCellImageWithImage:[self.browserDelegate photoBrowser:nil placeholderImageForIndex:indexPath.row]];
            
        }else{
            if ([self.browserDelegate respondsToSelector:@selector(photoBrowserHighQualityImageURLForIndex:)]) {
                NSURL *url = [self.browserDelegate photoBrowserHighQualityImageURLForIndex:indexPath.row];
                [ccell setCellImageWithUrl:url];
            }else if ([self.browserDelegate respondsToSelector:@selector(photoBrowserImageURLForIndex:)]){
                NSURL *url = [self.browserDelegate photoBrowserImageURLForIndex:indexPath.row];
                [ccell setCellImageWithUrl:url];
            }
        }
    }
    DFAssetModel *model = self.photos[indexPath.row];
    self.selectedBtn.selected = model.isSelected;
    
    return ccell;
}

-(UIImageView *)getImageView{
    DFBrowserCCell *cell = (DFBrowserCCell *)[self.collectionView visibleCells].firstObject;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [cell getSourceImageView].image;
    imageView.frame = [cell getSourceImageView].frame;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    return imageView;
}

-(NSIndexPath *)getIndexPath{
    DFBrowserCCell *cell = (DFBrowserCCell *)[self.collectionView visibleCells].firstObject;
    return [self.collectionView indexPathForCell:cell];
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
