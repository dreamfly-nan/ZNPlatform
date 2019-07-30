//
//  AJSearchBar.m
//  准到-ipad
//
//  Created by zhundao on 2017/9/8.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "AJSearchBar.h"
#import "UITextField+TextLeftOffset_ffset.h"

@interface AJSearchBar()<UITextFieldDelegate>
/*! 默认文字 默认居中存在 */
@property(nonatomic,strong)UILabel *placeholderLabel;
/*! 方法镜图片 */
@property(nonatomic,strong)UIImageView *searchImage;
/*! 取消按钮 */
@property(nonatomic,strong)UIButton *cancelButton;
/*! 输入框 */
@property(nonatomic,strong)UITextField *textField;
/*! label文字大小 */
@property(nonatomic,assign)CGSize size;
/*! leftView 的宽度  */
@property (nonatomic , assign) CGFloat  leftViewWidth;
/*! 图片和label的间距 */
@property (nonatomic , assign) CGFloat  space;

@end;

@implementation AJSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.leftViewWidth = zn_AutoWidth(35);
        self.space = zn_AutoWidth(15);
        [self addSubview:self.textField];
        
        self.textField.sd_layout
        .centerYEqualToView(self)
        .leftEqualToView(self)
        .rightSpaceToView(self, zn_AutoWidth(60))
        .heightIs(zn_AutoHeight(26));
        
        [self baseSetting];
        [self.textField addSubview:self.placeholderLabel];
        [self.textField addSubview:self.searchImage];
        [self setAllFrame];
        [self addSubview:self.cancelButton];
        
        self.cancelButton.sd_layout
        .topEqualToView(self)
        .bottomEqualToView(self)
        .rightSpaceToView(self, zn_AutoWidth(15))
        .widthIs(zn_AutoWidth(40));
    }
    return self;
}

/*! 基础配置 */

- (void)baseSetting{
    /*! 边框处理 */
    _textField.layer.borderColor = LINE_COlOR.CGColor;
    _textField.layer.borderWidth = 1;
    _textField.layer.cornerRadius = zn_AutoHeight(13);
    _textField.layer.masksToBounds = YES;
    /*! 字体其他 */
    _textField.font = zn_font(14);
    _textField.tintColor = LINE_COlOR;
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.delegate =self;
    /*! 设置键盘return样式为搜索样式 */
    _textField.returnKeyType = UIReturnKeySearch;
    /*! 设置为无文字就灰色不可点 */
    _textField.enablesReturnKeyAutomatically = YES;
    /*! 开启系统清除样式 */
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    /*! 添加左边遮盖 */
    [_textField setTextOffsetWithLeftViewRect:CGRectMake(0, 0, self.leftViewWidth, self.frame.size.height) WithMode:UITextFieldViewModeAlways];
    /*! 编辑事件观察 */
    [_textField addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark --- 懒加载

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
    }
    return _textField;
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _placeholderLabel.text = @"请输入关键词";
        _placeholderLabel.textColor = PLACE_COLOR;
        _placeholderLabel.font = zn_font(13);
    }
    return _placeholderLabel;
}

- (UIImageView *)searchImage{
    if (!_searchImage) {
        _searchImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        _searchImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"discovered" ofType:@".png"]];
    }
    return _searchImage;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _cancelButton;
}

#pragma mark --- 设置尺寸
- (void)setAllFrame{
    self.size = [_placeholderLabel.text boundingRectWithSize:CGSizeMake(zn_AutoWidth(500), zn_AutoHeight(44)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : zn_font(14)} context:nil].size;
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField).offset(0);
        make.size.mas_equalTo(CGSizeMake(self.size.width, self.textField.frame.size.height));
        make.centerX.equalTo(self.textField);
    }];
    
    [self.searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerX.mas_equalTo(self.textField).offset(- self.space -self.size.width/2);
        make.centerY.mas_equalTo(self.textField);
    }];
    
}
#pragma mark --- 取消按钮点击事件

- (void)cancelAction{
    NSLog(@"点击了取消");
    [self endEditing:YES];
    _placeholderLabel.hidden  = NO;
    _textField.text = @"";
    [_placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.textField);
    }];
    /*! _searchImage移动到关标左边 */
    [_searchImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.textField).offset(-self.space-self.size.width/2);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        //执行更新
        [self.textField layoutIfNeeded];
    }];
}

#pragma mark --- UITextFieldDelegate

/*! 当输入框开始编辑的时候 */
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    /*! _placeholderLabel移动到关标右边*/
    [_placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.textField).offset(-self.textField.frame.size.width/2+self.leftViewWidth+self.size.width/2+5);
    }];
    /*! _searchImage移动到关标左边 */
    [_searchImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.textField).offset(-self.textField.frame.size.width/2-self.space+self.leftViewWidth);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
//        执行更新
        [self layoutIfNeeded];
    }];
}

/*! 输入框结束编辑 */
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length>0) {
        NSLog(@"进行搜索");
        [_SearchDelegate searchWithStr:textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
//    [_SearchDelegate searchWithStr:textField.text];
    NSLog(@"点击了搜索");
    return YES;
}

#pragma mark --- textFieldDidEditing: 
/*! 输入框编辑中 */

- (void)textFieldDidEditing:(UITextField *)textField{
    [self isHiddenLabel:textField];
}

- (void)isHiddenLabel:(UITextField *)textField{
    if (textField.text.length==0) {
        _placeholderLabel.hidden  = NO;
    }else{
        _placeholderLabel.hidden = YES;
    }
}
- (void)dealloc{
    NSLog(@"%@ 已经dealloc",NSStringFromClass(self.class));
}


@end
