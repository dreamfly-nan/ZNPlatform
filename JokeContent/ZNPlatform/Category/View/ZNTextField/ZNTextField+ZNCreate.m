//
//  ZNTextField+ZNCreate.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNTextField+ZNCreate.h"

@implementation ZNTextField (ZNCreate)

- (ZNTextField * (^)(UIFont * font) )zn_font{
    return ^(UIFont * font){
        self.textField.font = font;
        return self;
    };
}

- (ZNTextField * (^)(UIColor * textColor))zn_textColor{
    return ^(UIColor * textColor){
        self.textField.textColor = textColor;
        return self;
    };
}

- (ZNTextField * (^)(NSString * text))zn_text{
    return ^(NSString * text){
        self.textField.text = text;
        return self;
    };
}

- (ZNTextField * (^)(NSString * placeStr))zn_place{
    return ^(NSString * placeStr){
        self.textField.placeholder = placeStr;
        return self;
    };
}

- (ZNTextField * (^)(NSTextAlignment alignment))zn_alignment{
    return ^(NSTextAlignment alignment){
        self.textField.textAlignment = alignment;
        return self;
    };
}

- (ZNTextField * (^)(CGFloat imageSpace))zn_imageSpace{
    return ^(CGFloat imageSpace){
        self.imageSpace = imageSpace;
        return self;
    };
}

- (ZNTextField * (^)(UIImage * image))zn_leftImage{
    return ^(UIImage * image){
        self.leftImage = image;
        return self
    };
}

- (ZNTextField * (^)(BOOL isLeftView))zn_isLeftView{
    return ^(BOOL isLeftView){
        self.isLeftView = isLeftView;
        return self;
    };
}

@end
