//
//  PhotoYuLanView.m
//  YanXin
//
//  Created by Macx on 17/1/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PhotoYuLanView.h"
@interface PhotoYuLanView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * bgScrollview;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong) UIImageView * imageview;
@end
@implementation PhotoYuLanView
//数组中存的是url
-(id)initWithFangDa:(NSMutableArray*)photoArr{
    self=[super init];
    if (self) {
        _dataArray=photoArr;
        
        [self CreatScrollview];
        [self CreatImage];
    }
    
    return self;
}
#pragma mark --创建滚动试图
-(void)CreatScrollview{
    _bgScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight)];
    _bgScrollview.backgroundColor=[UIColor redColor];
    _bgScrollview.contentSize=CGSizeMake(ScreenWidth*_dataArray.count, ScreenHight);
    _bgScrollview.pagingEnabled = YES;
    _bgScrollview.delegate=self;
    [self addSubview:_bgScrollview];
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapp)];
    [_bgScrollview addGestureRecognizer:tap];
}
-(void)tapp{
    self.dissBlock();
}

#pragma mark --创建图片
-(void)CreatImage{
    
        NSString * url =_dataArray[0];
        
        _imageview =[UIImageView new];
        [_bgScrollview sd_addSubviews:@[_imageview]];
        [_imageview sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _imageview.sd_layout
            .leftSpaceToView(_bgScrollview,0)
            .centerYEqualToView(_bgScrollview)
            .widthIs(ScreenWidth)
            .heightIs(image.size.height *ScreenWidth/image.size.width);

        }];
       
   
    
    
   
}


// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
    
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
      int index = scrollView.contentOffset.x/ScreenWidth;
    NSLog(@"输出%d",index);
    //[_bgScrollview sd_addSubviews:@[_imageview]];

    [_imageview sd_setImageWithURL:[NSURL URLWithString:_dataArray[index]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _imageview.sd_layout
        .leftSpaceToView(_bgScrollview,ScreenWidth*index)
        .centerYEqualToView(_bgScrollview)
        .widthIs(ScreenWidth)
        .heightIs(image.size.height *ScreenWidth/image.size.width);
        
    }];
}
- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    //设置中心点
    self.center = window.center;
    self.bounds=CGRectMake(0, 0, ScreenWidth, ScreenHight);
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    view.tag=1000;
    [window addSubview:view];
    [window addSubview:self];
    
}
-(void)dissmiss{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView * view =[window viewWithTag:1000];
    [view removeFromSuperview];
    [self removeFromSuperview];
    
}
@end
