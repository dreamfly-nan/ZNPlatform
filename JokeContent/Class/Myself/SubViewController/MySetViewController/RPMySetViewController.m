//
//  RPMySetViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPMySetViewController.h"
#import "RPLoginViewController.h"
#import "RPMySetViewModel.h"
#import "FeedBackViewController.h"
#import "AboutUsViewController.h"

@interface RPMySetViewController ()

@property (nonatomic , strong) NSArray<NSString *> * items;

@property (nonatomic , strong) RPMySetViewModel * viewmodel;

@end

@implementation RPMySetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.viewmodel setUpInitUI];
    // Do any additional setup after loading the view.
}

#pragma mark -------------UITableViewDelegate--------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [RPConfig clearUserData];
            RPNavigationController * controller = [[RPNavigationController alloc] initWithRootViewController:[RPLoginViewController new]];
            [RPConfig sharedInstance].userData = nil;
            [self presentViewController:controller animated:YES
                             completion:nil];
        }
    }else{
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                {
                    FeedBackViewController * controller = [FeedBackViewController new];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                case 2:
                {
                    AboutUsViewController * controller = [AboutUsViewController new];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
    }
}

#pragma mark ------------UITableViewDataSource------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.items.count;
    }else if(section == 1){
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return zn_AutoHeight(10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RPBaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[RPBaseTableViewCell idString]];
    cell.textLabel.font =  zn_font(13);
    if (indexPath.section == 0) {
        cell.textLabel.text = self.items[indexPath.row];
        cell.textLabel.textColor = Title_Color();
    }else{
        cell.textLabel.text = @"退出登录";
        cell.textLabel.center = CGPointMake(cell.width/2, cell.height/2);
        cell.textLabel.textColor = zn_colorString(@"#f36363");
    }
    return cell;
}

#pragma mark -----------get--------

- (RPMySetViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [RPMySetViewModel new];
        _viewmodel.controller = self;
    }
    return _viewmodel;
}

- (NSArray<NSString *> *)items{
    if (!_items) {
        _items = @[@"反馈",@"缓存",@"关于我们"];
    }
    return _items;
}

@end
