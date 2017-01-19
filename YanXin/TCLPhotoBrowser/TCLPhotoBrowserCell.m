//
//  TCLPhotoBrowserCell.m
//  TCLPhotoBrowser
//
//  Created by TCL on 16/1/13.
//  Copyright © 2016年 alitan2014. All rights reserved.
//

#import "TCLPhotoBrowserCell.h"
#import "UIImageView+Category.h"
@implementation TCLPhotoBrowserCell
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    self.photoView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHINE_HEIGHT)];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.photoView addGestureRecognizer:tap];
    self.photoView.userInteractionEnabled = YES;
    [self addSubview:self.photoView];
    
}
/**
 根据外部传进来的obj 给photoView赋值
 */
-(void)setPhotoViewImage:(id)photoObj withTapBlock:(tapClickBlock)tapClick{
    if ([photoObj isKindOfClass:[NSString class]]) {
        NSString *str = photoObj;
        if ([str hasPrefix:@"http"]) {
            [self.photoView setImageWithURLString:photoObj];
        }else{
            self.photoView.image =[UIImage imageNamed:photoObj];
        }
    }else if ([photoObj isKindOfClass:[UIImage class]]){
        self.photoView.image = photoObj;
    }
    if (tapClick) {
        self.tapFinishBlock = tapClick;
    }
}
/**
    点击图片之后回调。
 */
-(void)tap{
    if (self.tapFinishBlock) {
        self.tapFinishBlock();
    }
}
@end
