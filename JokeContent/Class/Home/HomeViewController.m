//
//  HomeViewController.m
//  JokeContent
//
//  Created by 社会人 on 2019/4/11.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "HomeViewController.h"
#import "RPInformationDetailViewController.h"
#import "JokeListViewController.h"
#import "RPMyselfViewController.h"
#import "SearchViewController.h"
#import "HomeViewModel.h"
#import "HomeDataModel.h"

#import "AdDialogView.h"
#import "ZNDialogPage.h"

#import "ViewController.h"
#import "CollectionViewController.h"

#import "ZNSearchViewController.h"

@interface HomeViewController ()
<ZNSearchViewDelegate,
NewsKindsChooseControllerDelegate>

@property (nonatomic , strong) HomeViewModel * viewModel;

@property (nonatomic , strong) HomeDataModel * dataModel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel setUpInitUI];
    [self setBingding];
    [self isFristOpenDialog];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setKinds) name:homeKindsChange object:nil];
}

- (void)dealloc{
    //移除通知接收
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadRequest{
    [super reloadRequest];
    [self showLoading];
    [self.dataModel.kindsCommand execute:nil];
}

- (void)setBingding{
    znWeakSelf(self)
    
    [[self.viewModel.searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        ZNSearchViewController * controller = [ZNSearchViewController new];
        controller.znDelegate = weakSelf;
        [weakSelf.navigationController pushViewController:controller animated:YES];
    }];
    
    [[self.viewModel.accountBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (![weakSelf toLoginController]) {
            //跳转到个人中心
            RPMyselfViewController * controller = [RPMyselfViewController new];
            [weakSelf.navigationController pushViewController:controller animated:YES];
        }
    }];
    
    [[self.viewModel.moreFunctionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (![weakSelf toLoginController]) {
            //跳转到选择类别页面
            NewsKindsChooseController *chooseController = [NewsKindsChooseController new];
            chooseController.znDelegate = self;
            [weakSelf.navigationController pushViewController:chooseController animated:YES];
        }
    }];
    
    [self.dataModel.kindsCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        [weakSelf hideLoading];
        if ([x[0] boolValue]) {
            [weakSelf setKinds];
        }else{
            [weakSelf showError:x[1]];
        }
    }];
    [self showLoading];
    [self.dataModel.kindsCommand execute:nil];
}

- (void)isFristOpenDialog{
        if ([RPConfig isFristOpen]) {
            AdDialogView * dialogView = [[AdDialogView alloc] initWithFrame:CGRectMake(0, 0, zn_AutoWidth(300), zn_AutoWidth(400))];
            dialogView.imageView.image = [UIImage imageNamed:@"glod_red_ad"];
            dialogView.contextLabel.text = @"书中自有黄金屋，一起来看文章领金币吧！";
            ZNDialogPage * dialog = [ZNDialogPage createDialogPageWithSize:CGSizeMake(zn_AutoWidth(300), zn_AutoWidth(330)) views:@[dialogView]];
            [self.view addSubview:dialog];
            [RPConfig setFristOpen];
    }
}

- (void)setKinds{
    NSMutableArray * titles = [NSMutableArray array];
    NSMutableArray * controllers = [NSMutableArray array];
    NSArray * kinds;
    if ([RPConfig sharedInstance].userData) {
        kinds = [RPConfig sharedInstance].chooseKinds;
    }else{
        kinds = [RPConfig sharedInstance].kinds;
        NSMutableArray * kindsThree = [NSMutableArray new];
        //初始加载四种类型的新闻类型
        int i = 1;
        for (NewsKindsModel * model in kinds) {
            i ++;
            [kindsThree addObject:model];
            if (i == 5) {
                break;
            }
        }
        kinds = kindsThree;
    }
    
    for (NewsKindsModel * model in kinds) {
        ZNTitleModel * title = [ZNTitleModel initWithTitle:model.name subTitle:nil];
        title.selectColor = Main_Color();
        title.titleColor = Content_Color();
        title.titleFont = zn_font(13);
        title.subTitleFont = zn_font(10);
        title.subTitle = @"(99+)";
        title.selectFontChanage = 1;
        [titles addObject:title];
        
        JokeListViewController * controller = [JokeListViewController new];
        controller.typeId = model.channelId;
        [controllers addObject:controller];
    }
    [self.viewModel.textBarView setTitles:titles];
    [self.viewModel.contentView setControllers:controllers];
}

#pragma mark - NewsKindsChooseControllerDelegate

- (void)chooseFinish:(NSArray<NewsKindsModel *> *)kinds{
    [self setKinds];
}

#pragma mark - ZNSearchViewDelegate

- (void)searchWithStr:(NSString *)text controller:(ZNSearchViewController *)controller{
    JokeListViewController * viewcontroller = [JokeListViewController new];
    viewcontroller.searchText = text;
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

- (void)deleteHistory:(NSArray *)history{
    
}

#pragma mark - get

- (HomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [HomeViewModel new];
        _viewModel.controller = self;
    }
    return _viewModel;
}

- (HomeDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [HomeDataModel new];
    }
    return _dataModel;
}
    
@end
