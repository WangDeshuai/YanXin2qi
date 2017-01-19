//
//  Message1.m
//  YanXin
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Message1.h"
#import "ZJAlertListView.h"
#import "MessageModel.h"
#import "ShuJuModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+AFNetworking.h"
#import "UIButton+WebCache.h"
#import "UIWindow+YzdHUD.h"
#import "UIImageView+LBBlurredImage.h"
#import "UIImageView+WebCache.h"
#import "ChooseCityViewController1.h"
#import "LCLoadingHUD.h"
#define KUAN1 self.view.frame.size.width
#define GAO1  self.view.frame.size.height
#define WINDOW [[[UIApplication sharedApplication] delegate] window]

@interface Message1 ()<ZJAlertListViewDelegate,ZJAlertListViewDatasource,UITextViewDelegate>
{
     NSMutableArray * dataArr;
     NSMutableArray * _numArr;
    UIButton * baoCunBtn;
    MessageModel *model;
}
@end

@implementation Message1
-(void)viewWillAppear:(BOOL)animated
{
    
    
         NSString*a=  [[NSUserDefaults standardUserDefaults]objectForKey:@"xian1"];
            NSString*b=  [[NSUserDefaults standardUserDefaults]objectForKey:@"shi1"];
            NSString*c= [[NSUserDefaults standardUserDefaults]objectForKey:@"sheng1"];
            Diquname =[NSString stringWithFormat:@"%@-%@-%@",c,b,a];
            [self.addressBtn setTitle:Diquname forState:0];
            [self.addressBtn setTitleColor:[UIColor blackColor] forState:0];
   // NSLog(@"姓别%ld",(long)numberXB);
    //    NSLog(@"身份%ld",(long)numberSF);
    //    NSLog(@"标签>>>%ld",(long)self.selectedIndexPath.row);
    //    NSLog(@"姓名%@",self.nameTF.text);
    //    NSLog(@"所在地%@",text1);
    //    NSLog(@"简介%@",_myJianjieTF.text);
    //    NSLog(@"经历%@",_myJingLiTF.text);
    //[self HuoQuData];
 }
-(void)HuoQuData
{
 
    [ShuJuModel myMessageWithsuccess:^(NSDictionary *dic) {
        NSDictionary * contentDic =[dic objectForKey:@"content"];
        model=[[MessageModel alloc]initWithDic:contentDic];
           self.nameTF.text=model.name;
           self.userNameLab.text=model.name;
          [self.xingBieTF setTitle:model.xingBie forState:0];
         self.shoujihao.text=model.shoujihao;
          [self.addressBtn setTitle:model.diQu forState:0];
        NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>我看一下地区%@",model.diQu);
          [self.xingBieTF setTitleColor:[UIColor blackColor] forState:0];
          [self.addressBtn setTitleColor:[UIColor blackColor] forState:0];
       // NSLog(@"%@",model.lineImage);
          [_lineBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.lineImage] placeholderImage:[UIImage imageNamed:@"头像占位图"]];
        //[_lineBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.lineImage]];
      //  [_bgimageView sd_setImageWithURL:[NSURL URLWithString:model.lineImage]];
        [_bgimageView sd_setImageWithURL:[NSURL URLWithString:model.lineImage] placeholderImage:[UIImage imageNamed:@"主题背景"]];
       UIImage *imge=  [self scaleToSize:_bgimageView.image size:CGSizeMake(KUAN1, 222)];
        _bgimageView.image=imge;
        [_bgimageView setImageToBlur:_bgimageView.image blurRadius:20 completionBlock:nil];
        if ([model.shenFen isEqualToString:@"1"]) {
                _yanYuanView.hidden=YES;
            }
        if ([model.shenFen isEqualToString:@"2"]){
            _yanYuanView.hidden=NO;
            _scrollerview.contentSize=CGSizeMake(KUAN1, GAO1+330);
//            int a =[model.biaoQian intValue];
//            NSLog(@"这是从网络获取的标签序号%d",a);
            /*
             [ShuJuModel huoquyanyuanWihBiaoQian:@"0" success:^(NSDictionary *dic) {
             NSArray * content =[dic objectForKey:@"content"];
             for (NSDictionary * dicc in content) {
             NSString *name= [dicc objectForKey:@"categoryname"];
             [baiqian addObject:name];
             
             NSLog(@"%@",name);
             }
             [[NSUserDefaults standardUserDefaults]setObject:baiqian forKey:@"biaoqiankey"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             } error:^(NSError *error) {
             
             }];
             
             
             */
           
//            if (a==0) {
//                [self.zhiYeBtn setTitle:dataArr[0] forState:0];
//            }else{
//                [self.zhiYeBtn setTitle:dataArr[a-1] forState:0];
//                
//            }
            [self.zhiYeBtn setTitleColor:[UIColor blackColor] forState:0];
            
            [self.zhiYeBtn setTitle:model.biaoQian forState:0];
            
            _myJianjieTF.text=model.jianJie;
            _myJingLiTF.text=model.jingLi;
            _myJianjieTF.textColor=[UIColor blackColor];
            _myJingLiTF.textColor=[UIColor blackColor];
        }
        
        
    } error:^(NSError *error) {
        
    }];
    

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self HuoQuData];
    
    [self.navigationItem setTitle:@"个人信息"];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    self.xingBieTF.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    self.xingBieTF.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    self.addressBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    self.addressBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    self.zhiYeBtn .contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    self.zhiYeBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);

    self.lineBtn.layer.cornerRadius=40;
    self.lineBtn.clipsToBounds=YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [_scrollerview addGestureRecognizer:tap];
    _scrollerview.contentSize=CGSizeMake(KUAN1, 0);
    _scrollerview.bounces=NO;
    _yanYuanView.hidden=YES;
  
    NSMutableArray * baiqian =[NSMutableArray new];
    NSMutableArray * numm =[NSMutableArray new];
    [ShuJuModel huoquyanyuanWihBiaoQian:@"0" success:^(NSDictionary *dic) {
        NSArray * content =[dic objectForKey:@"content"];
        for (NSDictionary * dicc in content) {
            NSString *name= [dicc objectForKey:@"categoryname"];
            NSString * mm =[NSString stringWithFormat:@"%@",[dicc objectForKey:@"num"]];
            [baiqian addObject:name];
            [numm addObject:mm];
            NSLog(@"%@",mm);
        }
        [[NSUserDefaults standardUserDefaults]setObject:baiqian forKey:@"biaoqiankey"];
       [[NSUserDefaults standardUserDefaults]setObject:numm forKey:@"num"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    } error:^(NSError *error) {
        
    }];
   dataArr=  nil;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"biaoqiankey"]) {
        dataArr=[[NSUserDefaults standardUserDefaults]objectForKey:@"biaoqiankey"];
    }else{
        dataArr=[[NSMutableArray alloc]initWithObjects:@"明星",@"主持人",@"舞蹈",@"魔术",@"杂技",@"歌手",@"器乐",@"乐队",@"模仿秀",@"曲艺类",@"其它类", nil];
    }
