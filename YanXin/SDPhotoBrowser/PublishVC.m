//
//  PublishVC.m
//  YanXin
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PublishVC.h"
#import "SGImagePickerController.h"
#import "ZLPhotoActionSheet.h"
#import "PictureAddCell.h"
#import "PictureCollectionViewCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface PublishVC ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,MJPhotoBrowserDelegate>
{
      NSInteger editTag;
}
@property(nonatomic,strong)NSMutableArray *itemsSectionPictureArray;

@end

@implementation PublishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.title=@"发布动态";
    self.view.backgroundColor=[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
   
    //左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    //右按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 3,40, 20);
    [rightBtn setTitle:@"发布" forState:0];
    [rightBtn addTarget:self action:@selector(bianJiBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
    
    self.itemsSectionPictureArray = [[NSMutableArray alloc] init];
    self.neirongTF=[[UITextView alloc]initWithFrame:CGRectMake(0, 84, KUAN, 100)];
     self.neirongTF.textAlignment=NSTextAlignmentJustified;
    self.neirongTF.backgroundColor=[UIColor whiteColor];
    self.neirongTF.text=@"这一刻你的想法...";
    self.neirongTF.font=[UIFont systemFontOfSize:15];
    self.neirongTF.textColor=[UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:.7];
    self.neirongTF.keyboardType=UIKeyboardTypeDefault;
    self.neirongTF.delegate=self;
    [self.view addSubview:self.neirongTF];


    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(75, 75);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 5; //上下的间距 可以设置0看下效果
    layout.sectionInset = UIEdgeInsetsMake(0.f, 5, 5.f, 5);
    
    
    
    //创建 UICollectionView
    self.pictureCollectonView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 184, self.view.frame.size.width, 100) collectionViewLayout:layout];
    self.pictureCollectonView.backgroundColor = [UIColor whiteColor];
    self.pictureCollectonView.delegate = self;
    self.pictureCollectonView.dataSource = self;
    [self.pictureCollectonView registerClass:[PictureCollectionViewCell class]forCellWithReuseIdentifier:@"cell"];
    
    [self.pictureCollectonView registerClass:[PictureAddCell class] forCellWithReuseIdentifier:@"addItemCell"];

    [self.view addSubview:self.pictureCollectonView];

    
    UIView * view =[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[view]];
   
    view.sd_layout
    .topSpaceToView(self.pictureCollectonView,1)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(35);
    
    UILabel * label =[UILabel new];
    label.text=@"显示时间";
    label.frame=CGRectMake(5, 2, 120, 30);
    label.textColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [view addSubview:label];
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString*   date = [formatter stringFromDate:[NSDate date]];
    UILabel *timeLabe =[UILabel new];
    timeLabe.text=date;
    timeLabe.textColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    timeLabe.frame=CGRectMake(KUAN-120, 2, 100, 30);
    [view addSubview:timeLabe];
    
    
}
#pragma mark - collectionView 调用方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemsSectionPictureArray.count +1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.itemsSectionPictureArray.count) {
        static NSString *addItem = @"addItemCell";
        
        UICollectionViewCell *addItemCell = [collectionView dequeueReusableCellWithReuseIdentifier:addItem forIndexPath:indexPath];
        
        return addItemCell;
    }else
    {
        static NSString *identify = @"cell";
        PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        
        cell.imageView.image = self.itemsSectionPictureArray[indexPath.row];
        
        return cell;
    }
}

