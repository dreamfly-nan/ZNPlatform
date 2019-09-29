//
//  SearchViewController.h
//  准到-ipad
//
//  Created by zhundao on 2017/8/25.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewControllerDelegate <NSObject>

- (void)searchText:(NSString*) searchText;

@end

@interface SearchViewController : ZNBaseViewController

@property (nonatomic , weak) id<SearchViewControllerDelegate> znDelegate;

@end
