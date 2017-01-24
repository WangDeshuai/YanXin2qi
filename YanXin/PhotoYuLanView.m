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
@property(nonatomic,strong)UILabel * pageLabel;
@property (nonatomic,assign) NSInteger tagg;
@end
@implementation PhotoYuLanView
//数组中存的是url
-(id)initWithFangDa:(NSMutableArray*)photoArr  NSindex:(NSInteger)index  Tagg:(NSInteger)tagg{
    self=[super init];
    if (self) {
        _dataArray=photoArr;
        _tagg=tagg;
        [self CreatScrollview];
        [self CreatImage:index];
    }
    
    return self;
}
#pragma mark --创建滚动试图
-(void)CreatScrollview{
    _bgScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight)];
    _bgScrollview.backgroundColor=[UIColor blackColor];
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
-(void)CreatImage:(NSInteger)index{
     _imageview =[UIImageView new];
     [_bgScrollview sd_addSubviews:@[_imageview]];
    if (_tagg==1) {
        //根据url获取图片尺寸
        [_imageview sd_setImageWithURL:[NSURL URLWithString:_dataArray[index]] placeholderImage:[UIImage imageNamed:@"messege_bg"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _imageview.sd_layout
            .leftSpaceToView(_bgScrollview,ScreenWidth*index)
            .centerYEqualToView(_bgScrollview)
            .widthIs(ScreenWidth)
            .heightIs(image.size.height *ScreenWidth/image.size.width);
            _bgScrollview.contentOffset=CGPointMake(ScreenWidth*index, 0);
        }];
 
    }else{
        UIImage * image =_dataArray[index];
        _imageview.image=image;
        _imageview.sd_layout
        .leftSpaceToView(_bgScrollview,ScreenWidth*index)
        .centerYEqualToView(_bgScrollview)
        .widthIs(ScreenWidth)
        .heightIs(image.size.height *ScreenWidth/image.size.width);
        _bgScrollview.contentOffset=CGPointMake(ScreenWidth*index, 0);
    }
    
    
    
    
   //创建label
    _pageLabel=[UILabel new];
    _pageLabel.text=[NSString stringWithFormat:@"%lu/%lu",index+1,_dataArray.count];
    _pageLabel.textAlignment=1;
    _pageLabel.textColor=[UIColor whiteColor];
    _pageLabel.font=[UIFont systemFontOfSize:20];
     [self sd_addSubviews:@[_pageLabel]];
    _pageLabel.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self,40)
    .heightIs(20)
    .widthIs(300);
    
    //为image添加手势
    // 缩放手势
    //如果处理的是图片，别忘了
    [_imageview setUserInteractionEnabled:YES];
    [_imageview setMultipleTouchEnabled:YES];
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [_imageview addGestureRecognizer:pinchGestureRecognizer];
    
    
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
    
   
}


//结束减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
      int index = scrollView.contentOffset.x/ScreenWidth;
    _pageLabel.text=[NSString stringWithFormat:@"%d/%lu",index+1,_dataArray.count];
    
    if (_tagg==1) {
        //用的是URL
        [_imageview sd_setImageWithURL:[NSURL URLWithString:_dataArray[index]] placeholderImage:[UIImage imageNamed:@"messege_bg"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _imageview.sd_layout
            .leftSpaceToView(_bgScrollview,ScreenWidth*index)
            .centerYEqualToView(_bgScrollview)
            .widthIs(ScreenWidth)
            .heightIs(image.size.height *ScreenWidth/image.size.width);
            
        }];
    }else{
        UIImage * image=_dataArray[index];
        _imageview.image=image;
        _imageview.sd_layout
        .leftSpaceToView(_bgScrollview,ScreenWidth*index)
        .centerYEqualToView(_bgScrollview)
        .widthIs(ScreenWidth)
        .heightIs(image.size.height *ScreenWidth/image.size.width);
    }
    
    
    
    
}



- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    //设置中心点
    self.center = window.center;
    self.bounds=CGRectMake(0, 0, ScreenWidth, ScreenHight);
   
    [window addSubview:self];
    
}
-(void)dissmiss{
    [self removeFromSuperview];
    
}
@end
