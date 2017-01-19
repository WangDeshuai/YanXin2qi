//
//  AddImageCCell.m
//  Technology
//
//  Created by user on 25/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import "AddImageCCell.h"

@implementation AddImageCCell


-(void)awakeFromNib{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:imageView];
    self.imageView = imageView;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        self.imageView = imageView;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _picContainerView=[SDWeiXinPhotoContainerView new];
        [self addSubview:_picContainerView];
        _picContainerView.sd_layout
        .leftSpaceToView(self,0)
        .topSpaceToView(self,0);
    }
    return self;
}
-(void)setStrUrl:(NSString *)strUrl{
    _strUrl=strUrl;
     _picContainerView.picPathStringsArray=@[strUrl];
    
}

@end
