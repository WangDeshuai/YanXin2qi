//
//  DFAssetDelegate.h
//  Technology
//
//  Created by user on 26/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DFAssetDelegate <NSObject>

@required

- (void)didSelectAssets:(NSArray *)assets;

@end

@class DFPreviewController;
@class DFAssetModel;

@protocol DFPhotoBrowserDelegate <NSObject>

@optional

//本地图片
- (DFAssetModel *)photoBrowser:(DFPreviewController *)browser placeholderImageForIndex:(NSInteger)index;

//网络图片
- (NSURL *)photoBrowserImageURLForIndex:(NSInteger)index;

- (NSURL *)photoBrowserHighQualityImageURLForIndex:(NSInteger)index;

@end
