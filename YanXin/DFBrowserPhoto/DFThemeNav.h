//
//  DFThemeNav.h
//  Technology
//
//  Created by user on 27/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFImageManager.h"
#import "DFAssetDelegate.h"

@interface DFThemeNav : UINavigationController

@property (nonatomic, retain) id<DFAssetDelegate> assetDelegate;

//选中照片的数组
@property (nonatomic, strong) NSMutableArray *selectedAssetArray;

/**功能：相册的初始化方法
 * @param delegate 委托协议
 * @param pushPhotoPickerVC  是否直接跳转到相册
 * return DFThemeNav
 */
- (instancetype)initWithDelegate:(id<DFAssetDelegate>)delegate pushPhotoPickerVC:(BOOL)pushPhotoPickerVC;


/**功能：相册选中功能
 * @param isSelected 是否选中
 * @param model   相册模型
 * return void
 */

-(void)selectPhoto:(BOOL)isSelected withModel:(DFAssetModel *)model;



@end
