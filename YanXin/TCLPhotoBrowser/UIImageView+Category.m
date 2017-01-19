 //
//  UIImageView+Category.m
//  TCLPhotoBrowser
//
//  Created by TCL on 16/1/14.
//  Copyright © 2016年 alitan2014. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)
//根据URL显示图片
-(void)setImageWithURLString:(NSString *)URLString{
    [self requsetImageWithURL:URLString placeholder:nil];
}
-(void)setImageWithURL:(NSString *)url palceholder:(NSString *)imageName{
    [self requsetImageWithURL:url placeholder:imageName];
}
/*  异步请求图片 防止阻塞 主线程 */
-(void)requsetImageWithURL:(NSString *)url placeholder:(NSString *)imageName{
    NSURLRequest *requset = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionConfiguration *configuration= [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session =[NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];;
    NSURLSessionDownloadTask *task=[session downloadTaskWithRequest:requset];
    [task resume];
}
/*  创建文件本地保存目录  */
-(NSURL *)createDirectoryForDownloadItemFromURL:(NSURL *)location
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = urls[0];
    return [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
}
/*  把文件拷贝到指定路径  */
-(BOOL) copyTempFileAtURL:(NSURL *)location toDestination:(NSURL *)destination
{
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:destination error:NULL];
    [fileManager copyItemAtURL:location toURL:destination error:&error];
    if (error == nil) {
        return true;
    }else{
        NSLog(@"%@",error);
        return false;
    }
}
#pragma mark downloadTask delegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    //下载成功后，文件是保存在一个临时目录的，需要开发者自己考到放置该文件的目录
    NSURL *destination = [self createDirectoryForDownloadItemFromURL:location];
    BOOL success = [self copyTempFileAtURL:location toDestination:destination];
    
    if(success){
        //        文件保存成功后，使用GCD调用主线程把图片文件显示在UIImageView中
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithContentsOfFile:[destination path]];
            self.image = image;
            self.contentMode = UIViewContentModeScaleAspectFit;
        });
    }else{
        NSLog(@"Meet error when copy file");
    }
    
}

@end
