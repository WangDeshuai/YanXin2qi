//
//  DFAssetModel.h
//  Technology
//
//  Created by user on 27/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import <Foundation/Foundation.h>

//相册里的照片
@interface DFAssetModel : NSObject

@property (nonatomic, strong) id asset;    //id类型是PHAsset or ALAsset
@property (nonatomic, assign) BOOL isSelected;  //照片是否被选中

@end


//本地图片相册分组
@interface DFAlbumModel : NSObject

@property (nonatomic, strong) NSString *name;  //相册名称
@property (nonatomic, assign) NSUInteger count;  //照片数量
@property (nonatomic, strong) id result;     //id类型是PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset>

@property (nonatomic, strong) NSArray *models;

@end


