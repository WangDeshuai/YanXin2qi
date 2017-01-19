//
//  TCLPhotoBrowserViewController.h
//  TCLPhotoBrowser
//
//  Created by TCL on 16/1/13.
//  Copyright © 2016年 alitan2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCLPhotoBrowserViewController : UIViewController
/** collectionView */
@property (nonatomic, strong)  UICollectionView *collectionView;
/** 显示第几张图片 */
@property (nonatomic, strong)  UILabel *pageLabel;
/** 图片数组 */
@property (nonatomic, strong)  NSArray *photos;
/** 当前选择第几张图片 */
@property (nonatomic, assign)  NSInteger currentPage;
@end
