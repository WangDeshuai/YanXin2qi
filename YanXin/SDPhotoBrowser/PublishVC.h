//
//  PublishVC.h
//  YanXin
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishVC : UIViewController
@property (retain, nonatomic) UITextView *neirongTF;
@property(nonatomic,strong)UICollectionView *pictureCollectonView;

- (IBAction)zhaopianBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *baseview;
@property(nonatomic,retain)NSMutableArray * imageArr;
@end
