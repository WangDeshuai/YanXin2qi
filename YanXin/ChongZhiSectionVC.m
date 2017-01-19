//
//  ChongZhiSectionVC.m
//  YanXin
//
//  Created by Macx on 17/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ChongZhiSectionVC.h"
#import "TanKuangView.h"
#import "VIPModel.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
@interface ChongZhiSectionVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UILabel * lastLab;
@property(nonatomic,strong)UIButton * lastBtn2;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)NSArray * btnArray;
@property(nonatomic,strong)NSArray * seleArray;
@property(nonatomic,strong)TanKuangView * tanKuangView;
@property(nonatomic,strong)NSMutableArray * vipArray;
@property(nonatomic,assign)NSInteger indexpath;//记录VIP几的
@property(nonatomic,assign)NSInteger indexRow;//记录点击的是第几行(0，支付宝；1，微信)
@end

@implementation ChongZhiSectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];
    self.view.backgroundColor=COLOR;
    _imageArray=@[@"chonghzi_zfb",@"chonghzi_wx"];
    _dataArray=@[@"支付宝支付",@"微信支付"];
    _btnArray=@[@"chonghzi_yuan",@"chonghzi_yuan"];
    _seleArray=@[@"chonghzi_yuan_xuan",@"chonghzi_yuan_xuan"];
    _vipArray=[NSMutableArray new];
    [self CreatTabelView];
    [self CteatButton];
  }

