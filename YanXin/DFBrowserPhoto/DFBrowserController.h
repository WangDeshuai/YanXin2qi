//
//  DFBrowserController.h
//  Technology
//
//  Created by user on 3/1/17.
//  Copyright © 2017年 DFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFAssetDelegate.h"
#import "DFBrowserAnimator.h"

@interface DFBrowserController : UIViewController<DFDismissProtocol>

@property (nonatomic, strong) NSArray *photos;                  ///< All photos  / 所有图片数组
@property (nonatomic, assign) NSInteger currentIndex;           ///< Index of the photo user click / 用户点击的图片的索引
@property (nonatomic, weak) id<DFPhotoBrowserDelegate> browserDelegate;
@property (nonatomic, weak) id<DFAssetDelegate> assetDelegate;
@end