//用代理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == self.itemsSectionPictureArray.count) {
        if (self.itemsSectionPictureArray.count > 8)
        {
            return;
        }
        
         UIAlertController * alercontroller=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                        // 先判断相机是否可用
                        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                        {
                            // 把imagePicker.sourceType改为相机
                            UIImagePickerController * imagePicker=[[UIImagePickerController alloc]init];
                            imagePicker.delegate =self;
                            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                            [self presentViewController:imagePicker animated:YES completion:nil];
                        }else
                        {
                            NSLog(@"相机不可用");
                        }
                
            }];
            UIAlertAction * action3 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
                }];
            UIAlertAction *action2=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                SGImagePickerController *picker = [[SGImagePickerController alloc] init];
                picker.maxCount = 5;
                //返回的图片
                [picker setDidFinishSelectThumbnails:^(NSArray *thumbnails) {
                     NSLog(@"缩略图%@",thumbnails);
                   
                
                }];
                
                [picker setDidFinishSelectImages:^(NSMutableArray *images) {
                
                    
                   
                    NSMutableArray *indexPathes = [NSMutableArray array];
                    
                    for (unsigned long i = self.itemsSectionPictureArray.count; i < self.itemsSectionPictureArray.count + images.count; i++)
                    {
                        [indexPathes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                    }
                     [self.itemsSectionPictureArray addObjectsFromArray:images];
                    [UIView animateWithDuration:.25 delay:0 options:7 animations:^{
                        
                     //   NSLog(@">>>%lu",self.itemsSectionPictureArray.count);
                        if (self.itemsSectionPictureArray.count <4) {
                            self.pictureCollectonView.frame = CGRectMake(0, 184, self.view.frame.size.width, 100);
                        }else if (self.itemsSectionPictureArray.count <8)
                        {
                            self.pictureCollectonView.frame = CGRectMake(0, 184, self.view.frame.size.width, 160);
                        }else
                        {
                            self.pictureCollectonView.frame = CGRectMake(0, 184, self.view.frame.size.width, 240);
                        }
                        
                        [self.view layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        // 添加新选择的图片
                        [self.pictureCollectonView performBatchUpdates:^{
                            [self.pictureCollectonView insertItemsAtIndexPaths:indexPathes];
                        } completion:nil];
                    }];
                    
                 //   [self.itemsSectionPictureArray addObjectsFromArray:images];
                
                }];
                
                
                
                
               [self presentViewController:picker animated:YES completion:nil];
        
            }];
        [alercontroller addAction:action1];
        [alercontroller addAction:action2];
        [alercontroller addAction:action3];
        [self presentViewController:alercontroller animated:YES completion:nil];
    }
   else
   {
       NSMutableArray *photoArray = [[NSMutableArray alloc] init];
       for (int i = 0;i< self.itemsSectionPictureArray.count; i ++) {
           UIImage *image = self.itemsSectionPictureArray[i];
           
           MJPhoto *photo = [MJPhoto new];
           photo.image = image;
           PictureCollectionViewCell *cell = (PictureCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
           photo.srcImageView = cell.imageView;
           [photoArray addObject:photo];
       }
       
       
       MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
       browser.photoBrowserdelegate = self;
       browser.currentPhotoIndex = indexPath.row;
       browser.photos = photoArray;
       [browser show];
       
   }
    
    
    
}