#pragma mark --获取网络数据接口
-(void)getShengJi{
    [Engine ShengJiVipMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --创建标头
-(UIView*)CreatView{
    UIView * headView =[UIView new];
    headView.backgroundColor=COLOR;
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(192+20);
    
    self.bgView=headView;
    UIView * view1 =[UIView new];
    view1.backgroundColor=[UIColor whiteColor];
    [_bgView sd_addSubviews:@[view1]];
    view1.sd_layout
    .leftSpaceToView(_bgView,0)
    .rightSpaceToView(_bgView,0)
    .topSpaceToView(_bgView,0)
    .heightIs(120);
    
    UILabel * namelabel =[UILabel new];
    namelabel.text=@"VIP会员升级";
    namelabel.textColor=JXColor(75, 157, 249, 1);
    namelabel.font=[UIFont systemFontOfSize:16];
    [view1 sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(view1,15)
    .topSpaceToView(view1,15)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:300];
    
    UIView * linView =[UIView new];
    linView.alpha=.1;
    linView.backgroundColor=[UIColor blackColor];
    [view1 sd_addSubviews:@[linView]];;
    linView.sd_layout
    .leftSpaceToView(view1,0)
    .rightSpaceToView(view1,0)
    .topSpaceToView(namelabel,15)
    .heightIs(.5);
    
    //3个按钮
    int d =(ScreenWidth-105*3)/4;

   

    UIView * view3 =[UIView new];
    view3.backgroundColor=JXColor(255, 244, 198, 1);
    [_bgView sd_addSubviews:@[view3]];
    view3.sd_layout
    .leftSpaceToView(_bgView,0)
    .rightSpaceToView(_bgView,0)
    .topSpaceToView(view1,0)
    .heightIs(50);
    //喇叭
    UIImageView * laba =[UIImageView new];
    laba.image=[UIImage imageNamed:@"chonghzi_laba"];//181 158
    [view3 sd_addSubviews:@[laba]];
    laba.sd_layout
    .centerYEqualToView(view3)
    .leftSpaceToView(view3,40)
    .widthIs(23)
    .heightIs(21);
    //联系客服字体
    UILabel * nameLabel2=[UILabel new];
    nameLabel2.text=@"充值有效时间2016-11-12至2017-11-12";
    nameLabel2.alpha=.7;
    nameLabel2.font=[UIFont systemFontOfSize:13];
    [view3 sd_addSubviews:@[nameLabel2]];
    nameLabel2.sd_layout
    .leftSpaceToView(laba,15)
    .rightSpaceToView(view3,10)
    .centerYEqualToView(view3)
    .heightIs(20);
    
   
  

    [Engine ShengJiVipMessagesuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            NSArray * userInfo =[contentDic objectForKey:@"upgradeInfo"];
             nameLabel2.text=[NSString stringWithFormat:@"充值有效时间%@至%@",[contentDic objectForKey:@"effectiveTime_begin"],[contentDic objectForKey:@"effectiveTime_end"]];//effectiveTime_begin
           
            for (int i =0; i<userInfo.count; i++) {
                VIPModel * md =[[VIPModel alloc]initWithShengJiVIPDic:userInfo[i]];
                 [_vipArray addObject:md];
                UILabel * button =[UILabel new];
                button.tag=i;
                button.numberOfLines=0;
                button.textAlignment=1;
                button.font=[UIFont systemFontOfSize:13];
                button.text=[NSString stringWithFormat:@"%@\r\r%@",md.shengJiPrice,md.shengJiMaoShu];
                button.layer.borderWidth=.5;
                button.layer.borderColor=[UIColor blackColor].CGColor;
                button.alpha=.6;
                if (i==0) {
                    button.layer.borderWidth=.5;
                    button.layer.borderColor=[UIColor greenColor].CGColor;
                    button.textColor=[UIColor greenColor];
                     button.alpha=1;
                    _lastLab=button;
                }
                
                
                [view1 sd_addSubviews:@[button]];
                button.sd_layout
                .leftSpaceToView(view1,d+(d+105)*i)
                .topSpaceToView(linView,15)
                .widthIs(105)
                .heightIs(67);
                [view1 setupAutoHeightWithBottomView:button bottomMargin:20];
                button.userInteractionEnabled=YES;
                 UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view1Click:)];
                tap.view.tag=i;
                [button addGestureRecognizer:tap];
            }
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    return headView;
    
    
}
-(void)view1Click:(UITapGestureRecognizer*)tapp{
   
    _lastLab.layer.borderWidth=.5;
    _lastLab.layer.borderColor=[UIColor blackColor].CGColor;
    _lastLab.textColor=[UIColor blackColor];
    _lastLab.alpha=.6;
    UILabel * nameLabel =[tapp.view viewWithTag:tapp.view.tag];
    nameLabel.alpha=1;
    if (tapp.view.tag==0) {
        nameLabel.layer.borderWidth=.5;
        nameLabel.layer.borderColor=[UIColor greenColor].CGColor;
        nameLabel.textColor=[UIColor greenColor];
    }else if (tapp.view.tag==1){
        nameLabel.layer.borderWidth=.5;
        nameLabel.layer.borderColor=JXColor(244, 15, 0, 1).CGColor;
        nameLabel.textColor=JXColor(244, 15, 0, 1);
    }else{
        nameLabel.layer.borderWidth=.5;
        nameLabel.layer.borderColor=JXColor(71, 153, 245, 1).CGColor;
        nameLabel.textColor=JXColor(71, 153, 245, 1);
    }
    _lastLab=nameLabel;
    
    _indexpath=tapp.view.tag;
}

-(void)CreatTabelView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight) style:UITableViewStylePlain];//-64-150
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableHeaderView=[self CreatView];
    _tableView.tableFooterView=[UIView new];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UIImageView * image1 =[UIImageView new];
        image1.tag=1;
        UILabel * nameLabel =[UILabel new];
        nameLabel.tag=2;
        UIButton * imageBtn =[UIButton new];
        imageBtn.tag=3;
        [cell sd_addSubviews:@[image1,nameLabel,imageBtn]];
        
    }
    
    UIImageView * image1=[cell viewWithTag:1];
    UILabel * namelable =[cell viewWithTag:2];
    UIButton * imageBtn =[cell viewWithTag:3];
    
    
    namelable.font=[UIFont systemFontOfSize:16];
    namelable.text=_dataArray[indexPath.row];
    namelable.alpha=.7;
    
    image1.image=[UIImage imageNamed:_imageArray[indexPath.row]];
    
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"chonghzi_yuan"] forState:0];
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"chonghzi_yuan_xuan"] forState:UIControlStateSelected];
    if (indexPath.row==0) {
        imageBtn.selected=YES;
        _lastBtn2=imageBtn;
    }
    
    image1.sd_layout
    .leftSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .widthIs(19)
    .heightIs(16);
    
    namelable.sd_layout
    .leftSpaceToView(image1,15)
    .centerYEqualToView(cell)
    .heightIs(20);
    [namelable setSingleLineAutoResizeWithMaxWidth:200];
    
    imageBtn.sd_layout
    .rightSpaceToView(cell,15)
    .centerYEqualToView(cell)
    .widthIs(20)
    .heightIs(20);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[_tableView cellForRowAtIndexPath:indexPath];
    UIButton * btn =[cell viewWithTag:3];
    _lastBtn2.selected=NO;
    btn.selected=YES;
    _lastBtn2=btn;
    _indexRow=indexPath.row;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view4 =[UIView new];
    view4.backgroundColor=COLOR;
    UILabel * nameLabel3=[UILabel new];
    nameLabel3.backgroundColor=[UIColor whiteColor];
    nameLabel3.text=@"    选择支付方式";
    nameLabel3.font=[UIFont systemFontOfSize:16];
    nameLabel3.textColor=JXColor(75, 157, 249, 1);
    [view4 sd_addSubviews:@[nameLabel3]];
    nameLabel3.sd_layout
    .leftSpaceToView(view4,0)
    .rightSpaceToView(view4,0)
    .topSpaceToView(view4,0)
    .bottomSpaceToView(view4,1);
    
    return view4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark --创建按钮
