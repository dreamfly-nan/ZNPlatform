//
//  ZNTextView.h
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/4.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZNTextViewDelegate <NSObject>
@optional
- (void)ChangeTextDelegate:(NSInteger)lengthStr;
@end;

@interface ZNTextView : UIView
@property (nonatomic, weak) id<ZNTextViewDelegate> delegate;

@property (nonatomic , strong) UIFont * placeFont;

@property (nonatomic , strong) UIColor * placeColor;

//占位符
@property (nonatomic , copy) NSString * placeStr;

@property (nonatomic , strong) UITextView * textView;

//内容
@property (nonatomic , copy) NSString * text;

@end

NS_ASSUME_NONNULL_END
