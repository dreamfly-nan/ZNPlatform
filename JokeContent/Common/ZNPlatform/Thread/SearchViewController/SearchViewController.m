//
//  SearchViewController.m
//  准到-ipad
//
//  Created by zhundao on 2017/8/25.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchViewModel.h"
#import "AJSearchBar.h"
#import "SearchCollectionView.h"
#import "SearchFlowLayout.h"

@interface SearchViewController ()<SearchDelegate,historyDelegate>{
    NSInteger row;
}
/*! 搜索框 */
@property(nonatomic,strong)AJSearchBar *searchBar;
/*! 搜索历史视图 */
@property(nonatomic,strong)SearchCollectionView *searchView;
/*! 布局 */
@property(nonatomic,strong)SearchFlowLayout *searchFlowLayout;
/*! SearchViewModel */
@property(nonatomic,strong)SearchViewModel *searchVM;
/*! 搜索历史label */
@property(nonatomic,strong)UILabel  *oldLabel;
/*! 垃圾桶 */
@property(nonatomic,strong)BigSizeButton *wastebutton;
/*! 数据源 */
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    // Do any additional setup after loading the view.
}

#pragma mark --- baseSetting

#warning 若控制位置不正确根据实际情况微调 这里有的不是自动布局

- (void)baseSetting{
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self.navigationController.view addSubview:self.searchBar];
    _searchVM = [[SearchViewModel alloc]init];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.oldLabel];
    [self.view addSubview:self.wastebutton];
    [self wasteButtonFrame];
}

#pragma mark---懒加载 
- (AJSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[AJSearchBar alloc]initWithFrame:CGRectMake(zn_AutoWidth(60),znStateHeight, screenWidth - zn_AutoWidth(50),self.navigationHeight)];
        _searchBar.SearchDelegate = self;
    }
    return _searchBar;
}

#warning tabbar为rootViewController 下面不加64

- (SearchCollectionView *)searchView{
    if (!_searchView) {
         row = [_searchVM rowForCollection:[_searchVM readHistory]];
        _searchFlowLayout = [[SearchFlowLayout alloc]init];
        _searchView = [[SearchCollectionView alloc]initWithFrame:CGRectMake(0, zn_AutoHeight(110), screenWidth, (row * 45) + 64) collectionViewLayout:_searchFlowLayout array:[[_searchVM readHistory] mutableCopy]];
        _searchView.historyDelegate = self;
    }
    return _searchView;
}

- (UILabel *)oldLabel{
    if (!_oldLabel&&[_searchVM readHistory].count>0) {
        _oldLabel = [[UILabel alloc]initWithFrame:CGRectMake(zn_AutoWidth(10), zn_AutoHeight(80), zn_AutoWidth(100), zn_AutoHeight(30))];
        _oldLabel.text = @"搜索历史";
        _oldLabel.font = zn_font(14);
    }
    return _oldLabel;
}

- (BigSizeButton *)wastebutton{
    if (!_wastebutton&&[_searchVM readHistory].count>0) {
        _wastebutton = [[BigSizeButton alloc]initWithFrame:CGRectZero];
        [_wastebutton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Search-Waste" ofType:@".png"]] forState:UIControlStateNormal];
        [_wastebutton addTarget:self action:@selector(deleteAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wastebutton;
    
}
#pragma mark --- 布局

- (void)wasteButtonFrame{
    __weak typeof(self) weakSelf = self;
    [_wastebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(zn_AutoHeight(80));
        make.right.equalTo(weakSelf.view).offset(-zn_AutoWidth(10));
        make.size.mas_equalTo(CGSizeMake(zn_AutoWidth(20), zn_AutoHeight(20)));
    }];
}

#pragma mark --- SearchDelegate
/*! 新增历史搜索 */
- (void)searchWithStr:(NSString *)text{
    /*! 保存历史数据 */
    if ([_searchVM readHistory].count==0) {
        [self reloadView:text];
        [self.view addSubview:self.oldLabel];
        [self.view addSubview:self.wastebutton];
        [self wasteButtonFrame];
    }else{
        [self reloadView:text];
    }
    [self search:text];
}

- (void)reloadView :(NSString *)text{
    [_searchVM saveHistory:text];
    _searchView.dataArray = [[_searchVM readHistory] mutableCopy];
    [self updataFrame];
    [_searchView reloadData];
}


#warning tabbar为rootViewController 下面不加64

- (void)updataFrame{
    row = [_searchVM rowForCollection:[_searchVM readHistory]];
    _searchView.frame = CGRectMake(0, zn_AutoHeight(110), screenWidth, (row * 45) + self.tabBarController.tabBar.height);
}

#pragma mark -  搜索

/*! 搜索关键词 */
- (void)search:(NSString *)text{
    NSLog(@"开始搜索%@",text);
    if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(searchText:)]) {
        [self.znDelegate searchText:text];
    }
}

#pragma mark --- historyDelegate
/*! 删除搜索历史 */
- (void)delete :(NSString *)text
{
//    ! 删除沙盒数据
    [_searchVM deleteHistory:text];
    /*! 刷新本地视图 */
    [_searchView.dataArray removeObject:text];
    /*! 是否删除垃圾桶和label */
    [self deleteOther];
    [_searchView reloadData];
}

/*! 移除控件 */
- (void)deleteOther {
    if ([_searchVM readHistory].count==0) {
        [_oldLabel removeFromSuperview];
        [_wastebutton removeFromSuperview];
    }
    [self updataFrame];
}

/*! cell选中搜索 */
- (void)select :(NSString *)text{
    [self search:text];
}

#pragma mark  ---- 垃圾桶按钮删除历史记录

- (void)deleteAll{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"亲,确定清空吗?要三思啊" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        /*! 删除所有历史记录 */
        [self.searchVM deleteHistory:@""];
        [self deleteOther];
        [self.searchView.dataArray removeAllObjects];
        [self.searchView reloadData];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark---网络判断

- (void)netWork:(NSString *)text{
    NSInteger status =  [[NSUserDefaults standardUserDefaults]integerForKey:@"ZDNet"];
    /*! 有网的结果 */
    if (status==1||status==2) [self haveNet:text];
    /*! 没有网的结果 */
    else [self NotNet:text];
}
/*! 有网搜索 */
- (void)haveNet:(NSString *)text{
    
}
/*! 没网 */
- (void)NotNet:(NSString *)text{
    
}

@end
