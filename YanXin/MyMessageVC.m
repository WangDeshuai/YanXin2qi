//
//  MyMessageVC.m
//  YanXin
//
//  Created by Macx on 17/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyMessageVC.h"
#import "MyMessageCell.h"
#import "UIImageView+LBBlurredImage.h"//头像虚拟
#import "CityViewController.h"//选择地区的
#import "ZhiYeClassVC.h"//选择职业的
#import "XingBieVC.h"//选择性别
@interface MyMessageVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
//从后面界面传过来的省市县
@property(nonatomic,copy)NSString * shengName;
@property(nonatomic,copy)NSString * shiName;
@property(nonatomic,copy)NSString * xianName;
//冲后面传值过来的职业name和num
@property(nonatomic,copy)NSString * zhiYeName;
@property(nonatomic,copy)NSString * zhiYeNum;
//性别name和num
@property(nonatomic,copy)NSString * xxName;
@property(nonatomic,copy)NSString * xxYeNum;
//个人简介和演艺经历
@property(nonatomic,copy)NSString * jianJieName;
@property(nonatomic,copy)NSString * jingLiName;
//姓名和联系方式
@property(nonatomic,copy)NSString * xmName;
@property(nonatomic,copy)NSString * phoneName;
//头像url
@property(nonatomic,strong)UIImageView * bgImage;
@property(nonatomic,strong)UIImage * headImage;
@end

@implementation MyMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CreatRightBtn];//创建右按钮
   // [self CeratData];
    [self daohangTiao];
    [self CreatTabelView];//
}

#pragma mark --创建右按钮
-(void)CreatRightBtn{
    //右按钮（搜索）
    UIButton * souBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    souBtn.frame=CGRectMake(0, 0,60, 20);
    [souBtn setTitle:@"保存" forState:0];
    [souBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:souBtn];
    self.navigationItem.rightBarButtonItem=right;
}

#pragma mark --保存个人资料接口
-(void)rightBtnClick{
    //姓名
    MyMessageCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    //联系方式
    MyMessageCell *cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    NSLog(@"姓名>>>%@",[ToolClass isString:cell0.textfield.text]);
    NSLog(@"性别的数字>>%@",[self stringHouMianText:_xxYeNum ModelText:_model.sexNum]);
    NSLog(@"联系方式%@",[ToolClass isString:cell2.textfield.text]);
    NSLog(@"省>>%@市%@县%@",[ToolClass isString:[self stringHouMianText:_shengName ModelText:_model.provname]],[ToolClass isString:[self stringHouMianText:_shiName ModelText:_model.cityname]],[ToolClass isString:[self stringHouMianText:_xianName ModelText:_model.districtname]]);
    NSLog(@"职业分类%@",[self stringHouMianText:_zhiYeNum ModelText:_model.biaoQianNum]);
    NSLog(@"个人简介%@",[self stringHouMianText:_jianJieName ModelText:_model.introduction]);
    NSLog(@"演艺经历%@",[self stringHouMianText:_jingLiName ModelText:_model.experience]);
    
    //姓名
    NSString * name =[ToolClass isString:cell0.textfield.text];
    //性别数字
    NSString * xingBie=[self stringHouMianText:_xxYeNum ModelText:_model.sexNum];
    //联系方式
    NSString * lianXi=[ToolClass isString:cell2.textfield.text];
    //省.市.县
    NSString * sheng=[ToolClass isString:[self stringHouMianText:_shengName ModelText:_model.provname]];
    NSString * shi =[ToolClass isString:[self stringHouMianText:_shiName ModelText:_model.cityname]];
    NSString * xian =[self stringHouMianText:_xianName ModelText:_model.districtname];
    //职业分类标签(数字)
    NSString *bqNum=[self stringHouMianText:_zhiYeNum ModelText:_model.biaoQianNum];
    //个人简介
    NSString * jianjie =[self stringHouMianText:_jianJieName ModelText:_model.introduction];
    NSString *jingLi =[self stringHouMianText:_jingLiName ModelText:_model.experience];
    if ([_model.usertype isEqualToString:@"1"]) {
        //普通用户，不需要传递
        bqNum=nil;
        jianjie=nil;
        jingLi=nil;
    }
        //演员
        [LCProgressHUD showLoading:@"请稍后..."];
        [Engine upDataMessageAccount:[ToolClass isString:[NSString stringWithFormat:@"%@",[NSUSE_DEFO objectForKey:@"username"]]] HeadImageUrl:_headImage Name:name Sex:xingBie PhoneNumber:lianXi Provname:sheng CityName:shi DistrictName:xian Category:bqNum Introduction:jianjie Experience:jingLi success:^(NSDictionary *dic) {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                NSDictionary * contentDic =[dic objectForKey:@"content"];
                MineModel * md =[[MineModel alloc]initWithMessageDic:[contentDic objectForKey:@"userInfo"]];
                _xmName=md.name;
                //存上姓名，在演艺圈点赞评论的时候用，有它来判断是否有个人资料
                [NSUSE_DEFO setObject:md.name forKey:@"benrenname"];
                [NSUSE_DEFO synchronize];
                [_tableView reloadData];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
        } error:^(NSError *error) {
            
        }];

    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self CeratData];
}

