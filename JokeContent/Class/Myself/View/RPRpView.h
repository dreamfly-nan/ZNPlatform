//
//  RPRpView.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPRpView : UIView

//二维码url
@property (nonatomic , strong) NSString *imageUrl;

//二维码图片
@property(nonatomic,strong) UIImage * rpImage;

- (void)show:(UIView*) view;

@end
