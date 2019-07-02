//
//  RPHeadIconView.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPHeadIconView : UIView

//二维码
@property (nonatomic , strong) UIButton *rpBtn;

@property (nonatomic , strong) UIView *backgroundColorView;

@property (nonatomic , strong) UIImageView *backgroundImage;

//头像的环
@property (nonatomic , strong) UIImageView *ringImage;

//头像
@property (nonatomic , strong) UIImageView *iconImage;

//昵称
@property (nonatomic , strong) UILabel *nameLabel;

//粉丝数
@property (nonatomic , strong) UILabel *fensNumLabel;

//金币数量
@property(nonatomic,strong) UILabel * glodConLabel;

//金币图标
@property(nonatomic,strong) UIImageView *glodImageView;

/**
 头像的点击事件
 */
@property (nonatomic , strong) UIButton * iconHeadBtn;

@end
