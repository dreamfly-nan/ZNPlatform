//
//  ThreeTypeTableViewCell.m
//  MeetCarefree
//
//  Created by 郑楠楠 on 2018/4/16.
//  Copyright © 2018年 xxf. All rights reserved.
//

#import "ThreeTypeTableViewCell.h"
#import "ImageCollectionViewCell.h"

@interface ThreeTypeTableViewCell() <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UILabel *titleLab;

@property (nonatomic , strong) UILabel *authorLabel;

//新闻时间
@property (nonatomic , strong) UILabel * dateLabel;

//图片
@property (nonatomic , strong) UICollectionView *imageCollectView;

@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic , assign) CGFloat height;

@property (nonatomic , assign) CGFloat width;

@end

@implementation ThreeTypeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupInitUI];
    }
    return self;
}

- (void)setupInitUI{
    self.width = (screenWidth - zn_AutoWidth(30) - zn_AutoWidth(10))/3 - 1;
    self.height = self.width * 8.0 / 11.0;
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.imageCollectView];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.dateLabel];
    
    self.titleLab.sd_layout
    .topSpaceToView(self.contentView, zn_AutoHeight(10))
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .autoHeightRatio(0);
    [self.titleLab setMaxNumberOfLinesToShow:2];
    
    self.imageCollectView.sd_layout
    .leftEqualToView(self.titleLab)
    .rightEqualToView(self.titleLab)
    .topSpaceToView(self.titleLab, zn_AutoHeight(10))
    .heightIs(1 + self.height);
    
    self.authorLabel.sd_layout
    .rightEqualToView(self.imageCollectView)
    .topSpaceToView(self.imageCollectView,zn_AutoHeight(10))
    .widthIs(zn_AutoWidth(60))
    .heightIs(zn_AutoWidth(18));
    
    self.dateLabel.sd_layout
    .rightSpaceToView(self.authorLabel,0)
    .topSpaceToView(self.imageCollectView,zn_AutoHeight(10))
    .leftEqualToView(self.imageCollectView)
    .heightIs(zn_AutoWidth(18));
    
    [self setupAutoHeightWithBottomViewsArray:@[self.authorLabel] bottomMargin:zn_AutoHeight(10)];
}

- (void)setModel:(NewsDetailModel *)model{
    _model = model;
    self.authorLabel.text = model.source;
    self.titleLab.text = model.title;
    CGFloat width = [model.source zn_obtainWidthWithHeight:zn_AutoWidth(18) font:zn_font(15)];
    self.authorLabel.sd_layout.widthIs(width);
    self.dateLabel.text = model.pubDate;
    [self.imageCollectView reloadData];
}

#pragma mark ----------UICollectionViewDelegate-----------

#pragma mark ----------UICollectionViewDataSource---------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.imageurls.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ImageCollectionViewCell idString] forIndexPath:indexPath];
    cell.imageURL = self.model.imageurls[indexPath.row].url;
    return cell;
}

#pragma mark -------get-------

- (UICollectionView *)imageCollectView{
    if (!_imageCollectView) {
        _imageCollectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _imageCollectView.delegate = self;
        _imageCollectView.dataSource = self;
        _imageCollectView.userInteractionEnabled = NO;
        _imageCollectView.backgroundColor = [UIColor whiteColor];
        [_imageCollectView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:[ImageCollectionViewCell idString]];
    }
    return _imageCollectView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _flowLayout.itemSize = CGSizeMake(self.width,self.height);
        _flowLayout.minimumInteritemSpacing = zn_AutoWidth(5);
        _flowLayout.minimumLineSpacing = 0;
    }
    return _flowLayout;
}

-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [UILabel new];
        _titleLab.font = zn_font(15);
        _titleLab.textColor = [UIColor blackColor];
    }
    return _titleLab;
}

- (UILabel *)authorLabel{
    if (!_authorLabel) {
        _authorLabel = [UILabel new];
        _authorLabel.textAlignment = NSTextAlignmentRight;
        _authorLabel.font = zn_font(12);
        _authorLabel.textColor = AuOrDate_Color();
    }
    return _authorLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.font = zn_font(11);
        _dateLabel.textColor = AuOrDate_Color();
    }
    return _dateLabel;
}
@end
