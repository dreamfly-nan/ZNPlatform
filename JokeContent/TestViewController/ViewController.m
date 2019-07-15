//
//  ViewController.m
//  JokeContent
//
//  Created by 南木南木 on 2019/4/11.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ViewController.h"
#import "ZNCollectionImageView.h"
@interface ViewController () <ZNCollectionImageViewDelegate>

@property (nonatomic,strong) ZNCollectionImageView * collectionImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionImageView setImageUrls:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1560330627403&di=2a61e00190b9d70cca5ee2e91515fb05&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F32fa828ba61ea8d3fcd2e9ce9e0a304e241f5803.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1560330627403&di=7aa84a54ed52d369b370f10cd4f3c523&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F4610b912c8fcc3cef70d70409845d688d53f20f7.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1560330627402&di=644820769d5903903f2c5056c375519f&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fdc54564e9258d1092f7663c9db58ccbf6c814d30.jpg"]];
    
    [self.view addSubview:self.collectionImageView];
}

#pragma mark - ZNCollectionImageViewDelegate

- (void)upDataUIHeight:(CGFloat)height{
    self.collectionImageView.height = height;
}

#pragma mark - get

- (ZNCollectionImageView *)collectionImageView{
    if (!_collectionImageView) {
        _collectionImageView = [[ZNCollectionImageView alloc] initWithFrame:CGRectMake(0, zn_AutoWidth(100), screenWidth, zn_AutoWidth(600))];
        _collectionImageView.topSpace = zn_AutoWidth(3);
        _collectionImageView.leftSpace = zn_AutoWidth(3);
        _collectionImageView.rightSpace = zn_AutoWidth(3);
        _collectionImageView.znDelegate = self;
        _collectionImageView.onlyLook = YES;
        [_collectionImageView upUIItemSize];
    }
    return _collectionImageView;
}

@end
