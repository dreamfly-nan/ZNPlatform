//
//  ZNChooseViewController.h
//  CityManagement
//
//  Created by 南木南木 on 2019/8/29.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNBaseViewController.h"
#import "ZNChooseItemModel.h"

@protocol ZNChooseViewControllerDelegate <NSObject>

- (void)chooseTitles:(NSArray<ZNChooseItemModel*> *) titles
               items:(NSArray<NSArray<ZNChooseItemModel *> *> *) items;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZNChooseViewController : ZNBaseViewController

@property(nonatomic,strong) NSArray<ZNChooseItemModel*> * titleItems;

@property(nonatomic,strong) NSArray<NSArray<ZNChooseItemModel*>*> * items;

@property(nonatomic,weak) id<ZNChooseViewControllerDelegate> znDelegate;

@end

NS_ASSUME_NONNULL_END
