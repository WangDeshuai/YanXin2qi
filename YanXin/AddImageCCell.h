//
//  AddImageCCell.h
//  Technology
//
//  Created by user on 25/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddImageCCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property(nonatomic,strong) SDWeiXinPhotoContainerView * picContainerView;//到时候换成演艺圈的那种
@property(nonatomic,copy)NSString * strUrl;
@end
