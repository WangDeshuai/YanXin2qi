//
//  DFThemeNav.m
//  Technology
//
//  Created by user on 27/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import "DFThemeNav.h"

#import "DFImageGroupViewController.h"
#import "DFAlbumController.h"

@interface DFThemeNav ()
@property(nonatomic, assign)BOOL pushPhotoPickeVC;

@end

@implementation DFThemeNav

//相册的初始化方法
- (instancetype)initWithDelegate:(id<DFAssetDelegate>)delegate pushPhotoPickerVC:(BOOL)pushPhotoPickerVC{
    DFAlbumController *vc = [[DFAlbumController alloc] init];
    
    self = [super initWithRootViewController:vc];
    if (self) {
        self.assetDelegate = delegate;
        _pushPhotoPickeVC = pushPhotoPickerVC;
        
        if ([[DFImageManager manager] checkAlAuth]) {
            [self toPhotoPickerVc];
        }else{
            NSLog(@"没有权限");
        }
        
    }
    
    return self;
    
    
}

-(NSMutableArray *)selectedAssetArray{
    if (!_selectedAssetArray) {
        _selectedAssetArray = [NSMutableArray array];
    }
    return _selectedAssetArray;
}


-(void)toPhotoPickerVc{
    if (_pushPhotoPickeVC) {
        DFImageGroupViewController *vc = [[DFImageGroupViewController alloc] init];
        [[DFImageManager manager] getCameraRollAlbums:YES allowPickingImage:YES completion:^(DFAlbumModel *model) {
            vc.albumModel = model;
            [self pushViewController:vc animated:YES];
        }];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.navigationBar setTranslucent:NO];
    //设置导航栏颜色
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255 green:251.0/255 blue:247.0/255 alpha:1.0]];
    //设置导航栏上按钮颜色
    [self.navigationBar setTintColor:[UIColor colorWithRed:234.0/255 green:84.0/255 blue:4.0/255 alpha:1.0]];
    
    //设置导航标题颜色
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor colorWithRed:234.0/255 green:84.0/255 blue:4.0/255 alpha:1.0]  forKey:NSForegroundColorAttributeName]];
    
    UIApplication *application = [UIApplication sharedApplication];
    if (application.statusBarStyle == UIStatusBarStyleLightContent) {   //如果状态栏为白色，给状态栏地步添加一个黑色的View
        UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.view.frame), 20)];
        statusBarView.backgroundColor=[UIColor blackColor];
        [self.navigationBar addSubview:statusBarView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}


//相册选中功能
-(void)selectPhoto:(BOOL)isSelected withModel:(DFAssetModel *)model{
    NSArray *selectedModels = [NSArray arrayWithArray:self.selectedAssetArray];
    if (isSelected) { //选中
        [self.selectedAssetArray addObject:model];
    }else{
        for (DFAssetModel *assetModel in selectedModels) {
            if ([[[DFImageManager manager] getAssetIdentifier:assetModel.asset] isEqualToString:[[DFImageManager manager] getAssetIdentifier:model.asset]]) {
                [self.selectedAssetArray removeObject:assetModel];
                break;
            }
        }
    }
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
