//
//  DFAlbumController.m
//  Technology
//
//  Created by user on 27/12/16.
//  Copyright © 2016年 DFF. All rights reserved.
//

#import "DFAlbumController.h"
#import "DFImageManager.h"
#import "DFImageGroupViewController.h"

@interface DFAlbumController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *albumArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DFAlbumController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"相册";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)]];
    
    [self initTableView];
}


-(void) initTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    UIView *footView = [[UIView alloc] init];
    [tableView setTableFooterView:footView];
}

- (void)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_albumArray) {
        [[DFImageManager manager] getAllAlbums:YES allowPickingImage:YES completion:^(NSArray<DFAlbumModel *> *models) {
            _albumArray = models;
            [_tableView reloadData];
        }];
        return;
    }
    [_tableView reloadData];
}



#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.albumArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    DFAlbumModel *model = self.albumArray[indexPath.row];
    [[DFImageManager manager] getPostImageWithAlbumModel:model completion:^(UIImage *photo) {
        cell.imageView.image = photo;
    }];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%ld)" ,model.name, model.count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    DFImageGroupViewController *vc = [[DFImageGroupViewController alloc] init];
    vc.albumModel = self.albumArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
