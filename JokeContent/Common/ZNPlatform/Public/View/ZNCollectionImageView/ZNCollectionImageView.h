//
//  ZNCollectionImageView.h
//  JokeContent
//  模仿微信朋友圈的图片展示，拖拽删除，图片浏览等功能
//  Created by 南木南木 on 2019/6/11.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNCommtentImageManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZNCollectionImageViewDelegate <NSObject>

@optional
/**
 删除图片
 @param model <#model description#>
 */
- (void)deleteImageWithModel:(ZNCommentImageModel*) model;

/**
 更新UI的高度

 @param height <#height description#>
 */
- (void)upDataUIHeight:(CGFloat) height;

@end

@interface ZNCollectionImageView : UIView
    
@property(nonatomic,strong) UIColor * collectViewBackColor;

@property(nonatomic,weak) id<ZNCollectionImageViewDelegate> znDelegate;

@property(nonatomic,strong) ZNCommtentImageManager * manager;

//点击图片的时候是否进行展示
@property(nonatomic,assign) BOOL isShowImage;

//长按后出现删除按键
@property(nonatomic,assign) BOOL isLongTouchDelegate;

@property(nonatomic,assign) CGFloat leftSpace;

@property(nonatomic,assign) CGFloat rightSpace;

@property(nonatomic,assign) CGFloat topSpace;

@property(nonatomic,assign) CGSize itemSize;

/**
 查看模式
 */
@property(nonatomic,assign) BOOL onlyLook;

- (void)setImageUrls:(NSArray<NSString*> *) urls;

- (void)setImages:(NSArray<UIImage*> *) images;

/**
 更新没一项图片的大小
 */
- (void)upUIItemSize;

/**
 根据数据进行获取高度

 @return <#return value description#>
 */
- (CGFloat)obtainDataHeight;


/**
 获取图片

 @return <#return value description#>
 */
- (NSArray<UIImage*> *) obtainImages;

/**
 重新加载数据
 */
- (void)reload;

@end

NS_ASSUME_NONNULL_END
