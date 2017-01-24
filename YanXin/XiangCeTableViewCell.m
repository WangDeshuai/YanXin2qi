//
//  XiangCeTableViewCell.m
//  YanXin
//
//  Created by Macx on 17/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "XiangCeTableViewCell.h"
#import "AddImageCCell.h"
#import "QTCollectionReusableView.h"

static NSString *headerViewIdentifier = @"hederview";
@interface XiangCeTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;


@end
@implementation XiangCeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView CellID:(NSString*)cellID{
    XiangCeTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[XiangCeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
    }
    return self;
}

-(void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr=dataArr;

    NSLog(@"调用几次%lu",dataArr.count);
    [self CreatCollectionView];
    
    
  
}
#pragma mark --创建瀑布流
-(void)CreatCollectionView{
   
    UICollectionViewFlowLayout * flowLawyou =[UICollectionViewFlowLayout new];
    int d =(ScreenWidth-(10*4))/3;
    //item大小
    flowLawyou.itemSize = CGSizeMake(d, d);
    //行间距
    flowLawyou.minimumLineSpacing=5;//行间距
    flowLawyou.minimumInteritemSpacing=10;//列间距
    flowLawyou.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLawyou.headerReferenceSize=CGSizeMake(ScreenWidth, 44); //设置collectionView头视图的大小
    //集合 表（视图）继承与 UIScrollView
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHight-170-44-44-34) collectionViewLayout:flowLawyou];
    _collectionView.pagingEnabled = NO;
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    //默认是黑色的，需要设置才能显示
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    
    [_collectionView registerClass:[AddImageCCell class] forCellWithReuseIdentifier:@"cell"];
    //注册头视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataArr[section] count];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddImageCCell * cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
 
    if (indexPath.section==0) {
        NSMutableArray * imageArr=_dataArr[0];
        NSString * urlimage =imageArr[indexPath.row];
        NSLog(@"urlStr=%@",urlimage);
        if ([urlimage isEqualToString:@""]) {
            
        }else{
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlimage] placeholderImage:[UIImage imageNamed:@""]]; 
        }
       
        
        
    }else{
       
        NSMutableArray * imageArr=_dataArr[1];
        NSString * urlimage =imageArr[indexPath.row];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlimage] placeholderImage:[UIImage imageNamed:@"video_bg"]];
    }
    
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.IndePathBlock(indexPath);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
        //头视图添加view
        [header addSubview:[self addContentIndex:indexPath]];
        return header;
    }
    
    return nil;
}

-(UIView*)addContentIndex:(NSIndexPath*)indexpath
{
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, ScreenWidth, 44);
    bgView.backgroundColor=[UIColor whiteColor];
    
    UIImageView * imageView =[UIImageView new];
    //181 158
    [bgView sd_addSubviews:@[imageView]];
    imageView.sd_layout
    .centerYEqualToView(bgView)
    .leftSpaceToView(bgView,15)
    .widthIs(16)
    .heightIs(13);
    
    
    UILabel * nameLabel =[UILabel new];
    nameLabel.font=[UIFont systemFontOfSize:13];
    nameLabel.alpha=.5;
    [bgView sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(imageView,10)
    .centerYEqualToView(bgView)
    .heightIs(20);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:220];
    
    UIButton * moreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"yanyuan_more"] forState:0];
    moreBtn.tag=indexpath.section;
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView sd_addSubviews:@[moreBtn]];
    
    moreBtn.sd_layout
    .rightSpaceToView(bgView,15)
    .centerYEqualToView(bgView)
    .widthIs(61)
    .heightIs(12);
    
    if (indexpath.section==0) {
        imageView.image=[UIImage imageNamed:@"messege_photo"];
        nameLabel.text=@"案例图片";
    }else{
        imageView.image=[UIImage imageNamed:@"messege_shipin"];
        nameLabel.text=@"案例视频";
    }
    
    return bgView;
}
#pragma mark --查看更多
-(void)moreBtnClick:(UIButton*)btn{
    self.moreBtnBlock(btn);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
