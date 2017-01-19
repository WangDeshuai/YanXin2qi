//
//  DFImageGroupViewController.h
//  Technology
//
//  Created by user on 26/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFAssetModel.h"
#import "DFThemeNav.h"

@interface DFImageGroupViewController : UIViewController
@property (nonatomic, strong) DFAlbumModel *albumModel;   //在哪个group（默认相机胶卷）
@end
