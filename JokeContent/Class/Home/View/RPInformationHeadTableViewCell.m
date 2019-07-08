//
//  RPInformationHeadTableViewCell.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/6/9.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPInformationHeadTableViewCell.h"
#import "RPSearchTextField.h"

@interface RPInformationHeadTableViewCell()

@property (nonatomic , strong) UIImageView * logoImageView;

//加号，更多功能
@property (nonatomic , strong) UIButton * moreFunctionBtn;

//搜索框的左边放大镜图
@property (nonatomic , strong) UIImageView * leftSearchTextImageView;

//搜索框
@property (nonatomic , strong) RPSearchTextField * searchTextField;

@end


@implementation RPInformationHeadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpInitUI];
    }
    return self;
}

- (void)setUpInitUI{
    [self.contentView addSubview:self.logoImageView];
    [self.contentView addSubview:self.moreFunctionBtn];
    [self.contentView addSubview:self.searchTextField];
    
    self.logoImageView.sd_layout
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .topSpaceToView(self.contentView, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(56))
    .heightIs(zn_AutoWidth(18));
    
    self.moreFunctionBtn.sd_layout
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .centerYEqualToView(self.logoImageView)
    .widthIs(zn_AutoWidth(20))
    .heightEqualToWidth();
    
    self.searchTextField.sd_layout
    .topSpaceToView(self.logoImageView, zn_AutoWidth(12))
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .heightIs(zn_AutoHeight(27));
    
    [self setupAutoHeightWithBottomView:self.searchTextField bottomMargin:zn_AutoHeight(5)];
}

- (void)setModel:(NSString *)model{
    _model = model;
    [self setupAutoHeightWithBottomView:self.searchTextField bottomMargin:zn_AutoHeight(5)];
}

#pragma mark ----------get-----------

- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
        _logoImageView.image = [UIImage imageNamed:@"logo"];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _logoImageView;
}

- (UIButton *)moreFunctionBtn{
    if (!_moreFunctionBtn) {
        _moreFunctionBtn = [UIButton new];
        [_moreFunctionBtn setImage:[UIImage imageNamed:@"more_function"] forState:UIControlStateNormal];
    }
    return _moreFunctionBtn;
}

- (UIImageView *)leftSearchTextImageView{
    if (!_leftSearchTextImageView) {
        _leftSearchTextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
        _leftSearchTextImageView.frame = CGRectMake(zn_AutoWidth(8), zn_AutoHeight(6), zn_AutoHeight(15), zn_AutoHeight(15));
    }
    return _leftSearchTextImageView;
}

- (RPSearchTextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [RPSearchTextField new];
        _searchTextField.leftView = self.leftSearchTextImageView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.left_distance = zn_AutoWidth(8);
        _searchTextField.placeholder = @"请输入关键字";
        _searchTextField.backgroundColor = Big_background_Color();
        _searchTextField.layer.cornerRadius = 5;
        _searchTextField.font = zn_font(12);
        _searchTextField.textAlignment = NSTextAlignmentCenter;
    }
    return _searchTextField;
}

@end
