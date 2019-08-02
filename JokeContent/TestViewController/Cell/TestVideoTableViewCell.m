//
//  TestVideoTableViewCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/8/2.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "TestVideoTableViewCell.h"
#import <HXPhotoPicker/HXPhotoPicker.h>

@interface TestVideoTableViewCell()<HXPhotoViewDelegate>

@property(nonatomic,strong) UILabel * titleLabel;

@property (strong, nonatomic) HXPhotoManager *manager;

@property (weak, nonatomic) HXPhotoView *photoView;

@end

@implementation TestVideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setInitUI];
    }
    return self;
}

- (void)setInitUI{
    self.contentView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.photoView];
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView, zn_AutoWidth(10))
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .heightIs(zn_AutoWidth(20));
    
    self.photoView.sd_layout
    .topSpaceToView(self.titleLabel, zn_AutoWidth(10))
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .heightIs(0);
}

#pragma mark - set

- (void)setModel:(VedioCellModel *)model{
    _model = model;
    HXCustomAssetModel *assetModel5 = [HXCustomAssetModel assetWithLocalVideoURL:[NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"] selected:YES];
    HXCustomAssetModel *assetModel6 = [HXCustomAssetModel assetWithLocalVideoURL:[NSURL URLWithString:@"http://www.w3school.com.cn/example/html5/mov_bbb.mp4"] selected:YES];
    [self.manager addCustomAssetModel:@[assetModel5, assetModel6]];
    [self.photoView refreshView];
    
//    self.photoView.sd_layout.heightIs(self.ph);
    [self setupAutoHeightWithBottomView:self.photoView bottomMargin:zn_AutoWidth(10)];
}

#pragma mark - delegate

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    
    //    [allList hx_requestImageWithOriginal:isOriginal completion:^(NSArray<UIImage *> * _Nullable imageArray) {
    //        NSSLog(@"%@",imageArray);
    //    }];
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame
{
    if (self.model) {
        self.model.height = frame.size.height;
    }
}

#pragma mark - get

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = UILabel.zn_create
        .zn_text(@"视频")
        .zn_font(zn_font(13))
        .zn_alignment(NSTextAlignmentLeft);
    }
    return _titleLabel;
}

- (HXPhotoView *)photoView{
    if (!_photoView) {
        _photoView = [HXPhotoView photoManager:self.manager];
        _photoView.frame = CGRectMake(15, 15, screenWidth - 15 * 2, 0);
        _photoView.lineCount = 4;
        _photoView.previewStyle = HXPhotoViewPreViewShowStyleDark;
        _photoView.outerCamera = YES;
        _photoView.delegate = self;
        _photoView.showAddCell = YES;
        _photoView.backgroundColor = [UIColor whiteColor];
    }
    return _photoView;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.openCamera = NO;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.photoMaxNum = 9; //
        _manager.configuration.videoMaxNum = 1;  //
        _manager.configuration.maxNum = 10;
        _manager.configuration.reverseDate = YES;
        _manager.configuration.selectTogether = YES;
    }
    return _manager;
}

@end
