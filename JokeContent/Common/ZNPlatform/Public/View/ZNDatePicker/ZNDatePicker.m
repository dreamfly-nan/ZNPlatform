//
//  ZNDatePicker.m
//  CityManagement
//
//  Created by 郑楠楠 on 2019/8/18.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNDatePicker.h"

@interface ZNDatePicker()

@property (nonatomic , strong) UIDatePicker * datePicker;

@property (nonatomic , strong) UIButton * btn;

@property (nonatomic , strong) UIButton * sureBtn;

@property (nonatomic , strong) UIButton * cancelBtn;

@property (nonatomic , strong) UIView * backgroundView;

@property (nonatomic , strong) NSString * dateStr;

@end

@implementation ZNDatePicker

+ (void)zn_showDatePickerWithBlick:(void (^)(NSString * dateStr)) block{
    ZNDatePicker * pickerView = [ZNDatePicker new];
    pickerView.pickerBlick = block;
    [[UIApplication sharedApplication].keyWindow addSubview:pickerView];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)]) {
        [self setInitUI];
        [self setBangding];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setInitUI{
    [self addSubview:self.btn];
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.datePicker];
    [self.backgroundView addSubview:self.sureBtn];
    [self.backgroundView addSubview:self.cancelBtn];
    
    self.btn.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self);
    
    self.backgroundView.sd_layout
    .centerYEqualToView(self)
    .centerXEqualToView(self)
    .widthIs(screenWidth - zn_AutoWidth(60))
    .autoHeightRatio(0);
    
    self.datePicker.sd_layout
    .leftEqualToView(self.backgroundView)
    .topSpaceToView(self.backgroundView, zn_AutoWidth(0))
    .rightEqualToView(self.backgroundView)
    .heightIs(zn_AutoWidth(200));
    
    self.sureBtn.sd_layout
    .topSpaceToView(self.datePicker, zn_AutoWidth(0))
    .leftSpaceToView(self.backgroundView, screenWidth/4 - zn_AutoWidth(70) )
    .widthIs(zn_AutoWidth(100))
    .heightIs(zn_AutoWidth(40));
    [self.sureBtn setSd_cornerRadius:@(5)];
    
    self.cancelBtn.sd_layout
    .centerYEqualToView(self.sureBtn)
    .rightSpaceToView(self.backgroundView, screenWidth/4 - zn_AutoWidth(70))
    .widthIs(zn_AutoWidth(100))
    .heightIs(zn_AutoWidth(40));
    [self.cancelBtn setSd_cornerRadius:@(5)];
    
    [self.backgroundView setupAutoHeightWithBottomViewsArray:@[self.sureBtn,self.cancelBtn] bottomMargin:zn_AutoWidth(20)];
}

- (void)setBangding{
    znWeakSelf(self)
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (weakSelf.pickerBlick) {
            if (!weakSelf.dateStr || [weakSelf.dateStr isEqualToString:@""]) {
                weakSelf.dateStr = [ZNTimeTool getCurrentTimesWithFormatter:@"YYYY-MM-dd"];
            }
            weakSelf.pickerBlick(weakSelf.dateStr);
        }
        [weakSelf removeFromSuperview];
    }];
    
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        [weakSelf removeFromSuperview];
    }];
    
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       znStrongSelf
        [weakSelf removeFromSuperview];
    }];
}

- (void)changeValue{
    //获取挑选的日期
    NSDate *date =_datePicker.date;
    NSDateFormatter *dateForm = [[NSDateFormatter alloc]init];
    //设定转换格式
    dateForm.dateFormat =@"YYYY-MM-dd";
    //由当前获取的NSDate数据，转换为日期字符串，显示在私有成员变量_textField上
    NSString * dateStr = [dateForm stringFromDate:date];
    self.dateStr = dateStr;
}

#pragma mark - get

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroundView;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton new];
        _btn.backgroundColor = [UIColor blackColor];
        _btn.alpha = 0.3;
    }
    return _btn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton new];
        _sureBtn.zn_title(@"确定",UIControlStateNormal)
        .zn_titleColor([UIColor whiteColor],UIControlStateNormal)
        .zn_font(zn_font(15))
        .zn_backgroundColor(MAIN_COLOR);
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        _cancelBtn.zn_title(@"取消",UIControlStateNormal)
        .zn_titleColor([UIColor blackColor],UIControlStateNormal)
        .zn_font(zn_font(15))
        .zn_backgroundColor(LINE_COlOR);
    }
    return _cancelBtn;
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.layer.cornerRadius = 5;
        //显示日期模式
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        [_datePicker addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

@end