-(void)deletedPictures:(NSSet *)set
{
    NSMutableArray *cellArray = [NSMutableArray array];
    
    for (NSString *index1 in set) {
        [cellArray addObject:index1];
    }
    
    if (cellArray.count == 0) {
        
    }else if (cellArray.count == 1 && self.itemsSectionPictureArray.count == 1) {
        NSIndexPath *indexPathTwo = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.itemsSectionPictureArray removeObjectAtIndex:indexPathTwo.row];
        [self.pictureCollectonView deleteItemsAtIndexPaths:@[indexPathTwo]];
    }else{
        
        for (int i = 0; i<cellArray.count-1; i++) {
            for (int j = 0; j<cellArray.count-1-i; j++) {
                if ([cellArray[j] intValue]<[cellArray[j+1] intValue]) {
                    NSString *temp = cellArray[j];
                    cellArray[j] = cellArray[j+1];
                    cellArray[j+1] = temp;
                }
            }
        }
        
        for (int b = 0; b<cellArray.count; b++) {
            int idexx = [cellArray[b] intValue]-1;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idexx inSection:0];
            
            [self.itemsSectionPictureArray removeObjectAtIndex:indexPath.row];
            [self.pictureCollectonView deleteItemsAtIndexPaths:@[indexPath]];
        }
    }
    
    if (self.itemsSectionPictureArray.count <4) {
        self.pictureCollectonView.frame = CGRectMake(0, 184, self.view.frame.size.width, 100);
    }else if (self.itemsSectionPictureArray.count <8)
    {
        self.pictureCollectonView.frame = CGRectMake(0, 184, self.view.frame.size.width, 160);
    }else
    {
        self.pictureCollectonView.frame = CGRectMake(0, 184, self.view.frame.size.width, 240);
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    
    [self.itemsSectionPictureArray addObject:image];
    __weak PublishVC *wself = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [UIView animateWithDuration:.25 delay:0 options:7 animations:^{
            if (wself.itemsSectionPictureArray.count <4) {
                wself.pictureCollectonView.frame = CGRectMake(0, 184, wself.view.frame.size.width, 75);
            }else if (wself.itemsSectionPictureArray.count <8)
            {
                wself.pictureCollectonView.frame = CGRectMake(0, 184, wself.view.frame.size.width, 160);
            }else
            {
                wself.pictureCollectonView.frame = CGRectMake(0, 184, wself.view.frame.size.width, 240);
            }
            
            [wself.view layoutIfNeeded];
        } completion:nil];
        
        [self.pictureCollectonView performBatchUpdates:^{
            [wself.pictureCollectonView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:wself.itemsSectionPictureArray.count - 1 inSection:0]]];
        } completion:nil];
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backClink
{
    [self.navigationController popViewControllerAnimated:YES];
}
//fabu
-(void)bianJiBtn
{   //照片
    //NSLog(@"%lu",_itemsSectionPictureArray.count);
//    //内容
  
//    for ( int i =0; i<_itemsSectionPictureArray.count; i++) {
//        UIImage * image =_itemsSectionPictureArray[i];
//        NSLog(@"%@",image);
//    }
//    
    
    // [LCLoadingHUD showLoading:@"正在发布,请稍后..."];
    if ([self.neirongTF.text isEqualToString:@"这一刻你的想法..."]) {
        NSLog(@"没东西");
        self.neirongTF.text=@"";
    }
   // NSLog(@"这是东西%@",self.neirongTF.text);
    
    [ShuJuModel publishNeirong:self.neirongTF.text Image:self.itemsSectionPictureArray success:^(NSDictionary *dic) {
       
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            [WINDOW showHUDWithText:@"发布成功" Type:ShowPhotoYes Enabled:YES];
           //  [LCLoadingHUD hideInKeyWindow];
        //     NSLog(@"发布成功");
            [self.navigationController popViewControllerAnimated:YES];
        }
      
  } error:^(NSError *error) {
      
  }];

}