//
    
    
    
//    dataArr=  [[NSUserDefaults standardUserDefaults] objectForKey:@"bq"];
//    NSLog(@">>>%lu",(unsigned long)dataArr.count);
//右按钮
//    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame=CGRectMake(0, 3,40, 20);
//    [rightBtn setTitle:@"保存" forState:0];
//    [rightBtn addTarget:self action:@selector(SaveBtn:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem=right;
//左按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink:) forControlEvents:UIControlEventTouchUpInside];
   UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    self.myJianjieTF.delegate=self;
    self.myJianjieTF.tag=20;
    self.myJingLiTF.delegate=self;
    self.myJingLiTF.tag=21;
   
}

- (IBAction)Savebtn:(UIButton *)sender {

    NSData * data=nil;
    if (image1==nil) {
        data=nil;
    }else{
        data = UIImageJPEGRepresentation(image1, 0);
    }
    UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请完善个人信息后提交" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alerview addAction:action1];
//个人
    if ([_nameTF.text isEqualToString:@""] ){
        NSLog(@"请输入姓名");
        [self presentViewController:alerview animated:YES completion:nil];
        return;
    } if (Xbname==nil){
        if (model.xingBie==nil) {
            NSLog(@"请输入性别");
            [self presentViewController:alerview animated:YES completion:nil];
            return;
        }else{
            Xbname=model.xingBie;
        }
        
        
    }if ([Diquname isEqualToString:@"(null)-(null)-(null)"]){
        if (model.diQu==nil) {
            NSLog(@"请输入地区");
            [self presentViewController:alerview animated:YES completion:nil];
            return;
        }else{
            Diquname=model.diQu;
        }
       // return;
    }
    if (sender.tag==100&&Xbname!=nil&&![_nameTF.text isEqualToString:@""]&&![Diquname isEqualToString:@""])
    {
        NSLog(@"姓名是%@",_nameTF.text);
        NSLog(@"性别是%@",Xbname);
        NSLog(@"地区是%@",Diquname);
        NSString * xb =nil;
        if ([Xbname isEqualToString:@"女"])
         {
            xb=@"0";
        }else
        {
            xb=@"1";
        }
      //   [LCLoadingHUD showLoading:@"正在保存,请稍后..."];
        if ([_shoujihao.text isEqualToString:@""]) {
            [self presentViewController:alerview animated:YES completion:nil];
            return;
        }

        
        [ShuJuModel saveMyMessageWithName:self.nameTF.text xingbie:xb address:Diquname identity:@"1" lineimage:data phoneNumber:_shoujihao.text  success:^(NSDictionary *dic) {
            
            
         //   NSLog(@"wwwww");
                 NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                 if ([code isEqualToString:@"1"])
                 {
                     NSLog(@"保存成功");
                 //     [LCLoadingHUD hideInKeyWindow];
                     [self.navigationController popViewControllerAnimated:YES];
                 }
            
        } error:nil];
        
  }
//演员
    if (sender.tag==101){
        if (Xbname!=nil&&![_nameTF.text isEqualToString:@""]&&![Diquname isEqualToString:@""])
        {
            NSLog(@"姓别%@",Xbname);
            NSLog(@"姓名%@",self.nameTF.text);
            NSLog(@"所在地%@",Diquname);
            NSString * xb =nil;
            if ([Xbname isEqualToString:@"女"])
            {
                xb=@"0";
            }else
            {
                xb=@"1";
            }
          //修改后的标签
            NSString * bq =nil;
            NSString * q =[NSString stringWithFormat:@"%@",model.biaoQian];
           NSString * qq =[NSString stringWithFormat:@"%@",self.selectedath];
            if ([qq isEqualToString:q]) {
                bq=model.biaoQian;
            }else{
                bq=self.selectedath;
            }
            NSLog(@"提交的标签是标签%@",bq);
            if (_myJianjieTF.text==nil||_myJingLiTF.text==nil)
            {
                
            }else
            {
                NSLog(@">>>%@",_myJingLiTF.text);
                NSLog(@"简介>>>%@",_myJianjieTF.text);
                if ([_shoujihao.text isEqualToString:@""]) {
                    [self presentViewController:alerview animated:YES completion:nil];
                    return;
                }
            //    [LCLoadingHUD showLoading:@"正在保存,请稍后..."];
                
                [ShuJuModel saveMyMessageWithName:self.nameTF.text xingbie:xb address:Diquname identity:@"2" biaoqian:bq myjianjie:_myJianjieTF.text myjingli:_myJingLiTF.text lineimage:data phoneNumber:_shoujihao.text success:^(NSDictionary *dic) {
                    NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                    if ([code isEqualToString:@"1"])
                    {
                        NSLog(@"保存成功");
                       //  [LCLoadingHUD hideInKeyWindow];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                } error:nil];
                
                
            }
        }
    }
   
    

}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
-(void)SaveBtn:(UIButton*)btn
{
    
    
  
}

-(void)backClink:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)lienBtn:(id)sender {
    
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    controller.allowsEditing = YES;
    
    [self presentViewController:controller animated:YES completion:nil];
    
    
    
}


- (IBAction)xingBieBtn:(id)sender {

    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消");
        
    }];
    
    UIAlertAction *women = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"点击了女");
        [self.xingBieTF setTitle:@"女" forState:0];
        Xbname=@"女";
        
    }];
    UIAlertAction *men = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"点击了男");
          Xbname=@"男";
        [self.xingBieTF setTitle:@"男" forState:0];
    }];
    
    
    [alertVc addAction:cancle];
    [alertVc addAction:women];
    [alertVc addAction:men];
    [self presentViewController:alertVc animated:YES completion: nil];
    
    
}

