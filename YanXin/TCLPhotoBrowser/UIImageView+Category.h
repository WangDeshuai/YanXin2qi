//
//  UIImageView+Category.h
//  TCLPhotoBrowser
//
//  Created by TCL on 16/1/14.
//  Copyright © 2016年 alitan2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Category)<NSURLSessionDelegate,NSURLSessionDownloadDelegate>
/**
 *  根据URL字符串加载图片
 *
 *  @param URLString 外部传入URL字符串
 */
-(void)setImageWithURLString:(NSString *)URLString;
-(void)setImageWithURL:(NSString *)url palceholder:(NSString *)imageName;
@end
