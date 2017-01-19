//
//  CreatYanYuanZiLiaoVC.m
//  YanXin
//
//  Created by Macx on 17/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "CreatYanYuanZiLiaoVC.h"
#import "ShiMingRenZhengVC.h"//实名认证
#import "DFThemeNav.h"//上传图片
#import "DFBrowserController.h"//上传图片
#import "UpDownVidioVC.h"//上传视频
#import "ZhiYeClassVC.h"//选择职业
@interface CreatYanYuanZiLiaoVC ()<UITableViewDelegate,UITableViewDataSource,DFAssetDelegate,DFPhotoBrowserDelegate,DFPresentedProtocol>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@property (nonatomic, strong) NSArray *photoArray;
@property (nonatomic, strong) DFBrowserAnimator *borwserAnimator;
//存放图片的按钮用来取消
@property(nonatomic,strong)NSMutableArray * buttonArray;
//存放视频按钮的数组，用来删除
@property(nonatomic,strong)NSMutableArray * buttonVivoArray;
//记录职业分类的
@property(nonatomic,copy)NSString * zhiYeName;
@property(nonatomic,copy)NSString * zhiYeNum;
///记录视频的
@property(nonatomic,strong)NSMutableArray * viodoArr;
//记录图片
@property (nonatomic, strong) NSMutableArray *zhaoPianArr;

@end

@implementation CreatYanYuanZiLiaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    self.borwserAnimator = [[DFBrowserAnimator alloc] init];
    [self CreatArray];
    [self CreatTabelView];
}

-(void)CreatArray{
    NSArray * arr1 =@[@"职业分类"];
    NSArray * arr2 =@[@""];
    NSArray * arr3 =@[@""];
    NSArray * arr4 =@[@""];
    NSArray * arr5 =@[@""];
    _dataArray=@[arr1,arr2,arr3,arr4,arr5];
    _buttonArray=[NSMutableArray new];
    _viodoArr=[NSMutableArray new];
    _zhaoPianArr=[NSMutableArray new];
    _buttonVivoArray=[NSMutableArray new];
}

-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]init];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[UIView new];
    _tableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view sd_addSubviews:@[_tableView]];
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,80)
    .topSpaceToView(self.view,0);
    
    //创建下一步
    UIButton * nextBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.backgroundColor=DAO_COLOR;
    nextBtn.sd_cornerRadius=@(3);
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"renzheng_bt1"] forState:0];
    [nextBtn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[nextBtn]];
    nextBtn.sd_layout
    .centerXEqualToView(self.view)
    .widthIs(305)
    .heightIs(40)
    .bottomSpaceToView(self.view,20);
    
    
}
#pragma mark --下一步按钮
-(void)nextBtn{
    /*
    1.需要把图片上传返回地址(图片上传需要转换成json字符串)
    2.把得到的地址，转化为json字符串，给了上传演员资料接口
    3.把视频数组转换为json字符串（视频需要判断，是不是空的）
    */
    [self photoJsonStr];
    
}
#pragma mark --视频转换字符串
-(NSString*)shiPinIntenextData{
    NSString * jsonVivo =nil;
    if (_viodoArr.count==0) {
        jsonVivo=nil;
    }else{
        
        NSMutableArray * shangChuanVidio =[NSMutableArray new];
        for (int i =0; i<_viodoArr.count; i++) {
            NSString * imageName =[NSString stringWithFormat:@"video%d",i];
            NSMutableDictionary * imageDic =[NSMutableDictionary new];
            [imageDic setObject:imageName forKey:@"video_name"];
            [imageDic setObject:_viodoArr[i] forKey:@"video_url"];
            [shangChuanVidio addObject:imageDic];
        }
      jsonVivo=[ToolClass getJsonStringFromObject:shangChuanVidio];
        
    }
    
    return jsonVivo;
}

