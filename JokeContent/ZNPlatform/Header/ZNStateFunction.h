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

/**
 <#Description#>

 @param floatValue <#floatValue description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGFloat zn_removeFloatMin(CGFloat floatValue) {
    return floatValue == CGFLOAT_MIN ? 0 : floatValue;
}

/**
 *  调整给定的某个 CGFloat 值的小数点精度，超过精度的部分按四舍五入处理。
 *
 *  例如 CGFloatToFixed(0.3333, 2) 会返回 0.33，而 CGFloatToFixed(0.6666, 2) 会返回 0.67
 *
 *  @warning 参数类型为 CGFloat，也即意味着不管传进来的是 float 还是 double 最终都会被强制转换成 CGFloat 再做计算
 *  @warning 该方法无法解决浮点数精度运算的问题
 */
UIKIT_STATIC_INLINE CGFloat zn_floatToFixed(CGFloat value, NSUInteger precision) {
    NSString *formatString = [NSString stringWithFormat:@"%%.%@f", @(precision)];
    NSString *toString = [NSString stringWithFormat:formatString, value];
#if CGFLOAT_IS_DOUBLE
    CGFloat result = [toString doubleValue];
#else
    CGFloat result = [toString floatValue];
#endif
    return result;
}

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
UIKIT_STATIC_INLINE CGFloat zn_flatSpecificScale(CGFloat floatValue, CGFloat scale) {
    floatValue = zn_removeFloatMin(floatValue);
    scale = scale ?: screenScale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/**
 对像素进行取整处理
 
 @param valuse <#valuse description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGFloat zn_float(CGFloat valuse){
    return zn_flatSpecificScale(valuse,0);
}

/**
 获取一个像素取整的size

 @param width <#width description#>
 @param height <#height description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGSize zn_sizeMakeFlat(CGFloat width, CGFloat height){
    return CGSizeMake(zn_float(width), zn_float(height));
}

/**
 获取rect的中心点坐标

 @param rect <#rect description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGPoint zn_rectCenterPoint(CGRect rect){
    return CGPointMake(zn_float(CGRectGetMidX(rect)), zn_float(CGRectGetMidY(rect)));
}

/**
 屏幕宽度
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGFloat zn_screenWidth(){
    return [UIScreen mainScreen].bounds.size.width;
}

/**
 屏幕高度
 @return <#return value description#>
 */
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
        return ceil((width / 375.0f) * zn_screenWidth() * 1.1);
    }else if(isiphoneXR()){
        return ceil((width / 375.0f) * zn_screenWidth() * 1.05);
    }
    return ceil((width / 375.0f) * zn_screenWidth());
}

/**
 适配屏幕高度
 @param height <#height description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGFloat zn_AutoHeight(CGFloat height){
    return ceil((height / 667.0f) * zn_screenHeight());
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

/**
 根据字体名字和字体大小返回字体

 @param fontName 字体名字
 @param size 字体大小
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE UIFont * zn_FontName(NSString * fontName,CGFloat size){
    if (!isWSCatena()) {
        size = zn_AutoWidth(size);
    }
    UIFont * font = [UIFont fontWithName:fontName size:size];
    return font;
}

//加粗字体
UIKIT_STATIC_INLINE UIFont * zn_Bold_font(CGFloat size){
    return zn_FontName(@"AmericanTypewriter-Bold", size);
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

/**
 NSString转NSURL对象

 @param url <#url description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE NSURL * zn_url(NSString * url){
    return [NSURL URLWithString:url];
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

/**
 查看数值是否落在该区间（包括等于）
 
 @param minVlause 最小值
 @param maxVlause 最大值
 @param vlause 比较的数值
 @return 是否落在该区间
 */
UIKIT_STATIC_INLINE BOOL zn_betweenOrEuqal(CGFloat minVlause, CGFloat maxVlause, CGFloat vlause){
    return vlause <= maxVlause && vlause >= minVlause;
}

/**
 查看数值是否落在该区间
 
 @param minVlause 最小值
 @param maxVlause 最大值
 @param vlause 比较的数值
 @return 是否落在该区间
 */
UIKIT_STATIC_INLINE BOOL zn_between(CGFloat minVlause, CGFloat maxVlause, CGFloat vlause){
    return vlause < maxVlause && vlause > minVlause;
}

UIKIT_STATIC_INLINE CGRect zn_rectSetPoint(CGRect rect, CGFloat x, CGFloat y){
    rect.origin.x = zn_float(x);
    rect.origin.y = zn_float(y);
    return rect;
}

UIKIT_STATIC_INLINE CGRect zn_rectSetHeight(CGRect rect , CGFloat height){
    if (height < 0) {
        return rect;
    }
    rect.size.height = height;
    return rect;
}

UIKIT_STATIC_INLINE CGRect zn_rectSetWidth(CGRect rect , CGFloat width){
    if (width < 0) {
        return rect;
    }
    rect.size.width = width;
    return rect;
}

/**
 查看outerRange 是否包含了 innerRange

 @param outerRange <#outerRange description#>
 @param innerRange <#innerRange description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE BOOL zn_containingRanges(NSRange outerRange, NSRange innerRange){
    if (innerRange.location >= outerRange.location && outerRange.location + outerRange.length >= innerRange.location + innerRange.length) {
        return YES;
    }
    return NO;
}

#endif /* ZNStateFunction_h */
