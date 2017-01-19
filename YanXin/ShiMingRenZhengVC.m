//
//  ShiMingRenZhengVC.m
//  YanXin
//
//  Created by Macx on 17/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ShiMingRenZhengVC.h"
#import "ChongZhiVC.h"
#import "TanKuangView.h"
@interface ShiMingRenZhengVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UITextField * nameText;//姓名
    UITextField * nameText2;//证件号码
}
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UIButton * lastBtn;
@property(nonatomic,strong)TanKuangView *tanKuangVC;
@property(nonatomic,strong)UIImage * image1;//正面
@property(nonatomic,strong)UIImage *image2;//反面
@end

@implementation ShiMingRenZhengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];//创建导航条
    self.bgView=self.view;
     self.bgView.backgroundColor=COLOR;
    [self CreatView];
}
#pragma mark --调用弹框
-(void)tanKang{
    _tanKuangVC =[[TanKuangView alloc]initWithTitle:@"认证说明" cacleBtn:@"我知道了!"];
   __typeof(self)weakSelf = self;
    _tanKuangVC.BtnClickBlock=^(UIButton*btn){
        [weakSelf.tanKuangVC dissmiss];
    };
    
    [_tanKuangVC show];
}

-(void)CreatView{
    UIView * view1 =[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    [_bgView sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(_bgView,0)
    .rightSpaceToView(_bgView,0)
    .topSpaceToView(_bgView,64)
    .heightIs(120);
    //真实姓名
    UILabel * namelabel =[UILabel new];
    namelabel.text=@"真实姓名";
    namelabel.alpha=.7;
    namelabel.font=[UIFont systemFontOfSize:15];
    [view1 sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(view1,15)
    .topSpaceToView(view1,20)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:120];
    //姓名
    nameText =[UITextField new];
    nameText.placeholder=@"请输入真实姓名";
    nameText.font=[UIFont systemFontOfSize:15];
    [view1 sd_addSubviews:@[nameText]];
    nameText.sd_layout
    .leftSpaceToView(namelabel,15)
    .centerYEqualToView(namelabel)
    .rightSpaceToView(view1,15)
    .heightIs(30);
    [view1 setupAutoHeightWithBottomView:nameText bottomMargin:15];
    
    
    UIView * view2 =[UIView new];
    view2.backgroundColor=[UIColor whiteColor];
    [_bgView sd_addSubviews:@[view2]];
    view2.sd_layout
    .leftSpaceToView(_bgView,0)
    .rightSpaceToView(_bgView,0)
    .topSpaceToView(view1,1)
    .heightIs(120);
    //证件号码
    UILabel * namelabel2 =[UILabel new];
    namelabel2.text=@"证件号码";
    namelabel2.alpha=.7;
    namelabel2.font=[UIFont systemFontOfSize:15];
    [view2 sd_addSubviews:@[namelabel2]];
    namelabel2.sd_layout
    .leftSpaceToView(view2,15)
    .topSpaceToView(view2,20)
    .heightIs(20);
    [namelabel2 setSingleLineAutoResizeWithMaxWidth:120];
    //姓名
    nameText2 =[UITextField new];
    nameText2.placeholder=@"请输入证件号码";
    nameText2.font=[UIFont systemFontOfSize:15];
    [view2 sd_addSubviews:@[nameText2]];
    nameText2.sd_layout
    .leftSpaceToView(namelabel,15)
    .centerYEqualToView(namelabel)
    .rightSpaceToView(view2,15)
    .heightIs(30);
    [view2 setupAutoHeightWithBottomView:nameText2 bottomMargin:15];
    //上传证件
    UIView * view3 =[UIView new];
    view3.backgroundColor=[UIColor whiteColor];
    [_bgView sd_addSubviews:@[view3]];
    view3.sd_layout
    .leftSpaceToView(_bgView,0)
    .rightSpaceToView(_bgView,0)
    .topSpaceToView(view2,10)
    .heightIs(120);
    
    UILabel * namelabel3 =[UILabel new];
    namelabel3.text=@"上传证件照";
    namelabel3.alpha=.7;
    namelabel3.font=[UIFont systemFontOfSize:15];
    [view3 sd_addSubviews:@[namelabel3]];
    namelabel3.sd_layout
    .leftSpaceToView(view3,15)
    .topSpaceToView(view3,20)
    .heightIs(20);
    [namelabel3 setSingleLineAutoResizeWithMaxWidth:220];
    //认证说明
    UIButton * renzheng =[UIButton new];
    //renzheng.image=[UIImage imageNamed:@"renzheng_bt"];
    [renzheng addTarget:self action:@selector(renZhengSM) forControlEvents:UIControlEventTouchUpInside];
    [renzheng setBackgroundImage:[UIImage imageNamed:@"renzheng_bt"] forState:0];
    [view3 sd_addSubviews:@[renzheng]];
    renzheng.sd_layout
    .centerYEqualToView(namelabel3)
    .rightSpaceToView(view3,15)
    .widthIs(60)
    .heightIs(17);
    //2个上传图片按钮
    NSArray * imageArr =@[@"renzheng_add1",@"renzheng_add2"];
    int d =(ScreenWidth-137*2)/3;
    for (int i =0; i<2; i++) {
        UIButton * photoBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        photoBtn.tag=i;
        _lastBtn=photoBtn;
        [photoBtn setBackgroundImage:[UIImage imageNamed:imageArr[i]] forState:0];
        [photoBtn addTarget:self action:@selector(btnn:) forControlEvents:UIControlEventTouchUpInside];
        [view3 sd_addSubviews:@[photoBtn]];
        photoBtn.sd_layout
        .leftSpaceToView(view3,d+(d+137)*i)
        .topSpaceToView(namelabel3,20)
        .widthIs(137)
        .heightIs(92);
        
    }
    
    UIImageView *wzView =[UIImageView new];
    wzView.image=[UIImage imageNamed:@"wenzi"];//181 158
    [view3 sd_addSubviews:@[wzView]];
    wzView.sd_layout
    .leftSpaceToView(view3,15)
    .topSpaceToView(_lastBtn,20)
    .widthIs(439/2)
    .heightIs(162/2);
    [view3 setupAutoHeightWithBottomView:wzView bottomMargin:15];
    //下一步
    UIButton * nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn addTarget:self action:@selector(nextBtnn) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"renzheng_bt1"] forState:0];//305 40
    [_bgView sd_addSubviews:@[nextBtn]];
    nextBtn.sd_layout
    .centerXEqualToView(_bgView)
    .topSpaceToView(view3,50)
    .widthIs(305)
    .heightIs(40);
}
#pragma mark --上传证件照片按钮
-(void)btnn:(UIButton*)btn{
      _lastBtn=btn;
    [self headImageClick];
    
}



