//
//  XiangCeCollectionViewCell.m
//  YanXin
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XiangCeCollectionViewCell.h"

@implementation XiangCeCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label=[UILabel new];
        _label.frame=CGRectMake(0, 140, 171, 30);
       // [self addSubview:_label];
        self.image1=[UIImageView new];
        self.image1.frame=CGRectMake(0, 0,121, 121);
        [self addSubview:self.image1];
        
        
    }
    return self;
}

@end
