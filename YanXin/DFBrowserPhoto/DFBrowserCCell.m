//
//  BrowserCCell.m
//  DFPhotoBrower
//
//  Created by dongff on 16/8/18.
//  Copyright © 2016年 dongff. All rights reserved.
//

#import "DFBrowserCCell.h"
#import "UIImageView+WebCache.h"
#import "DFImageManager.h"


#define screen_scale [UIScreen mainScreen].scale

@interface DFBrowserCCell ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, weak) UIScrollView *scrollerView;
@end

@implementation DFBrowserCCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:scrollView];
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 2.0;
        scrollView.delegate = self;
        self.size = frame.size;
        [scrollView addSubview:self.imageView];
        self.scrollerView = scrollView;
        [self addGesture];
        
    }
    
    return self;
}



-(UIImageView *)imageView{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    
    return _imageView;
}


-(void)setCellImageWithImage:(DFAssetModel *)model{
    __weak typeof(self) weakSelf = self;
    [[DFImageManager manager] getThumbnailPhotoWithAsset:model.asset newCompletion:^(UIImage *photo) {
        weakSelf.imageView.image = photo;
        weakSelf.size = CGSizeMake(photo.size.width/screen_scale, photo.size.height/screen_scale);
        [weakSelf setImageViewFrame];
    }];
}

-(void)setCellImageWithUrl:(NSURL *)url{
    
    __weak typeof(self) weakSelf = self;
    [self.imageView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            weakSelf.size = CGSizeMake(image.size.width/screen_scale, image.size.height/screen_scale);
            [weakSelf setImageViewFrame];
        }
    }];
}

-(void)prepareForReuse{
    self.scrollerView.zoomScale = 1.0;
    _imageView.frame = CGRectZero;
}

-(void)setImageViewFrame{
    if (self.size.width == 0) {
        return;
    }
    
    CGSize viewSize = self.bounds.size;
    float scale = (viewSize.width/viewSize.height) > (self.size.width/self.size.height) ? (viewSize.height / self.size.height) : (viewSize.width / self.size.width);
    if (scale == 0) {
        return;
    }
    //使用MIN是防止计算中的误差使得frame.size大于屏幕
    _imageView.frame = CGRectMake(0, 0, MIN(self.size.width * scale, viewSize.width) - 2, MIN(self.size.height * scale, viewSize.height) - 2);
    _imageView.center = CGPointMake(viewSize.width/2, viewSize.height/2);

}



-(UIImageView *)getSourceImageView{
    return _imageView;
}




-(void)addGesture{
//    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
    tap.numberOfTapsRequired = 1;
    [self.scrollerView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick)];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollerView addGestureRecognizer:doubleTap];
    
    [tap requireGestureRecognizerToFail:doubleTap];
    
}

-(void)tapHandle{
    NSLog(@"单击");
    if (self.delegate) {
        [self.delegate tap];
    }
}

-(void)doubleClick{
    if (self.scrollerView.zoomScale != 1.0) {
        [self.scrollerView setZoomScale:1.0 animated:YES];
    }else{
        [self.scrollerView setZoomScale:2.0 animated:YES];
    }
    
    
}



- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
  
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = _imageView.frame;
    CGSize contentSize = scrollView.contentSize;
    
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    // center horizontally
    if (imgFrame.size.width <= boundsSize.width)
    {
        centerPoint.x = boundsSize.width/2;
    }
    
    // center vertically
    if (imgFrame.size.height <= boundsSize.height)
    {
        centerPoint.y = boundsSize.height/2;
    }
    
    _imageView.center = centerPoint;
}





@end
