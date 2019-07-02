//
//  RPDetailCommentView.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/27.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RPDetailCommentViewDelegate <NSObject>

/**
 点击消息
 */
- (void)messageAritcleBtnAction;

/**
 点击点赞
 */
- (void)thumUpAritcleBtnAction;

/**
 提交评论内容

 @param context <#context description#>
 */
- (void)commitComment:(NSString*) context;

/**
 展示评论输入视图
 */
- (void)showInputComment;

@end

@interface RPDetailCommentView : UIView

/**
 评论内容展示
 */
@property (nonatomic , strong) UITextView * commentTextView;

//覆盖在评论框上的按键
@property (nonatomic , strong) UIButton * commentFieldBtn;

//评论
@property (nonatomic , strong) UIButton *messageBtn;

//点赞
@property (nonatomic , strong) UIButton *thumUpBtn;

//顶上的线条
@property (nonatomic , strong) UIView * lineView;

//发表评论
@property (nonatomic , strong) UIButton * sendCommentBtn;

@property (nonatomic , weak) id <RPDetailCommentViewDelegate> znDelegate;

/**
 更新高度
 */
- (void)upHeight;

@end