-(void)CteatButton{
    UITableViewCell * cell =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    CGRect rect =[self.view convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    int d =rect.origin.y +50+20;
    //
    UIImageView * imageView =[UIImageView new];
    imageView.image=[UIImage imageNamed:@"wenzi2"];
    imageView.frame=CGRectMake(cell.center.x-123, d, 246, 48);
    [_tableView addSubview:imageView];
    
    
    
    
    UIButton * payBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [payBtn setBackgroundImage:[UIImage imageNamed:@"chonghzi_btti"] forState:0];
    [payBtn addTarget:self action:@selector(payBtn) forControlEvents:UIControlEventTouchUpInside];
    payBtn.frame=CGRectMake(cell.center.x-305/2, imageView.frame.origin.y+imageView.frame.size.height+30, 305, 40);
    [_tableView addSubview:payBtn];
    
    
    
    
    
}

#pragma mark --充值按钮
-(void)payBtn{
//    ShengJiVIPZhiFuBaoDiJiVIPId
    
     VIPModel * md =_vipArray[_indexpath];
    if (_indexRow==0) {
        //支付宝支付
        [Engine ShengJiVIPZhiFuBaoDiJiVIPId:md.shengJiDID GaoJiID:md.shengJiGaoID Price:md.shengJiPrice Subject:md.shengJiMaoShu success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                //订单号是
                NSString * dingDanNum =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]]];
                [self zhifujiemian:dingDanNum biaotii:md.shengJiMaoShu jiage:@"0.01" miaoshu:md.shengJiMaoShu];
            }else
            {
                [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
            }
        } error:^(NSError *error) {
            
        }];
    }else{
        //微信支付
        [self WeiXinPayVipModel:md];
    }
    
    
//    _tanKuangView=[[TanKuangView alloc]initWithChongZhiTitle:@"         恭喜您即将成为中国演出网\r\r实名认证会员，通过审核后您即将获得唯一演信号。" ContentName:@"重要提示，邀请好友记得让他输入您的演信号，会有惊喜哦。" cacleBtn:@"我知道了!"];
//    [_tanKuangView show];
//    __weak __typeof(self)weakSelf = self;
//    
//    _tanKuangView.BtnClickBlock=^(UIButton*btn){
//        [weakSelf.tanKuangView dissmiss];
//    };
}

