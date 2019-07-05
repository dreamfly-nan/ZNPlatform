//
//  TwoTypeTableViewCell.m
//  MeetCarefree
//
//  Created by 郑楠楠 on 2018/4/16.
//  Copyright © 2018年 xxf. All rights reserved.
//

#import "TwoTypeTableViewCell.h"
@interface TwoTypeTableViewCell()

@property (nonatomic , strong) UILabel *titleLab;

@property (nonatomic , strong) UILabel *authorLabel;

//新闻时间
@property (nonatomic , strong) UILabel * dateLabel;

@property (nonatomic , strong) UIImageView *leftImageView;

@property (nonatomic , strong) UIImageView * rightImageView;

@end

@implementation TwoTypeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupInitUI];
    }
    return self;
}

- (void)setupInitUI{
    CGFloat imageWidth = (screenWidth - zn_AutoWidth(30)) / 2 - zn_AutoWidth(2);
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.dateLabel];
    
    self.titleLab.sd_layout
    .topSpaceToView(self.contentView, zn_AutoHeight(17))
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .autoHeightRatio(0);
    [self.titleLab setMaxNumberOfLinesToShow:2];
    
    self.leftImageView.sd_layout
    .leftEqualToView(self.titleLab)
    .topSpaceToView(self.titleLab, zn_AutoHeight(10))
    .widthIs(imageWidth)
    .heightIs(zn_AutoWidth(80));
    
    self.rightImageView.sd_layout
    .rightEqualToView(self.titleLab)
    .topSpaceToView(self.titleLab, zn_AutoHeight(10))
    .heightIs(zn_AutoWidth(80))
    .widthIs(imageWidth);
    
    self.authorLabel.sd_layout
    .rightEqualToView(self.rightImageView)
    .topSpaceToView(self.rightImageView,zn_AutoHeight(10))
    .widthIs(zn_AutoWidth(60))
    .heightIs(zn_AutoWidth(18));
    
    self.dateLabel.sd_layout
    .rightSpaceToView(self.authorLabel, 0)
    .topSpaceToView(self.rightImageView,zn_AutoHeight(10))
    .leftEqualToView(self.leftImageView)
    .heightIs(zn_AutoWidth(18));
}

- (void)setModel:(NewsDetailModel *)model{
    self.authorLabel.text = model.source;
    self.titleLab.text = model.title;
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.imageurls[0].url] placeholderImage:[UIImage imageNamed:InformationPlaceHoldImage]];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model.imageurls[1].url] placeholderImage:[UIImage imageNamed:InformationPlaceHoldImage]];
    
    CGFloat width = [model.source zn_obtainWidthWithHeight:zn_AutoWidth(18) font:zn_font(15)];
    self.authorLabel.sd_layout.widthIs(width);
    self.dateLabel.text = model.pubDate;
    
    [self setupAutoHeightWithBottomViewsArray:@[self.authorLabel,self.dateLabel] bottomMargin:zn_AutoWidth(10)];
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
}

#pragma mark -------get-------

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightImageView.clipsToBounds = YES;
    }
    return _rightImageView;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        _leftImageView.clipsToBounds = YES;
    }
    return _leftImageView;
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
        _authorLabel.textColor = zn_colorString(@"#BFBFBF");
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
