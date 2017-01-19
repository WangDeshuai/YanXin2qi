//
//  DFPreviewController.m
//  Technology
//
//  Created by user on 3/1/17.
//  Copyright © 2017年 DFF. All rights reserved.
//

#import "DFPreviewController.h"
#import "DFBrowserCCell.h"
#import "DFThemeNav.h"

@interface DFPreviewController ()<UICollectionViewDataSource, UICollectionViewDelegate, DFBrowserCCellDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *selectedBtn;   //是否选中按钮
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIView *toolView;
@property (nonatomic, assign) BOOL isHiden;   //navView和toolView隐藏

@end

@implementation DFPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initCollectionView];
    [self initNavBar];
    [self initToolBar];

}


- (void)initNavBar{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    navView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:navView];
    self.navView = navView;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 44)];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    
    UIButton *selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(navView.frame)-44, 20, 44, 44)];
    [selectedBtn setImage:[UIImage imageNamed:@"icon_dxx_b_pre.png"] forState:UIControlStateNormal];
    [selectedBtn setImage:[UIImage imageNamed:@"icon_dxx_b.png"] forState:UIControlStateSelected];
    [selectedBtn addTarget:self action:@selector(clickSelected:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:selectedBtn];
    self.selectedBtn = selectedBtn;
    
}

-(void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickSelected:(UIButton *)sender{
    sender.selected = !sender.selected;
    DFAssetModel *model = self.photos[self.currentIndex];
    model.isSelected = sender.selected;
    DFThemeNav *themNav = (DFThemeNav *)self.navigationController;
    [themNav selectPhoto:sender.selected withModel:model];
}

- (void)initToolBar {
    
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 40, self.view.bounds.size.width, 40)];
    toolView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:toolView];
    self.toolView = toolView;
    // 确定按钮
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(toolView.frame) - 50, 0, 50, 40)];
//    sendButton.backgroundColor = [UIColor whiteColor];
    [sendButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [sendButton setTitle:@"完成" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];

    [toolView addSubview:sendButton];

}

- (void)sendAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        //        [self.delegate didSelectAssets:self.selectedArray isOriginal:NO];
        DFThemeNav *themNav = (DFThemeNav *)weakSelf.navigationController;
        [themNav.assetDelegate didSelectAssets:themNav.selectedAssetArray];
    });
    [self dismissViewControllerAnimated:YES completion:nil];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)tap{
    self.isHiden = !self.isHiden;
    [self.navView setHidden:self.isHiden];
    [self.toolView setHidden:self.isHiden];
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
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(photoBrowser: placeholderImageForIndex:)]){
            [ccell setCellImageWithImage:[self.delegate photoBrowser:self placeholderImageForIndex:indexPath.row]];
            
        }
    }
    DFAssetModel *model = self.photos[indexPath.row];
    self.selectedBtn.selected = model.isSelected;
    
    return ccell;
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