#pragma mark --支付宝支付
-(void)zhifujiemian:(NSString*)dingdan biaotii:(NSString*)bt jiage:(NSString*)jiage miaoshu:(NSString*)mshu
{
    NSString *partner = @"2088221733436902"; //PID
    
    NSString *seller = @"8014776@qq.com"; //收款账户，手机号或者邮箱
    NSString*privateKey= @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMaDpkazfuHj+Tk9piULoIAVSkLh6b+Xi9QzwWYJZeLAjd4rDkFtVvOvljvRYLksxH/U8X1t/5BoJxtvFij6kG2tMX2gEbPZbbuTT8VjAoK1N6jZkOOtdPUeVgR763NheR0ao50uR6F0alGCI2fsRhKmwHA/udNDf1kdNuMhML8pAgMBAAECgYEAtIiroibBYIukbrMrMwuU5ob2J0cu/kfDKbP70WEAoKv/GSpM56GZbzqjRTlQXndhKOQuzqRHxDuEPUXUgGYHC6y1+3WcSEQbzphWp5Km4u/vmVud0UYRLh1o5t+d961y/GkzJcgqrn2PrcmMNukH2+Tr4wax+RFz66sdR+KBqIECQQDvEI9hAuVJjsfPI7QPZ8sttVY9BeUAex2D2Ow5VAwUPBB9IPo2t0R0COZZZTJl0CHGkjM46X1W9DaS9PZ5cQlxAkEA1JO1AWsI2uzpuTJegZmaFzDYYH2XAsRU2Y9K3UJQUgiMndsWnWEYg1QX4dvbaiBF25cHgoVOvZRaGl8M5oV1OQJAdhnAOzSrAQPAQdxpf5LPFO2YhNz8nJg1pITtbgTPUs+5dZdtBMrUzl33LgKIOzPu+6IOG/d9LA/JRiAuAyCMgQJBAL3H5MgQU8aHzh3dvwu7IxtjKznxxbjdqNbWm8KvKmAia8+eQjFc9vKASBYHH3s+tr9VtYmsE+EiqdJzW2QOb9kCQGNWNCotHBsyClfS+dRi5OFF+dEymHIyTjpwNJZFcrFW2MiujlBJQhyPUCKZNntAewL7AsapAX67DTMq4OLQNqs=";// 私钥
    
    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = dingdan;//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.subject = bt; //商品标题
    order.body = mshu; //商品描述
    order.totalFee = jiage;//@"0.01"; //商品价格
    order.notifyURL = @"http://119.29.83.154:8080/YanXinManage/charge/app_alipayCallBack.action"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    NSString *appScheme = @"yanxinHuiDiao";
    
    //将商品信息拼接成字符串   该方法支付宝已经封好
    NSString *orderSpec = [order description];
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    //调用签名
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        
        //上面提到好的后台，会把订单字符串直接传给我们，而我们要做的其实也就只剩下这一步了
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"走没走%@",resultDic);
            NSLog(@">>>%@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                //9000为支付成功
                NSLog(@"9000支付成功");
            }
        }];
    }
    
}

#pragma mark --微信支付
-(void)WeiXinPayVipModel:(VIPModel*)md {
    [Engine ShengJiWeiXinVIPDiJiID:md.shengJiDID GaoJiID:md.shengJiGaoID Price:[NSString stringWithFormat:@"%d",[md.shengJiPrice intValue]*100] Body:md.shengJiMaoShu success:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            VIPModel * md =[[VIPModel alloc]initWithWeiXinModelDic:contentDic];
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = md.weiXinPartnerid;
            request.prepayId=  md.weiXinPrepayid;
            request.package = md.weiPackage;
            request.nonceStr=  md.weiNoncestr;
            request.timeStamp= md.weiXinTimestamp.intValue;
            request.sign= md.weiXinSign;
            [WXApi sendReq:request];
        }
    } error:^(NSError *error) {
        
    }];
    
    
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
#pragma mark --导航条创建
-(void)daohangTiao{
    self.navigationController.navigationBar.barTintColor=JXColor(75, 157, 249, 1);
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"充值";
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