//- (IBAction)zhaopianBtn:(UIButton *)sender {
//    
//    
//    UIAlertController * alercontroller=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        
//        
//        
//        
//        
//    }];
//    UIAlertAction * action3 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [_imageArr removeAllObjects];
//        SGImagePickerController *picker = [[SGImagePickerController alloc] init];
//        picker.maxCount = 5;
//        //返回选择的缩略图
//        [picker setDidFinishSelectThumbnails:^(NSArray *thumbnails) {
//            // NSLog(@"缩略图%@",thumbnails);
//        }];
//        
//        //返回选中的原图
//        [picker setDidFinishSelectImages:^(NSMutableArray *images) {
//            //NSLog(@"原图%@",images);
//            
//            self.baseview.contentSize=CGSizeMake(KUAN+12*images.count, 100);
//            self.baseview.showsHorizontalScrollIndicator=NO;
//            _imageArr=images;
//            for (int i =0; i<images.count; i++) {
//                
//                UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                addBtn.tag=i;
//                [addBtn addTarget:self action:@selector(tapGesture:) forControlEvents:UIControlEventTouchUpInside];
//                [addBtn setBackgroundImage:images[i] forState:0];
//                addBtn.frame=CGRectMake(0+(100+10)*i, 0, 100, 100);
//                [_baseview addSubview:addBtn];
//                
//                UILongPressGestureRecognizer *gester = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//                [addBtn addGestureRecognizer:gester];
//                
//            }
//        }];
//        [self presentViewController:picker animated:YES completion:nil];
//        
//        
//    }];
//    [alercontroller addAction:action1];
//    [alercontroller addAction:action2];
//    [alercontroller addAction:action3];
//    [self presentViewController:alercontroller animated:YES completion:nil];
//    
//    
//   
//
//    
//}
//#pragma mark -- UIImagePickerControllerDelegate
//// 点击Cancle调用的方法
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//// 选中图片调用的方法
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    NSLog(@"%@",info);
//    
//   // UIImage  *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    // 把拍得照片保存到本地相册
//    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSave:contentsInfo:), nil);
//    // 对图片进行压缩
//    // 1.要进行压缩的图片2.压缩系数0~1
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//
//
//
//
//-(void)tapGesture:(UIButton *)btn
//{
//    [btn.layer removeAnimationForKey:@"shake"];
//    [self deleClose:btn];
//}
//// 长按添加删除按钮
//- (void)longPress : (UIGestureRecognizer *)gester
//{
//   
//    
//    if (gester.state == UIGestureRecognizerStateBegan)
//    {
//        UIButton *btn = (UIButton *)gester.view;
//        
//        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
//        dele.bounds = CGRectMake(0, 0, deleImageWH, deleImageWH);
//        [dele setImage:[UIImage imageNamed:kAdeleImage] forState:UIControlStateNormal];
//        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
//        dele.frame = CGRectMake(btn.frame.size.width - dele.frame.size.width, 0, dele.frame.size.width, dele.frame.size.height);
//        
//        [btn addSubview:dele];
//        [self start : btn];
//        
//        
//    }
//    
//}
//// 删除"删除按钮"
//- (BOOL)deleClose:(UIButton *)btn
//{
//    if (btn.subviews.count == 2) {
//        [[btn.subviews lastObject] removeFromSuperview];
//        [self stop:btn];
//        return YES;
//    }
//    
//    return NO;
//}
//// 停止抖动
//- (void)stop : (UIButton *)btn{
//    [btn.layer removeAnimationForKey:@"shake"];
//}
////-(void)layoutSublayersOfLayer:(CALayer *)layer
////{
////  //  int count = self.subviews.count;
////    [super layoutSublayersOfLayer:layer];
////    
////    CGFloat btnW = imageW;
////    CGFloat btnH = imageH;
////    int maxColumn = kMaxColumn > KUAN / imageW ? KUAN / imageW : kMaxColumn;
////    CGFloat marginX = (KUAN - maxColumn * btnW) / (4 + 1);
////    CGFloat marginY = marginX;
////    for (int i = 0; i < 4; i++) {
////        UIButton *btn = i;
////        CGFloat btnX = (i % maxColumn) * (marginX + btnW) + marginX;
////        CGFloat btnY = (i / maxColumn) * (marginY + btnH) + marginY;
////        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
////    }
////
////    
////}
//// 长按开始抖动
//- (void)start : (UIButton *)btn {
//    double angle1 = -5.0 / 180.0 * M_PI;
//    double angle2 = 5.0 / 180.0 * M_PI;
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
//    anim.keyPath = @"transform.rotation";
//    
//    anim.values = @[@(angle1),  @(angle2), @(angle1)];
//    anim.duration = 0.25;
//    // 动画的重复执行次数
//    anim.repeatCount = MAXFLOAT;
//    
//    // 保持动画执行完毕后的状态
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
//    
//    [btn.layer addAnimation:anim forKey:@"shake"];
//}
//
//
//
//// 删除图片
//- (void)deletePic : (UIButton *)btn
//{
//    
//    [_imageArr removeObject:[(UIButton *)btn.superview imageForState:UIControlStateNormal]];
//    [btn.superview removeFromSuperview];
////    if ([[self.subviews lastObject] isHidden]) {
////        [[self.subviews lastObject] setHidden:NO];
////    }
////
//    
//}
//
//
//
//


- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"这一刻你的想法..."]) {
        textView.text = @"";
        self.neirongTF.textColor=[UIColor blackColor];
        self.neirongTF.font=[UIFont systemFontOfSize:17];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length<1) {
        textView.text = @"这一刻你的想法...";
        self.neirongTF.textColor=[UIColor colorWithRed:75/255.0 green:75/255.0 blue:75/255.0 alpha:.7];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
