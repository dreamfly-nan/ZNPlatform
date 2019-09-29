//
//  OneimageTableViewCell.m
//  MeetCarefree
//
//  Created by 郑楠楠 on 2018/4/16.
//  Copyright © 2018年 xxf. All rights reserved.
//

#import "OneTypeTableViewCell.h"
@interface OneTypeTableViewCell()

@property (nonatomic , strong) UILabel *titleLab;

@property (nonatomic , strong) UILabel *authorLabel;

//新闻时间
@property (nonatomic , strong) UILabel * dateLabel;

@property (nonatomic , strong) UIImageView *imageV;

@end

@implementation OneTypeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupInitUI];
    }
    return self;
}

- (void)setupInitUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.dateLabel];
    
    self.imageV.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(110))
    .heightIs(zn_AutoWidth(80));
    
    self.titleLab.sd_layout
    .topEqualToView(self.imageV)
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .rightSpaceToView(self.imageV, zn_AutoWidth(24))
    .autoHeightRatio(0);
    [self.titleLab setMaxNumberOfLinesToShow:2];
    
    self.authorLabel.sd_layout
    .rightEqualToView(self.titleLab)
    .bottomEqualToView(self.imageV)
    .heightIs(zn_AutoWidth(18))
    .widthIs(zn_AutoWidth(60));
    
    self.dateLabel.sd_layout
    .rightSpaceToView(self.authorLabel, 0)
    .bottomEqualToView(self.imageV)
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .heightIs(zn_AutoWidth(18));
}

- (void)setModel:(NewsDetailModel *)model{
    self.titleLab.text = model.title;
    self.authorLabel.text = model.source;
    
    NSString * url = model.imageurls.count > 0 ? model.imageurls[0].url : @"";
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:InformationPlaceHoldImage]];
    
    CGFloat width = [model.source zn_obtainWidthWithHeight:zn_AutoWidth(18) font:zn_font(15)];
    self.authorLabel.sd_layout.widthIs(width);
    self.dateLabel.text = model.pubDate;
    
//    [self setupAutoHeightWithBottomViewsArray:@[self.authorLabel] bottomMargin:zn_AutoHeight(10)];
}

#pragma mark -------get-------

-(UIImageView *)imageV{
    if (_imageV == nil) {
        _imageV = [[UIImageView alloc] init];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.clipsToBounds = YES;
    }
    return _imageV;
}

-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = UILabel.zn_create.zn_font(zn_font(15)).zn_textColor([UIColor blackColor]);
//        _titleLab.font = zn_font(15);
//        _titleLab.textColor = [UIColor blackColor];
    }
    return _titleLab;
}

- (UILabel *)authorLabel{
    if (!_authorLabel) {
        _authorLabel = [UILabel new];
        _authorLabel.textAlignment = NSTextAlignmentRight;
        _authorLabel.font = zn_font(11);
        _authorLabel.textColor = TITLE_COLOR;
    }
    return _authorLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        
        _dateLabel = UILabel.zn_create
        .zn_alignment(NSTextAlignmentRight)
        .zn_font(zn_font(11))
        .zn_textColor(AuOrDate_Color());
        
//        _dateLabel.textAlignment = NSTextAlignmentRight;
//        _dateLabel.font = zn_font(11);
//        _dateLabel.textColor = AuOrDate_Color();
        
    }
    return _dateLabel;
}
@end
