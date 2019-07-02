//
//  NewsKindsChooseViewModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/19.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "NewsKindsChooseViewModel.h"
#import "ChooseItemModel.h"

@interface NewsKindsChooseViewModel()

@property (nonatomic , strong) UIScrollView * scrollView;

@property (nonatomic , strong) NSMutableArray * itemBtns;

@property (nonatomic , strong) NSArray<ChooseItemModel*> * kinds;

@end

@implementation NewsKindsChooseViewModel

/**
 将用户选中项提取出来
 */
- (void)setChooseItem{
    for (ChooseItemModel * model in self.kinds) {
        if (model.isChoose) {
            [self.chooseKinds addObject:model.model];
        }
    }
    [RPConfig sharedInstance].chooseKinds = [self.chooseKinds copy];
    
}

- (void)setInitUI{
    [self.controller.view addSubview:self.scrollView];
    self.controller.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.sureBtn]];
    [self setInitBtn];
}

- (void)setInitBtn{
    //如果存在则进行移除所有的选项
    if (self.itemBtns.count > 0) {
        for (UIView * view in self.itemBtns) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat tagBtnX = zn_AutoWidth(16);
    CGFloat tagBtnY = zn_AutoHeight(20);
    
    for (int i = 0 ; i < self.kinds.count ; i++) {
        ChooseItemModel * model = self.kinds[i];
        UIButton * btn = [self obtainBtn:model index:i];
        
        CGSize tagTextSize = [model.model.name zn_obtainRectWithHeight:zn_AutoWidth(18) font:zn_font(14)].size;
        if (tagBtnX+tagTextSize.width+zn_AutoWidth(30) > screenWidth - zn_AutoWidth(32)) {
            tagBtnX = zn_AutoWidth(16);
            tagBtnY += zn_AutoWidth(45);
        }
        btn.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+zn_AutoWidth(30), zn_AutoWidth(30));
        tagBtnX = CGRectGetMaxX(btn.frame)+zn_AutoWidth(10);
        [self.scrollView addSubview:btn];
        [self.itemBtns addObject:btn];
        
        self.scrollView.contentSize = CGSizeMake(screenWidth, btn.zn_y + btn.height + zn_AutoHeight(20));
    }
}

-(UIButton*)obtainBtn:(ChooseItemModel *)model
               index:(int) index{
    UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tagBtn.tag = index;
    [tagBtn setTitle:model.model.name forState:UIControlStateNormal];
    [tagBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [tagBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    tagBtn.titleLabel.font = zn_font(14);
    tagBtn.layer.cornerRadius = zn_AutoWidth(15);
    tagBtn.layer.masksToBounds = YES;
    tagBtn.layer.borderWidth = 1;
    tagBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tagBtn.selected = model.isChoose;
    
    if (tagBtn.selected){
        [tagBtn setBackgroundColor:[UIColor orangeColor]];
    }
    
    if (!tagBtn.selected){
        [tagBtn setBackgroundColor:[UIColor clearColor]];
    }
    
    return tagBtn;
}

- (void)tagBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.kinds[btn.tag].isChoose = !self.kinds[btn.tag].isChoose;
    if (btn.selected){
        [btn setBackgroundColor:[UIColor orangeColor]];
    }
    
    if (!btn.selected){
        [btn setBackgroundColor:[UIColor clearColor]];
    }
    
}

#pragma mark - get

- (NSArray<ChooseItemModel*> *)kinds{
    if (!_kinds) {
        NSMutableArray * array = [NSMutableArray new];
        NSString * userKindsId = [RPConfig sharedInstance].userData.kindsIds;
        for (NewsKindsModel * model in [RPConfig sharedInstance].kinds) {
            ChooseItemModel * item = [ChooseItemModel new];
            item.model = model;
            if (userKindsId) {
                if ([userKindsId containsString:model.channelId]) {
                    item.isChoose = YES;
                }else{
                    item.isChoose = NO;
                }
            }else{
                item.isChoose = YES;
            }
            [array addObject:item];
        }
        _kinds = [array copy];
    }
    return _kinds;
}

- (NSMutableArray *)chooseKinds{
    if (!_chooseKinds) {
        _chooseKinds = [NSMutableArray array];
    }
    return _chooseKinds;
}

- (NSMutableArray *)removeKinds{
    if (!_removeKinds) {
        _removeKinds = [NSMutableArray new];
    }
    return _removeKinds;
}

- (NSMutableArray *)itemBtns{
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [RPConfig sharedInstance].navigationHeight + znStateHeight, screenWidth, screenHeight - [RPConfig sharedInstance].navigationHeight)];
    }
    return _scrollView;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton new];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = zn_font(13);
        [_sureBtn setTitleColor:Main_Color() forState:UIControlStateNormal];
    }
    return _sureBtn;
}

@end