#pragma mark --调用系统相册
-(void)headImageClick{
    UIImagePickerController * imagePicker =[UIImagePickerController new];
    // [imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg1"] forBarMetrics:UIBarMetricsDefault];
    
    imagePicker.delegate = self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [_lastBtn setBackgroundImage:image forState:0];
    if (_lastBtn.tag==0) {
        _image1=image;
    }else{
        _image2=image;
    }
    //虚化背景图片
    [self dismissViewControllerAnimated:YES completion:nil];
}







#pragma mark --下一步按钮
-(void)nextBtnn{
    NSLog(@"姓名%@",nameText.text);
    NSLog(@"证件号码%@", nameText2.text);
    NSLog(@"image1=%@",_image1);
     NSLog(@"image2=%@",_image2);
    [LCProgressHUD showMessage:@"正在提交..."];
    [Engine shiMingRenZhengRealName:nameText.text IdCard:nameText2.text ImageZ:_image1 ImageF:_image2 success:^(NSDictionary *dic) {
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            ChongZhiVC * vc =[ChongZhiVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
  
}
#pragma mark --认证说明按钮
-(void)renZhengSM{
    [self tanKang];


}

#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=COLOR;
    self.title=@"实名认证";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:biaoti]}];
    //返回按钮
    UIButton*backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 35, 35);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:0];
    [backBtn addTarget:self action:@selector(backClink) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    
}
-(void)backClink{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
