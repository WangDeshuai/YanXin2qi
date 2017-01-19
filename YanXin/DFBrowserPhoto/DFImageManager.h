//
//  DFImageManager.h
//  Technology
//
//  Created by user on 26/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DFAssetModel.h"

@interface DFImageManager : NSObject
+(instancetype)manager;

//检查权限
- (BOOL)checkAlAuth;

//获取相机里的相片
- (void)getCameraRollAlbums:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(DFAlbumModel *model))completion;

//获取所有的相片
- (void)getAllAlbums:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<DFAlbumModel *> *))completion;

/// Get Assets 获得照片数组
- (void)getAssetsFromFetchResult:(id)result completion:(void (^)(NSArray<DFAssetModel *> *))completion;

// 获取封面图
- (void)getPostImageWithAlbumModel:(DFAlbumModel *)model completion:(void (^)(UIImage *photo))completion;

//获取小图
- (void)getThumbnailPhotoWithAsset:(id)asset newCompletion:(void (^)(UIImage *photo))completion;
//获取原图
- (void)getOriginalPhotoWithAsset:(id)asset newCompletion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;

//用于判断图片是否选中
- (NSString *)getAssetIdentifier:(id)asset;


@end
