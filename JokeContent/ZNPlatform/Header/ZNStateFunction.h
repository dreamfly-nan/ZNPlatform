//
//  ZNStateFunction.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/3.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#ifndef ZNStateFunction_h
#define ZNStateFunction_h

#import <UIKit/UIKit.h>

UIKIT_STATIC_INLINE CGFloat zn_screenWidth(){
    return [UIScreen mainScreen].bounds.size.width;
}

UIKIT_STATIC_INLINE CGFloat zn_screenHeight(){
    return [UIScreen mainScreen].bounds.size.height;
}

/**
 是否是p系列
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE BOOL isPCatena(){
    return zn_screenWidth() >= 414;
}

/**
 是不是5系列
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE BOOL isWSCatena(){
    return zn_screenWidth() >= 320;
}

/**
 是否是XR系列手机

 @return <#return value description#>
 */
UIKIT_STATIC_INLINE BOOL isiphoneXR(){
    return zn_screenWidth() >= 414;
}

/**
 是否是X

 @return <#return value description#>
 */
UIKIT_STATIC_INLINE BOOL isiphoneX(){
    return zn_screenWidth() >= 562;
}

/**
 适配屏幕宽度
 
 @param width <#width description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGFloat zn_AutoWidth(CGFloat width){
    if (isiphoneX()) {
        return (width / 375.0f) * zn_screenWidth() * 1.1;
    }else if(isiphoneXR()){
        return (width / 375.0f) * zn_screenWidth() * 1.05;
    }
    return (width / 375.0f) * zn_screenWidth();
}

/**
 适配屏幕高度
 
 @param height <#height description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGFloat zn_AutoHeight(CGFloat height){
    return (height / 667.0f) * zn_screenHeight();
}

/**
 根据颜色字符串来转化颜色
 
 @param color <#color description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE UIColor * zn_colorString(NSString * color){
    return [UIColor zn_colorWithHexString:color];
}

//字体适配
UIKIT_STATIC_INLINE UIFont * zn_font(CGFloat size){
    if (!isWSCatena()) {
        size = zn_AutoWidth(size);
    }
    UIFont *font = [UIFont systemFontOfSize:size];
    return font;
}

//加粗字体
UIKIT_STATIC_INLINE UIFont * zn_Bold_font(CGFloat size){
    if (!isWSCatena()) {
        size = zn_AutoWidth(size);
    }
    UIFont * font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:size];
    return font;
}

//拼接iframe
UIKIT_STATIC_INLINE NSString * zn_obtainHTMLWithIframe(NSString* iframe){
    NSString * html = [[NSString alloc] initWithFormat:@"%@%@%@",@"<!DOCTYPE html>"
                       "<html lang=\"ja\">"
                       "<head>"
                       "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\"><meta name=\"renderer\" content=\"webkit\"><meta name=\"force-rendering\" content=\"webkit\">"
                       "</head>"
                       "<body id=\"page\" style=\"text-align:center;width:100%;height:100%; padding：0 10px;\">"
                       ,iframe,@"</body></html>"];
    return html;
}

//获取文件路径
UIKIT_STATIC_INLINE NSString * zn_FilePath(NSString * fileNme, NSString* type){
    return [[NSBundle mainBundle] pathForResource:fileNme ofType:type];
}

//获取图片
UIKIT_STATIC_INLINE UIImage * zn_ImagePath(NSString * fileNme, NSString* type){
    return [UIImage imageWithContentsOfFile:zn_FilePath(fileNme, type)];
}

//根据图片名字获取UIImage对象
UIKIT_STATIC_INLINE UIImage * zn_imageName(NSString * name){
    return [UIImage imageNamed:name];
}

#endif /* ZNStateFunction_h */
