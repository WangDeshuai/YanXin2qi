//
//  DFBrowserAnimator.h
//  Technology
//
//  Created by user on 3/1/17.
//  Copyright © 2017年 DFF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DFPresentedProtocol <NSObject>

//获取当前图片
-(UIImageView *)getImageView:(NSIndexPath *)indexPath;

/**
 当前图片在所有屏幕上的frame
 */
-(CGRect)getStartRect:(NSIndexPath *)indexPath;
/**
 获得当前图片计算完后的frame
 */
-(CGRect)getEndRect:(NSIndexPath *)indexPath;

@end

@protocol DFDismissProtocol <NSObject>

-(UIImageView *)getImageView;

-(NSIndexPath *)getIndexPath;

@end

@interface DFBrowserAnimator : NSObject<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresented;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<DFPresentedProtocol> presentedDelegate;
@property (nonatomic, weak) id<DFDismissProtocol> dismissDelegate;


@end
