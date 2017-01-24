//
//  DFImageGroupViewController.m
//  Technology
//
//  Created by user on 26/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import "DFImageGroupViewController.h"
#import "DFImageGroupCCell.h"
//#import "Tool.h"
#import "DFImageManager.h"
#import "DFPreviewController.h"


#define COLOR_BG_NAV [UIColor colorWithRed:234.0/255 green:84.0/255 blue:4.0/255 alpha:1.0]    //#ea5404


@interface DFImageGroupViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, DFPhotoBrowserDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) UIButton *previewButton;
@property (weak, nonatomic) UIButton *sendButton;
@property (weak, nonatomic) UILabel *numberLabel;

@property (nonatomic, strong) NSArray *assetArray;


@end

@implementation DFImageGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // title
    //    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.title = @"相册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)]];

    //    [self initToolView];
    [self initToolBar];
    [self initCollectionView];
    
    
    self.assetArray = self.albumModel.models;
    [self checkPhotoSelected];
    
}

//查看已选择照片
-(void)checkPhotoSelected{
    DFThemeNav *themNav = (DFThemeNav *)self.navigationController;
    for (DFAssetModel *selectedModel in themNav.selectedAssetArray) {
        for (DFAssetModel *model in self.assetArray) {
            if ([[[DFImageManager manager] getAssetIdentifier:selectedModel.asset] isEqualToString:[[DFImageManager manager] getAssetIdentifier:model.asset]]) {
                model.isSelected = YES;
                break;
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)initToolBar {
    // 预览按钮
//    UIButton *previewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 30)];
//    [previewButton.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
//    [previewButton setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
//    [previewButton setTitle:@"预览" forState:UIControlStateNormal];
//    [previewButton setTitleColor:COLOR_BG_NAV forState:UIControlStateNormal];
//    [previewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
//    [previewButton addTarget:self action:@selector(previewAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *priviewItem = [[UIBarButtonItem alloc] initWithCustomView:previewButton];
//    self.previewButton = previewButton;
//    [self.previewButton setEnabled:NO];
    
    // 确定按钮
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 30)];
    [sendButton.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [sendButton setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [sendButton setTitle:@"确定" forState:UIControlStateNormal];
    [sendButton setTitleColor:COLOR_BG_NAV forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.sendButton = sendButton;
    //    [self.sendButton setEnabled:NO];
    
    // 数字
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [numberLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [numberLabel setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    [numberLabel setTextColor:[UIColor whiteColor]];
    [numberLabel setTextAlignment:NSTextAlignmentCenter];
    [numberLabel setBackgroundColor:COLOR_BG_NAV];
    UIBarButtonItem *numberItem = [[UIBarButtonItem alloc] initWithCustomView:numberLabel];
    self.numberLabel = numberLabel;
    [self.numberLabel setHidden:YES];
    
    CALayer *numberLayer = [self.numberLabel layer];
    [numberLayer setMasksToBounds:YES];
    [numberLayer setCornerRadius:10];
    
    UIBarButtonItem *flexibleItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:  UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.toolbarItems = [NSArray arrayWithObjects: flexibleItem, numberItem, sendItem, nil];
}



- (void)initCollectionView {
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = [[UIScreen mainScreen]bounds].size.width / 4;
    [collectionViewLayout setItemSize:CGSizeMake(width-4, width-4)];
    [collectionViewLayout setMinimumInteritemSpacing:0];
    [collectionViewLayout setMinimumLineSpacing:4];
    [collectionViewLayout setSectionInset:UIEdgeInsetsMake(2, 2, 2, 2)];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.navigationController.toolbar.frame)-20) collectionViewLayout:collectionViewLayout];
    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    [collectionView setAllowsMultipleSelection:YES];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 注册Cell nib
    [self.collectionView registerNib:[UINib nibWithNibName:@"DFImageGroupCCell" bundle:nil] forCellWithReuseIdentifier:@"DFImageGroupCCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
    [self refreshButtonState];
    [self.navigationController setToolbarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)scrollTableViewBottom {
//    NSUInteger rowCount = self.assetsArray.count;
//    if (rowCount > 0) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowCount - 1 inSection:0];
//        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
//    }
}

- (void)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)previewWithIndex:(NSUInteger)index {
    DFPreviewController *vc = [[DFPreviewController alloc] init];
    vc.delegate = self;
    vc.photos = self.assetArray;
    vc.currentIndex = index;
    [self.navigationController pushViewController:vc animated:YES];
}


//确定
- (void)sendAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.delegate didSelectAssets:self.selectedArray isOriginal:NO];
         DFThemeNav *themNav = (DFThemeNav *)weakSelf.navigationController;
        if (themNav.selectedAssetArray.count>3) {
            
        }else{
           [themNav.assetDelegate didSelectAssets:themNav.selectedAssetArray]; 
        }
       
        if (themNav.selectedAssetArray.count>3) {
            [LCProgressHUD showMessage:@"最大个数是3个"];
            return ;
        }else{
             [self dismissViewControllerAnimated:YES completion:nil];
        }
        NSLog(@"输出数组的个数%lu",themNav.selectedAssetArray.count);
    });
   
}

#pragma mark collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // cell
    DFImageGroupCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DFImageGroupCCell" forIndexPath:indexPath];
    // asset
    DFAssetModel *model = self.assetArray[indexPath.row];
    __weak typeof(self) weakSelf = self;
//    __weak typeof(cell) weakCell = cell;
    [cell setModel:model];
    
    cell.didSelectedPhoto = ^(BOOL isSelected){
        DFThemeNav *themNav = (DFThemeNav *)weakSelf.navigationController;
        [themNav selectPhoto:isSelected withModel:model];
    };
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    [self previewWithIndex:indexPath.row];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (DFAssetModel *)photoBrowser:(DFPreviewController *)browser placeholderImageForIndex:(NSInteger)index{
    return self.assetArray[index];
}

#pragma mark private func


- (void)refreshButtonState {
//    NSInteger count = [[self selectedArray] count];
//    [self.numberLabel setText:[NSString stringWithFormat:@"%ld", (long)count]];
//    if (count <= 0) {
//        [self.numberLabel setHidden:YES];
//        //        [self.sendButton setEnabled:NO];
//        [self.previewButton setEnabled:NO];
//    } else {
//        [self.numberLabel setHidden:NO];
//        //        [self.sendButton setEnabled:YES];
//        [self.previewButton setEnabled:YES];
//    }
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
