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

/// json转字典
/// @param json <#json description#>
UIKIT_STATIC_INLINE NSDictionary * zn_objectWithJson(NSString * json){
    if (json == nil || [json isEqualToString:@""]) {
        return nil;
    }
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

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
    scale = scale ?: znScreenScale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/// 导航栏高度
UIKIT_STATIC_INLINE CGFloat zn_stateHeight(){
    if (@available(iOS 13.0, *)) {
//        [UIWindowScene ]
        return znStateSize.height;
    } else {
        return znStateSize.height;
    }
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

/// 是不是6
UIKIT_STATIC_INLINE BOOL is6iphone(){
    return zn_screenWidth() >= 375;
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
//    if (isiphoneX()) {
//        return (int)ceil((width / 375.0f) * zn_screenWidth() * 1.1);
//    }else if(isiphoneXR()){
//        return (int)ceil((width / 375.0f) * zn_screenWidth() * 1.05);
//    }
    return (int)ceil((width / 375.0f) * screenWidth);
}

/**
 适配屏幕高度
 @param height <#height description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGFloat zn_AutoHeight(CGFloat height){
    return zn_AutoWidth(height);
}

/// 高的比例换算值
UIKIT_STATIC_INLINE CGFloat zn_height(CGFloat height){
    return (height / 677) * screenHeight;
}

/**
 根据颜色字符串来转化颜色
 @param color <#color description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE UIColor * zn_colorString(NSString * color){
    UIColor * znColor = [UIColor zn_colorWithHexString:color];
    
//    if (@available(iOS 13.0, *)) {
//       znColor = [znColor initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
//           if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
//               return [UIColor zn_colorWithHexString:color];
//           }else{
//               return [UIColor zn_colorWithHexString:color];
//           }
//        }];
//    }
    return znColor;
}

//字体适配
UIKIT_STATIC_INLINE UIFont * zn_font(CGFloat size){
//    if (isiphoneX()) {
//        size = ceil((size / 375.0f) * zn_screenWidth() * 1.03);
//    }else if(isiphoneXR()){
//        size = ceil((size / 375.0f) * zn_screenWidth() * 1);
//    }else if(is6iphone()){
//        size = ceil((size / 375.0f) * zn_screenWidth());
//    }else{
//        size = ceil((size / 375.0f) * zn_screenWidth() * 0.9);
//    }
    UIFont *font = [UIFont systemFontOfSize:(int)zn_AutoWidth(size)];
    return font;
}

/**
 根据字体名字和字体大小返回字体

 @param fontName 字体名字
 @param size 字体大小
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE UIFont * zn_FontName(NSString * fontName,CGFloat size){
    if (isiphoneX()) {
        size = ceil((size / 375.0f) * zn_screenWidth() * 1.1);
    }else if(isiphoneXR()){
        size = ceil((size / 375.0f) * zn_screenWidth() * 1);
    }else if(is6iphone()){
        size = ceil((size / 375.0f) * zn_screenWidth());
    }else{
        size = ceil((size / 375.0f) * zn_screenWidth() * 0.9);
    }
    UIFont * font = [UIFont fontWithName:fontName size:(int)size];
    return font;
}

//加粗字体
UIKIT_STATIC_INLINE UIFont * zn_Bold_font(CGFloat size){
    return zn_FontName(@"PingFangSC-Semibold", size);
}

/// 是否是刘海屏
UIKIT_STATIC_INLINE BOOL zn_isLiuHai(){
    // 根据安全区域判断
    if (@available(iOS 11.0, *)) {
        CGFloat height = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
        return (height > 0);
    } else {
        return NO;
    }
}

UIKIT_STATIC_INLINE CGFloat zn_safeBottom(){
    if (@available(iOS 11.0, *)) {
        CGFloat height = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
        return height;
    } else {
        return 0;
    }
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

//使用原图
UIKIT_STATIC_INLINE UIImage * zn_originalImageName(NSString * name){
   return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

//使用base64的字符转化为UIImage
UIKIT_STATIC_INLINE UIImage * zn_imageBase64(NSString * base64){
    if (base64) {
        NSData * data = [[NSData alloc] initWithBase64EncodedString:[base64 stringPaddedForBase64] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        return [UIImage imageWithData:data];
    }else{
        return nil;
    }
}

/**
 字符串拼接

 @param one <#one description#>
 @param two <#two description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE NSString * zn_split(NSString * one,NSString * two){
    return [NSString stringWithFormat:@"%@%@",one,two];
}

/**
 无符号int类转int

 @param number <#number description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE int zn_uIntToint(NSUInteger number){
    return [[NSString stringWithFormat:@"%lu",number] intValue];
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

/**
 如果文件夹已存在则不创建，不存在则创建，并返回文件夹的路径

 @param dirName <#dirName description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE NSString * zn_createDirFileWithName(NSString * dirName){
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:dirName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir))
        {
           BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            if(!bCreateDir){
                    NSLog(@"创建文件夹失败！");
                    return nil;
                }
            NSLog(@"创建文件夹成功，文件路径%@",path);
        }
    return path;
}

/**
 获取导航栏高度

 @param controller <#controller description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGFloat zn_navHeight(UIViewController * controller){
    if (controller.navigationController) {
        return controller.navigationController.navigationBar.zn_height;
    }
    return 0;
}

/**
 获取tabBar的高度

 @param controller <#controller description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE CGFloat zn_tabHeight(UIViewController * controller){
    if (controller.tabBarController) {
        return controller.tabBarController.tabBar.zn_height;
    }
    return 0;
}

/**
 获取版本号

 @return <#return value description#>
 */
UIKIT_STATIC_INLINE NSString * zn_version(){
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
    return currentVersion;
}

/**
 是否是nil，为null则返回空字符

 @param string <#string description#>
 @return <#return value description#>
 */
UIKIT_STATIC_INLINE NSString * zn_isEmpty(NSString * string){
    return string == nil ? @"":string;
}

/// 判断是否为null
/// @param object <#object description#>
UIKIT_STATIC_INLINE BOOL zn_isNSNull(id object){
    return [object isKindOfClass:[NSNull class]];
}

/// 浮点数转字符串，省略尾部多余的0
/// @param number <#number description#>
UIKIT_STATIC_INLINE NSString * zn_floatString(CGFloat number){
    number = zn_floatToFixed(number, 2);
    return [NSString stringWithFormat:@"%0.2f",number];
}

/// 浮点数转字符串保留两位小数
/// @param number <#number description#>
UIKIT_STATIC_INLINE NSString * zn_2floatString(double number){
    return [NSString stringWithFormat:@"%0.2f",number];
}

UIKIT_STATIC_INLINE NSArray<UIImage*> * zn_imageWithName(NSArray * imageNames){
    NSMutableArray * images = [NSMutableArray new];
    for (NSString * name in imageNames) {
        [images addObject:zn_imageName(name)];
    }
    return [images copy];
}

/// 获取当前的window
UIKIT_STATIC_INLINE UIWindow * zn_window(){
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    return window;
}

//是否有网络
UIKIT_STATIC_INLINE BOOL zn_isHaveNet(){
    
    NSString * netWorkState = [[AFNetworkReachabilityManager sharedManager] localizedNetworkReachabilityStatusString];

    /*

     AFNetworkReachabilityStatusUnknown          = -1,

     AFNetworkReachabilityStatusNotReachable     = 0,

     AFNetworkReachabilityStatusReachableViaWWAN = 1,

     AFNetworkReachabilityStatusReachableViaWiFi = 2,

     */

    NSLog(@"NewWorkState --- %@", netWorkState);

    if ([netWorkState isEqualToString:@"Unknow"] || [netWorkState isEqualToString:@"Not Reachable"]) {// 未知 或 无网络
        return NO;
    }
    else{
        return YES;
    }
}

#endif /* ZNStateFunction_h */
