//
//  BrowserCCell.h
//  DFPhotoBrower
//
//  Created by dongff on 16/8/18.
//  Copyright © 2016年 dongff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFAssetModel.h"


@protocol DFBrowserCCellDelegate <NSObject>

-(void)tap;

@end

@interface DFBrowserCCell : UICollectionViewCell

-(void)setCellImageWithImage:(DFAssetModel *)model;
-(void)setCellImageWithUrl:(NSURL *)url;

-(UIImageView *)getSourceImageView;


@property (nonatomic, weak) id <DFBrowserCCellDelegate> delegate;

@end
