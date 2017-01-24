//
//  ChongZhiVC.m
//  YanXin
//
//  Created by Macx on 17/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ChongZhiVC.h"
#import "VIPModel.h"
#import "TanKuangView.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
@interface ChongZhiVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UIButton * lastBtn;
@property(nonatomic,strong)UIButton * lastBtn2;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray * imageArray;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)NSArray * btnArray;
@property(nonatomic,strong)NSArray * seleArray;
@property(nonatomic,strong) UITextField * yanXinText;
@property(nonatomic,strong)NSMutableArray * vipArray;//存放VIP数据的
@property(nonatomic,assign)NSInteger indexpath;//记录VIP几的
@property(nonatomic,assign)NSInteger indexRow;//记录点击的是第几行(0，支付宝；1，微信)
@end

@implementation ChongZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangTiao];//创建导航条
    
    self.view.backgroundColor=COLOR;
    _imageArray=@[@"chonghzi_zfb",@"chonghzi_wx"];
    _dataArray=@[@"支付宝支付",@"微信支付"];
    _btnArray=@[@"chonghzi_yuan",@"chonghzi_yuan"];
    _seleArray=@[@"chonghzi_yuan_xuan",@"chonghzi_yuan_xuan"];
    _vipArray=[NSMutableArray new];
    [self CreatTabelView];
    [self CteatButton];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"safepay" object:nil];
    
    [center addObserver:self selector:@selector(weiXin) name:@"WX_PaySuccess" object:nil];
    
    
}
#pragma mark --支付宝返回的结果
-(void)notice:(NSNotification*)sender{
    NSString * str =[NSString stringWithFormat:@"%@",[sender.userInfo objectForKey:@"resultStatus"]];
    NSLog(@"是促成结果%@",str);
    if ([str isEqualToString:@"9000"]) {
        TanKuangView*tanKuangView=[[TanKuangView alloc]initWithChongZhiTitle:@"         恭喜您即将成为中国演出网\r\r实名认证会员，通过审核后您即将获得唯一演信号。" ContentName:@"重要提示，邀请好友记得让他输入您的演信号，会有惊喜哦。" cacleBtn:@"我知道了!"];
        [tanKuangView show];
        __weak __typeof(tanKuangView)weakSelf = tanKuangView;
        
        tanKuangView.BtnClickBlock=^(UIButton*btn){
            [weakSelf dissmiss];
            UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请您退出重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"好" style:0 handler:^(UIAlertAction * _Nonnull action) {
                [NSUSE_DEFO removeObjectForKey:@"username"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            
            [actionView addAction:action1];
            [self presentViewController:actionView animated:YES completion:nil];
            
        };
        

    }else{
        [LCProgressHUD showMessage:@"充值失败"];
    }
    
}
#pragma mark --微信返回的结果
-(void)weiXin{
    TanKuangView*tanKuangView=[[TanKuangView alloc]initWithChongZhiTitle:@"         恭喜您即将成为中国演出网\r\r实名认证会员，通过审核后您即将获得唯一演信号。" ContentName:@"重要提示，邀请好友记得让他输入您的演信号，会有惊喜哦。" cacleBtn:@"我知道了!"];
    [tanKuangView show];
    __weak __typeof(tanKuangView)weakSelf = tanKuangView;
    
    tanKuangView.BtnClickBlock=^(UIButton*btn){
        [weakSelf dissmiss];
        UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请您退出重新登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"好" style:0 handler:^(UIAlertAction * _Nonnull action) {
            [NSUSE_DEFO removeObjectForKey:@"username"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        [actionView addAction:action1];
        [self presentViewController:actionView animated:YES completion:nil];
        
    };
    

}


#pragma mark --创建标头
-(UIView*)CreatView{
    UIView * headView =[UIView new];
    headView.backgroundColor=COLOR;
    headView.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(316-64);
    
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
    namelabel.text=@"选择VIP会员级别";
    namelabel.textColor=JXColor(75, 157, 249, 1);
    namelabel.font=[UIFont systemFontOfSize:16];
    [view1 sd_addSubviews:@[namelabel]];
    namelabel.sd_layout
    .leftSpaceToView(view1,15)
    .topSpaceToView(view1,15)
    .heightIs(20);
    [namelabel setSingleLineAutoResizeWithMaxWidth:300];
    //3个按钮
    int d =(ScreenWidth-105*3)/4;
   
    
//    for (int i=0; i<3; i++) {
//        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
//        [button setBackgroundImage:[UIImage imageNamed:imageA[i]] forState:0];
//         [button setBackgroundImage:[UIImage imageNamed:sImageA[i]] forState:UIControlStateSelected];
//        if (i==0) {
//            button.selected=YES;
//            _lastBtn=button;
//            
//        }
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [view1 sd_addSubviews:@[button]];
//        button.sd_layout
//        .leftSpaceToView(view1,d+(d+105)*i)
//        .topSpaceToView(namelabel,30)
//        .widthIs(105)
//        .heightIs(67);
//        [view1 setupAutoHeightWithBottomView:button bottomMargin:20];
//    }
    NSArray * imageA =@[@"vipseleate",@"chonghzi_bt2",@"chonghzi_bt3"];
    NSArray * sImageA =@[@"vipseleate1",@"chonghzi_bt22",@"chonghzi_bt33"];
    
    [Engine ChaXunVIPdengjisuccess:^(NSDictionary *dic) {
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSArray * contentArr =[dic objectForKey:@"content"];
            for (int i =0  ;i<contentArr.count;i++) {
                NSDictionary * dicc = contentArr[i];
                VIPModel * md =[[VIPModel alloc]initWithVIPModelDic:dicc];
                [_vipArray addObject:md];
                UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
                [button setBackgroundImage:[UIImage imageNamed:imageA[i]] forState:0];
                [button setBackgroundImage:[UIImage imageNamed:sImageA[i]] forState:UIControlStateSelected];
                button.tag=i;
                [button setTitleColor:JXColor(51, 51, 51, 1) forState:0];
                button.titleEdgeInsets=UIEdgeInsetsMake(25, 10, 50, 10);
                [button setTitle:md.vipPrice forState:0];
                if (i==0) {
                    button.selected=YES;
                    _lastBtn=button;
                }
                [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [view1 sd_addSubviews:@[button]];
                button.sd_layout
                .leftSpaceToView(view1,d+(d+105)*i)
                .topSpaceToView(namelabel,30)
                .widthIs(105)
                .heightIs(67);
                [view1 setupAutoHeightWithBottomView:button bottomMargin:20];
            }
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
    
    
    
    
    UIView * view2 =[UIView new];
    view2.backgroundColor=[UIColor whiteColor];
    [_bgView sd_addSubviews:@[view2]];
    view2.sd_layout
    .leftSpaceToView(_bgView,0)
    .rightSpaceToView(_bgView,0)
    .topSpaceToView(view1,5)
    .heightIs(120);
    
    UILabel * yanxin =[UILabel new];
    yanxin.text=@"演信号";
    yanxin.alpha=.7;
    yanxin.font=[UIFont systemFontOfSize:16];
    [view2 sd_addSubviews:@[yanxin]];
    yanxin.sd_layout
    .leftSpaceToView(view2,15)
    .topSpaceToView(view2,15)
    .heightIs(20);
    [yanxin setSingleLineAutoResizeWithMaxWidth:300];
    _yanXinText =[UITextField new];
    _yanXinText.placeholder=@"请输入邀请人的演信号";
    _yanXinText.keyboardType=UIKeyboardTypeNumberPad;
    _yanXinText.font=[UIFont systemFontOfSize:16];
    [view2 sd_addSubviews:@[_yanXinText]];
    _yanXinText.sd_layout
    .leftSpaceToView(yanxin,15)
    .rightSpaceToView(view2,15)
    .centerYEqualToView(yanxin)
    .heightIs(30);
    
    [view2 setupAutoHeightWithBottomView:yanxin bottomMargin:15];
    
    
    UIView * view3 =[UIView new];
    view3.backgroundColor=JXColor(255, 244, 198, 1);
    [_bgView sd_addSubviews:@[view3]];
    view3.sd_layout
    .leftSpaceToView(_bgView,0)
    .rightSpaceToView(_bgView,0)
    .topSpaceToView(view2,0)
    .heightIs(40);
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
    nameLabel2.text=@"如果您没有邀请人点击【联系客服】获取演信号~";
    nameLabel2.alpha=.7;
    nameLabel2.font=[UIFont systemFontOfSize:13];
    nameLabel2.attributedText=[ToolClass attrStrFrom: nameLabel2.text intFond:13 Color:JXColor(75, 157, 249, 1) numberStr:@"【联系客服】"];
    [view3 sd_addSubviews:@[nameLabel2]];
    nameLabel2.sd_layout
    .leftSpaceToView(laba,15)
    .rightSpaceToView(view3,10)
    .centerYEqualToView(view3)
    .heightIs(20);
    nameLabel2.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapp)];
    [nameLabel2 addGestureRecognizer:tap];
    
    
//    view3.didFinishAutoLayoutBlock=^(CGRect rect){
//        NSLog(@"我是%f", rect.size.height+rect.origin.y);
//       
//    };
    
    
    
    return headView;
    
    
}
-(void)tapp{
    UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否拨打客服电话18519186222" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"是" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [ToolClass tellPhone:@"18519186222"];
    }];
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"否" style:0 handler:nil];
    [actionView addAction:action2];
    [actionView addAction:action1];
    [self presentViewController:actionView animated:YES completion:nil];

}
-(void)buttonClick:(UIButton*)btn{
    _lastBtn.selected=NO;
    btn.selected=YES;
    _lastBtn=btn;
    _indexpath=btn.tag;
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
    VIPModel * md =_vipArray[_indexpath];
    NSLog(@"输出%@",md.vipPrice);
    NSString * yanXinNumber =_yanXinText.text;
    if (_indexRow==0) {
        //支付宝支付(这个网络请求主要是为了获取订单号)
        [Engine getDingDanNumberAccount:[NSUSE_DEFO objectForKey:@"username"] VipID:md.vipID YanXinNum:yanXinNumber Subject:[NSString stringWithFormat:@"充值vip%@",md.vipDengJi] success:^(NSDictionary *dic) {
            NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            if ([code isEqualToString:@"1"]) {
                //订单号是
                NSString * dingDanNum =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]]];
                [self zhifujiemian:dingDanNum biaotii:md.vipDengJi jiage:md.vipPrice miaoshu:md.vipMiaoShu];
                
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
-(void)WeiXinPayVipModel:(VIPModel*)model {
    [Engine weiXinPayAccount:[NSUSE_DEFO objectForKey:@"username"] YanXinNum:_yanXinText.text VIPID:model.vipID Price:[NSString stringWithFormat:@"%d",[model.vipPrice intValue]*100] Body:[NSString stringWithFormat:@"充值vip%@",model.vipDengJi] success:^(NSDictionary *dic) {
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
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        
    } error:^(NSError *error) {
        
    }];
}

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
