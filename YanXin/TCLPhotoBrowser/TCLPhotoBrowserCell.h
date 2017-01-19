//
//  TCLPhotoBrowserCell.h
//  TCLPhotoBrowser
//
//  Created by TCL on 16/1/13.
//  Copyright © 2016年 alitan2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define IPHINE_HEIGHT [UIScreen mainScreen].bounds.size.height
typedef void (^tapClickBlock) ();
@interface TCLPhotoBrowserCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *photoView;
@property(nonatomic,copy)tapClickBlock tapFinishBlock;
-(void)setPhotoViewImage:(id)photoObj withTapBlock:(tapClickBlock)tapClick;
@end
