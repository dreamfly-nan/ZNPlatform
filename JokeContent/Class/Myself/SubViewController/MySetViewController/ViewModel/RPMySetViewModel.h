//
//  RPMySetViewModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"
#import "RPMySetViewController.h"
#import <UIKit/UIKit.h>

@interface RPMySetViewModel : RPBaseObject

@property (nonatomic , strong) UITableView *tableview;

@property (nonatomic , weak) RPMySetViewController *controller;

- (void)setUpInitUI;

@end