#pragma mark --图片转换字符串
-(void)photoJsonStr{
    if (_zhaoPianArr.count==0) {
        [LCProgressHUD showMessage:@"照片是必填项"];
    }else{
        NSMutableArray * arrzhao =[NSMutableArray new];
        for (int i =0; i<_zhaoPianArr.count; i++ ) {
            UIImage * image =_zhaoPianArr[i];
            NSData * imgData=  UIImageJPEGRepresentation(image, 0);
            NSString * endStr =[imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            [arrzhao addObject:endStr];
        }
        //上传照片获取地址
        [Engine ShangChuanImageArrStr:[ToolClass getJsonStringFromObject:arrzhao] success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                //图片地址数组
                NSArray * contentArr =[dic objectForKey:@"content"];
                NSMutableArray * shangChuanPhoto =[NSMutableArray new];
                for (int i=0; i<contentArr.count; i++) {
                    NSString * imageName =[NSString stringWithFormat:@"img%d",i];
                    NSMutableDictionary * imageDic =[NSMutableDictionary new];
                    [imageDic setObject:imageName forKey:@"img_name"];
                    [imageDic setObject:contentArr[i] forKey:@"url"];
                    [shangChuanPhoto addObject:imageDic];
                }
                
                NSLog(@"输出图片格式%@",[ToolClass getJsonStringFromObject:shangChuanPhoto]);
                NSLog(@"输出视频格式%@",[self shiPinIntenextData]);
                [self commontMessagePhoto:[ToolClass getJsonStringFromObject:shangChuanPhoto] VivoStr:[self shiPinIntenextData]];
            }else
            {
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
        } error:^(NSError *error) {
            
        }];
        
    }
    
    
   
    
    
    /*
     
     
     */
    
    
    
    
   
    
}
#pragma mark --提交资料
-(void)commontMessagePhoto:(NSString*)photnStr VivoStr:(NSString*)vivostr{
    UITableViewCell * cell1 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    UITableViewCell * cell2 =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    UITextView * textfield1 =[cell1 viewWithTag:20];
    UITextView * textfield2 =[cell2 viewWithTag:20];
    NSLog(@"个人简介%@",textfield1.text);
    NSLog(@"演艺经历%@",textfield2.text);
    NSLog(@"职业%@",[ToolClass isString:_zhiYeNum]);
    ;
    NSLog(@"图片%@",_zhaoPianArr);
    NSLog(@"视频%@",_viodoArr);

     [LCProgressHUD showMessage:@"正在提交..."];
    [Engine appShengJiYanYuanFenLeiNum:[ToolClass isString:_zhiYeNum] JianJie:textfield1.text JingLi:textfield2.text Images:photnStr ShiPin:vivostr success:^(NSDictionary *dic) {
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                ShiMingRenZhengVC * vc =[ShiMingRenZhengVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }else
            {
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
                }
        } error:^(NSError *error) {

    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel * nameLabel =[UILabel new];
        nameLabel.tag=10;
        [cell sd_addSubviews:@[nameLabel]];
        UITextView * textfield =[UITextView new];
        textfield.tag=20;
        [cell sd_addSubviews:@[textfield]];
        UIButton * imageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        imageBtn.tag=30;
        [cell sd_addSubviews:@[imageBtn]];
        
        UITextField * textfil =[UITextField new];
        textfil.tag=40;
        [cell sd_addSubviews:@[textfil]];
      
    }
    UILabel * nameLabel =[cell viewWithTag:10];
    nameLabel.font=[UIFont systemFontOfSize:15];
    nameLabel.alpha=.7;
    nameLabel.text=_dataArray[indexPath.section][indexPath.row];
    nameLabel.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    //输入框
    UITextView * textfield =[cell viewWithTag:20];
    textfield.hidden=YES;
    textfield.font=[UIFont systemFontOfSize:15];
    textfield.alpha=.8;
    textfield.sd_layout
    .leftSpaceToView(cell,15)
    .rightSpaceToView(cell,15)
    .topSpaceToView(cell,5)
    .bottomSpaceToView(cell,5);
    
    //按钮
    UIButton * imageBtn =[cell viewWithTag:30];
    imageBtn.hidden=YES;
    imageBtn.sd_layout
    .leftSpaceToView(cell,20)
    .centerYEqualToView(cell)
    .widthIs(72)
    .heightIs(72);
    
    UITextField * textfil =[cell viewWithTag:40];
    
    if (indexPath.section==0) {
        //职业分类
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        textfield.hidden=YES;
        textfil.font=[UIFont systemFontOfSize:15];
        textfil.alpha=.7;
        textfil.sd_layout.rightSpaceToView(cell,30)
        .widthIs(70).heightIs(30).centerYEqualToView(cell);
        textfil.textAlignment=2;
        
        textfil.text=_zhiYeName;
    }else if (indexPath.section==1){
        textfield.hidden=NO;//个人简介
    }else if (indexPath.section==2){
        textfield.hidden=NO;//演艺经历
    }
    else if (indexPath.section==3){
        //上传图片
        [self remButton];//移除按钮
        imageBtn.hidden=NO;
        [self tableviewCell:cell Button:imageBtn];
       
    }
else{
        //上传视频
    imageBtn.hidden=NO;
     [self remVivoButton];
     [self tableviewVidoCell:cell  Button:imageBtn];
    }
    
    return cell;
}
#pragma mark --移除图片按钮
-(void)remButton{
    for (UIButton * btn in _buttonArray) {
        [btn removeFromSuperview];
    }
    
}
#pragma mark --移除视频按钮
-(void)remVivoButton{
    for (UIButton * btn in _buttonVivoArray) {
        [btn removeFromSuperview];
    }
    
}

#pragma mark --上传图片显示cell
-(void)tableviewCell:(UITableViewCell*)cell Button:(UIButton*)imageBtn{
    if (self.photoArray.count==0) {
        [imageBtn setBackgroundImage:[UIImage imageNamed:@"messenge_pic"] forState:0];
        [imageBtn addTarget:self action:@selector(imageUpdata) forControlEvents:UIControlEventTouchUpInside];
    }else{
       
        for (int i =0; i<self.photoArray.count; i++) {
            UIButton * imageview =[UIButton new];
            imageview.tag=i;
            
            [_buttonArray addObject:imageview];
            [imageview addTarget:self action:@selector(imageviewClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell sd_addSubviews:@[imageview]];
            imageview.sd_layout
            .leftSpaceToView(cell,15+(15+72)*i)
            .centerYEqualToView(cell)
            .widthIs(72)
            .heightIs(72);
            DFAssetModel *model = self.photoArray[i];
            [[DFImageManager manager] getThumbnailPhotoWithAsset:model.asset newCompletion:^(UIImage *photo) {
                NSLog(@"执行几次%d",i);
                [imageview setBackgroundImage:photo forState:0];
                [_zhaoPianArr addObject:photo];
            }];
            
            //上传图片按钮重新布局
            if (i==0) {
                imageBtn.sd_layout
                .leftSpaceToView(imageview,25)
                .centerYEqualToView(cell)
                .widthIs(72)
                .heightIs(72);
            }else if (i==1){
                imageBtn.sd_layout
                .leftSpaceToView(imageview,35+72)
                .centerYEqualToView(cell)
                .widthIs(72)
                .heightIs(72);
            }
            else{
                imageBtn.hidden=YES;
            }
        }
        
    }
}

#pragma mark --上传视频显示的Cell
-(void)tableviewVidoCell:(UITableViewCell*)cell Button:(UIButton*)imageBtn{
    if (self.viodoArr.count==0) {
        [imageBtn setBackgroundImage:[UIImage imageNamed:@"messege_vedio"] forState:0];
        [imageBtn addTarget:self action:@selector(vidioUpData) forControlEvents:UIControlEventTouchUpInside];
    }else{
        for (int i =0; i<self.viodoArr.count; i++) {
            UIButton * imageview =[UIButton new];
            imageview.tag=i;
            [_buttonVivoArray addObject:imageview];
            [imageview addTarget:self action:@selector(imageviewClick:) forControlEvents:UIControlEventTouchUpInside];
             [imageview setBackgroundImage:[UIImage imageNamed:@"video_bg"] forState:0];
            [cell sd_addSubviews:@[imageview]];
            imageview.sd_layout
            .leftSpaceToView(cell,15+(15+72)*i)
            .centerYEqualToView(cell)
            .widthIs(72)
            .heightIs(72);
            
            //上传图片按钮重新布局
            if (i==0) {
                imageBtn.sd_layout
                .leftSpaceToView(imageview,25)
                .centerYEqualToView(cell)
                .widthIs(72)
                .heightIs(72);
            }else if (i==1){
                imageBtn.sd_layout
                .leftSpaceToView(imageview,35+72)
                .centerYEqualToView(cell)
                .widthIs(72)
                .heightIs(72);
            }
            else{
                imageBtn.hidden=YES;
            }
        }
        
   
    }
    
}




#pragma mark --表的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //表的点击
        ZhiYeClassVC * vc =[ZhiYeClassVC new];
        vc.classNameBlcok=^(NSString*num,NSString*classname){
            _zhiYeNum=num;
            _zhiYeName=classname;
            [_tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark --图片展开
-(void)imageviewClick:(UIButton*)btn{
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 50;
    }else{
        return 100;
    }
}

#pragma mark --区头
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
    if (section==1) {
        nameLable.text=@"个人简介";
    }else if (section==2){
        nameLable.text=@"演艺经历";
    }else if (section==3){
        nameLable.text=@"上传图片";
    }else if (section==4){
        nameLable.text=@"上传视频";
    }
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else{
      return 50;
    }
}

#pragma mark --上传图片按钮
-(void)imageUpdata{
    DFThemeNav *nav = [[DFThemeNav alloc] initWithDelegate:self pushPhotoPickerVC:YES];
    nav.selectedAssetArray = [NSMutableArray arrayWithArray:self.photoArray];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark --上传视频按钮
-(void)vidioUpData{
    UpDownVidioVC * vc =[UpDownVidioVC new];
    vc.imageArrBlock=^(NSMutableArray*array){
        _viodoArr=array;
        [_tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (DFAssetModel *)photoBrowser:(DFPreviewController *)browser placeholderImageForIndex:(NSInteger)index{
    return self.photoArray[index];
}
- (void)didSelectAssets:(NSArray *)assets{
    self.photoArray = assets;
    
   [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=DAO_COLOR;
    self.view.backgroundColor=COLOR;
    self.title=@"填写演员资料";
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
