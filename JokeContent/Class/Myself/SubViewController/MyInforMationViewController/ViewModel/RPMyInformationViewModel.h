//
//  RPMyInformationViewModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/22.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPMyInformationViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RPMyInformationViewModel : NSObject

@property (nonatomic , weak) RPMyInformationViewController * controller;

@property (nonatomic , strong) UIImageView * iconImageView;

@property (nonatomic , strong) UILabel * nameLabel;

@property (nonatomic , strong) UILabel * emailLabel;

@property (nonatomic , strong) UITextField * emailtextField;

@end

NS_ASSUME_NONNULL_END
