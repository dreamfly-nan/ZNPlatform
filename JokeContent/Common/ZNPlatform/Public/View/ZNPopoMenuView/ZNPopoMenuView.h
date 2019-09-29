//
//  ZNPopoMenuView.h
//  CityManagement
//
//  Created by 南木南木 on 2019/9/3.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNPopoMenuItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZNPopoMenuViewDelegate <NSObject>

- (void)selectWithIndex:(int) index;

@end

@interface ZNPopoMenuView : UIView

@property(nonatomic,assign) CGFloat itemHeight;

@property(nonatomic,weak) id<ZNPopoMenuViewDelegate> znDelegate;

- (void)setItems:(NSArray<ZNPopoMenuItemModel*> *) items;

@end

NS_ASSUME_NONNULL_END
