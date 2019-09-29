//
//  ZNPopoMenuView.m
//  CityManagement
//
//  Created by 南木南木 on 2019/9/3.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNPopoMenuView.h"
#import "ZNPopoMenuTableViewCell.h"

@interface ZNPopoMenuView()
<UITableViewDelegate,
UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) NSArray<ZNPopoMenuItemModel*> * items;

@end

@implementation ZNPopoMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setInitUI{
    [self addSubview:self.tableView];
    self.tableView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(0);
    
    self.itemHeight = zn_AutoWidth(40);
}

- (void)setItems:(NSArray<ZNPopoMenuItemModel *> *)items{
    _items = items;
    CGFloat height = items.count * self.itemHeight;
    [self.tableView reloadData];
    self.tableView.sd_layout.heightIs(height);
    self.zn_height = height;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(selectWithIndex:)]) {
        [self.znDelegate selectWithIndex:(int)indexPath.row];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZNPopoMenuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[ZNPopoMenuTableViewCell idString]];
    cell.model = self.items[indexPath.row];
    return cell;
}

#pragma mark - get

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[ZNPopoMenuTableViewCell class] forCellReuseIdentifier:[ZNPopoMenuTableViewCell idString]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