#pragma mark --创建数据源
-(void)CeratData{
    NSArray * arr1 =@[@"姓       名:",@"性       别:",@"联系方式:",@"地       区:"];
    NSArray * arr2=@[@"职业分类:"];
    NSArray * arr3=@[@""];
    NSArray * arr4=@[@""];
    if ([_model.usertype isEqualToString:@"1"]) {
        //普通用户
        _dataArray=@[arr1];
    }else{
        //演员
        _dataArray=@[arr1,arr2,arr3,arr4];
    }
    
}

#pragma mark --表头
-(UIView*)CreatHeadView{
    UIView * headView =[UIView new];
    headView.backgroundColor=COLOR;
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .heightIs(220);
    //背景图片
    UIImageView * bgimageView =[UIImageView new];
    bgimageView.userInteractionEnabled=YES;
    //[bgimageView sd_setImageWithURL:[NSURL URLWithString:_model.headImageStr] placeholderImage:[UIImage imageNamed:@"messege_bg"]];
    
    _bgImage=bgimageView;
    [headView sd_addSubviews:@[bgimageView]];
  
    [bgimageView sd_setImageWithURL:[NSURL URLWithString:_model.headImageStr] placeholderImage:[UIImage imageNamed:@"messege_bg"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //虚化背景图片
        [bgimageView setImageToBlur:image blurRadius:20 completionBlock:nil];
        bgimageView.sd_layout
        .leftSpaceToView(headView,0)
        .rightSpaceToView(headView,0)
        .topSpaceToView(headView,0)
        .heightIs(220);

       
    }];
    
    
    //头像
    UIButton * headBtn =[UIButton buttonWithType:UIButtonTypeCustom];
     headBtn.sd_cornerRadius=@(75/2);
   
    [headBtn addTarget:self action:@selector(headImageClick) forControlEvents:UIControlEventTouchUpInside];
    [headView sd_addSubviews:@[headBtn]];
    if (_headImage) {
        [headBtn setBackgroundImage:_headImage forState:0];
    }else{
        //http://img.bitscn.com/upimg/allimg/c160120/1453262R114060-155B6.jpg
        [headBtn sd_setImageWithURL:[NSURL URLWithString:_model.headImageStr] forState:0 placeholderImage:[UIImage imageNamed:@"messege_big"]];
    }
    [headView sd_addSubviews:@[headBtn]];
    headBtn.sd_layout
    .centerXEqualToView(headView)
    .centerYEqualToView(headView)
    .widthIs(75)
    .heightIs(75);
  
    
    return headView;
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

-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[UIView new];
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.tableHeaderView=[self CreatHeadView];
    [self.view addSubview:_tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return [_dataArray[section] count];
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMessageCell * cell =[MyMessageCell cellWithTableView:_tableView CellID:@"Cell"];
    cell.titleLabel.text=_dataArray[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        cell.textfield.hidden=NO;
        if (indexPath.row==0) {
            cell.textfield.tag=11;
            cell.textfield.delegate=self;
            cell.textfield.text=[self stringHouMianText:_xmName ModelText:_model.name];
           
        }
         else if (indexPath.row==1) {
            //性别
            cell.textfield.enabled=NO;
            cell.textfield.text=[self stringHouMianText:_xxName ModelText:_model.sex];
         }else if (indexPath.row==2){
            //联系方式
             cell.textfield.tag=12;
             cell.textfield.delegate=self;
             cell.textfield.text=[self stringHouMianText:_phoneName ModelText:_model.phonenum];
         }
         else if (indexPath.row==3) {
            //地区
            cell.textfield.enabled=NO;
            NSString * cityName =[NSString stringWithFormat:@"%@-%@-%@",_shengName,_shiName,_xianName];
            cell.textfield.text=[self stringHouMianText:cityName ModelText:_model.sheng];
            //cell.textfield.sd_layout.widthIs(250);
        }
        
    }else if (indexPath.section==1){
        cell.textfield.hidden=NO;
        cell.textfield.enabled=NO;
        //职业
         cell.textfield.text=[self stringHouMianText:_zhiYeName ModelText:_model.biaoQian];
    }else if (indexPath.section==2){
        //个人简介
        cell.textfield.hidden=YES;
        cell.textView.hidden=NO;
        cell.textView.tag=10;
        cell.textView.text=[self stringHouMianText:_jianJieName ModelText:_model.introduction];//@"请输入您的个人简介";
        cell.alpha=.6;
        cell.textView.delegate=self;
        
    }else{
        //演艺经历
        cell.textfield.hidden=YES;
        cell.textView.hidden=NO;
        cell.textView.tag=20;
        cell.textView.text=[self stringHouMianText:_jingLiName ModelText:_model.experience];
        cell.alpha=.6;
        cell.textView.delegate=self;
    }
    
    return cell;
}
#pragma mark --UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    if (textView.tag==10) {
        if ([textView.text isEqualToString:@"请输入您的个人简介"]) {
            textView.text=@"";
            textView.alpha=.8;
        }
    }else if (textView.tag==20){
        if ([textView.text isEqualToString:@"请输入您的演艺经历"]) {
            textView.text=@"";
            textView.alpha=.8;
        }
    }
   
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag==11) {
        _xmName=textField.text;
    }else if (textField.tag==12){
        _phoneName=textField.text;
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView{
   
    if (textView.tag==10) {
        //个人简介
        if ([textView.text isEqualToString:@""]) {
            textView.text=@"请输入您的个人简介";
            textView.alpha=.6;
        }else{
             _jianJieName=textView.text;
        }
        
        
    }else if (textView.tag==20){
        //演艺经历
        if ([textView.text isEqualToString:@""]) {
            textView.text=@"请输入您的演艺经历";
            textView.alpha=.6;
        }else{
            _jingLiName=textView.text;
        }
        
    }
}





#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            //性别
            XingBieVC * vc  =[XingBieVC new];
            vc.tagg=1;//1代表是从个人信息进入，2代表是从我的进入
            vc.XingBieBlock=^(NSString*name,NSString*num){
                _xxName=name;
                _xxYeNum=num;
                [_tableView reloadData];
            };
              [self.navigationController pushViewController:vc animated:YES];
        }
          else if (indexPath.row==3) {
            //地区
            CityViewController * vc =[CityViewController new];
            vc.CityNameBlock=^(NSString*shengname,NSString*cityname,NSString*xianname){
                _shengName=shengname;
                _shiName=cityname;
                _xianName=xianname;
                [_tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(indexPath.section==1){
        //职业
        ZhiYeClassVC * vc =[ZhiYeClassVC new];
        vc.classNameBlcok=^(NSString*num,NSString*name)
        {
            _zhiYeName=name;
            _zhiYeNum=num;
            [_tableView reloadData];
        };
         [self.navigationController pushViewController:vc animated:YES];
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView =[UIView new];
    bgView.backgroundColor=COLOR;
    UILabel * nameLable =[UILabel new];
    nameLable.font=[UIFont systemFontOfSize:15];
    nameLable.alpha=.7;
    [bgView sd_addSubviews:@[nameLable]];
    nameLable.sd_layout
    .leftSpaceToView(bgView,15)
    .centerYEqualToView(bgView)
    .heightIs(20);
    [nameLable setSingleLineAutoResizeWithMaxWidth:120];
    if (section==0) {
        nameLable.text=@"基本信息";
    }else if (section==1){
        nameLable.text=@"填写演员资料";
    }else if (section==2){
        nameLable.text=@"个人简介";
    }else if (section==3){
        nameLable.text=@"演艺经历";
    }
    
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2 || indexPath.section==3) {
        return 150;
    }else{
        return 50;
    }

}
#pragma mark --点击头像更换图片
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
    _headImage=image;
    _tableView.tableHeaderView=[self CreatHeadView];
    //虚化背景图片
    [_bgImage setImageToBlur:image blurRadius:20 completionBlock:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//text1是从后面界面传过来的，text2是从上个界面过来的_model
-(NSString *)stringHouMianText:(NSString*)text1 ModelText:(NSString*)text2{
    
    NSString * string;
    
    if ([text1 isEqualToString:@"(null)-(null)-(null)"]) {
        text1=nil;
    }
    if (text1) {
        string=text1;
    }else{
        string=text2;
    }
    
    return string;
}
#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=COLOR;
    self.title=@"编辑个人信息";
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

@end
