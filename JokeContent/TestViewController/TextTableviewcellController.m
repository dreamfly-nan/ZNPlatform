//
//  TextTableviewcellController.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/1.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "TextTableviewcellController.h"
#import "ZNTextTableViewCell.h"
#import "ZNTextTableCellManager.h"
#import "ZNTextFieldTableViewCell.h"
#import "TestVideoTableViewCell.h"
@interface TextTableviewcellController ()
<
UITableViewDelegate,
UITableViewDataSource,
ZNTextTableCellManagerDelegate
>

@property(nonatomic,strong) UITableView * tableview;

@property(nonatomic,strong) NSArray * dataSource;

@property(nonatomic,strong) NSArray * veodioUrls;

@property(nonatomic,strong) ZNTextTableCellManager * manager;

@end

@implementation TextTableviewcellController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:self.tableview];
    [self setData];
    // Do any additional setup after loading the view.
}

- (void)setData{
    
    NSArray * array = @[@{@"title":@"谁是傻屌?",
                          @"content":@"林苏霖",
                          @"placeStr":@"林苏霖",
                          @"ableNilOrEmptContent":@"YES",
                          @"cellType":@"ZNTextTableViewCellTypeTextField"},
                        @{@"title":@"谁是傻逼?",
                          @"content":@"林苏霖1"},
                        @{@"title":@"谁是龟儿子?",
                          @"isShowArrow":@"NO",
                          @"lineType":@"ZNTextTableViewCellLineTypeLeft",
                          @"content":@[@"林苏霖",@"林苏霖1",@"林苏霖2",@"林苏霖3"]},
                        @{@"title":@"谁是渣渣?",
                          @"content":@"林苏霖3",
                          @"isShowArrow":@"NO"}
                        ];
    
    self.dataSource = [self.manager dataWithArrDic: array];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataSource.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZNTextCellModel * model = self.dataSource[indexPath.row];
        return [self.manager setCellWithTable:tableView model:model];
    }else{
        TestVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[TestVideoTableViewCell idString]];
        cell.model = [VedioCellModel new];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [tableView cellHeightForIndexPath:indexPath model:self.dataSource[indexPath.row] keyPath:@"model" cellClass:[ZNTextTableViewCell class] contentViewWidth:screenWidth];
    }else{
        return [tableView cellHeightForIndexPath:indexPath model:[VedioCellModel new] keyPath:@"model" cellClass:[TestVideoTableViewCell class] contentViewWidth:screenWidth];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return zn_AutoWidth(20);
}

#pragma mark - ZNTextTableCellManagerDelegate

- (NSString *)tipsMessageWithModel:(ZNTextCellModel *)model{
    return nil;
}

#pragma mark - get

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor zn_colorWithHexString:@"#f0f0f0"];
        [_tableview registerClass:[ZNTextTableViewCell class] forCellReuseIdentifier:[ZNTextTableViewCell idString]];
        [_tableview registerClass:[ZNTextFieldTableViewCell class] forCellReuseIdentifier:[ZNTextFieldTableViewCell idString]];
        [_tableview registerClass:[TestVideoTableViewCell class] forCellReuseIdentifier:[TestVideoTableViewCell idString]];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

- (ZNTextTableCellManager *)manager{
    if (!_manager) {
        _manager = [ZNTextTableCellManager new];
        _manager.znDelegate = self;
        _manager.isShowArrow = NO;
        _manager.lineType = ZNTextTableViewCellLineTypeNone;
        _manager.contentType = ZNTextTableViewCellContentRightSpaceWithSuperView;
    }
    return _manager;
}

@end