- (IBAction)juZhuDiBtn:(id)sender {
    
    ChooseCityViewController1 * cvc =[ChooseCityViewController1 new];
    cvc.hidesBottomBarWhenPushed=YES;
    cvc.zhi=@"last";
    [self.navigationController pushViewController:cvc animated:YES];
 
    
    
    
}


- (IBAction)biaoQianBtn:(id)sender {
    ZJAlertListView *alertList1 = [[ZJAlertListView alloc]initWithFrame:CGRectMake(0, 0, 250, 300)];
    alertList1.titleLabel.text = @"请选择您的职业";
    alertList1.datasource = self;
    alertList1.delegate = self;
    [alertList1 setDoneButtonWithBlock:^{
        NSIndexPath *selectedIndexPath = self.selectedIndexPath;
      
        [self.zhiYeBtn setTitle:dataArr[selectedIndexPath.row] forState:0];
        [self.zhiYeBtn setTitleColor:[UIColor blackColor] forState:0];
        [alertList1 dismiss];
    }];
    [alertList1 show];

}






























#pragma mark -设置行数标签的选择
- (NSInteger)alertListTableView:(ZJAlertListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)alertListTableView:(ZJAlertListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableAlertListCellWithIdentifier:identifier];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ( self.selectedIndexPath && NSOrderedSame == [self.selectedIndexPath compare:indexPath])
    {
        cell.imageView.image = [UIImage imageNamed:@"dx_checkbox_red_on"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"dx_checkbox_off"];
    }
    cell.textLabel.text=dataArr[indexPath.row];
    
    return cell;
}

- (void)alertListTableView:(ZJAlertListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView alertListCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"dx_checkbox_off"];
}

- (void)alertListTableView:(ZJAlertListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    NSMutableArray * ar= [[NSUserDefaults standardUserDefaults]objectForKey:@"num"];
    NSLog(@"我是num%@",ar);
   NSString * a = ar[indexPath.row];
    self.selectedath=a;
       NSLog(@"我是数字%@",a);
    UITableViewCell *cell = [tableView alertListCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"dx_checkbox_red_on"];
}

#pragma mark --上传头像
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    image1=image;
    _bgimageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgimageView.image=image1;
    [_bgimageView setImageToBlur:_bgimageView.image blurRadius:21 completionBlock:nil];
    [self.lineBtn setBackgroundImage:image forState:0];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)tap
{
    [_scrollerview endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
