//
//  ImageCollectionViewCell.m
//  YonyouIM
//
//  Created by litfb on 15/2/4.
//  Copyright (c) 2015年 yonyou. All rights reserved.
//

#import "DFImageGroupCCell.h"
#import "DFImageManager.h"

@implementation DFImageGroupCCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(DFAssetModel *)model{
    _model = model;
    
    __weak typeof(self) weakSelf = self;
    [[DFImageManager manager] getThumbnailPhotoWithAsset:model.asset newCompletion:^(UIImage *photo) {
        weakSelf.imageView.image = photo;
    }];
    [self setSelected:model.isSelected];
    
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self.foregroundView setHidden:NO];
    } else {
        [self.foregroundView setHidden:YES];
    }
    [self.checkboxButton setSelected:selected];
}
- (IBAction)clickSelected:(id)sender {
    _model.isSelected = !_model.isSelected;
    [self setSelected:_model.isSelected];
    
    if (self.didSelectedPhoto) {
        self.didSelectedPhoto(_model.isSelected);
    }
    
}

@end
