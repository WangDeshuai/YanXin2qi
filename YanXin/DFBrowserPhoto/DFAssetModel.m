//
//  DFAssetModel.m
//  Technology
//
//  Created by user on 27/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import "DFAssetModel.h"
#import "DFImageManager.h"

@implementation DFAssetModel

@end

@implementation DFAlbumModel


-(void)setResult:(id)result{
    _result = result;
    [[DFImageManager manager] getAssetsFromFetchResult:result completion:^(NSArray<DFAssetModel *> *models) {
        _models = models;
    }];
    
}

@end
