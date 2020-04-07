//
//  UIView+ZNView.m
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/3/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "UIView+ZNView.h"
#import <objc/runtime.h>

@implementation UIView (ZNView)

#pragma mark private

- (void)tapRecognize:(UITapGestureRecognizer *) recognizer{
    if (self.zn_tapRecognizeBlock) {
        self.zn_tapRecognizeBlock(recognizer.view);
    }
}

#pragma mark - public

/**
 获取类名
 
 @return <#return value description#>
 */
- (NSString *)zn_getClassName{
    return NSStringFromClass([self class]);
}

//这个方法转换出来的图片  文字图片会变模糊
- (UIImage *)zn_convertViewToImageVague{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//使用该方法不会模糊，根据屏幕密度计算
- (UIImage *)zn_convertViewToImage{
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
}

- (CGRect)zn_screenRect{
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [self convertRect: self.bounds toView:window];
    return rect;
}

#pragma mark ------get-------

- (CGFloat)zn_x{
    return self.zn_ponit.x;
}

- (CGFloat)zn_y{
    return self.zn_ponit.y;
}

- (CGFloat)zn_width{
    return self.size.width;
}

- (CGFloat)zn_height{
    return self.size.height;
}

- (CGSize)zn_size{
    return self.frame.size;
}

- (CGPoint)zn_ponit{
    return self.frame.origin;
}

- (void (^)(id))zn_tapRecognizeBlock{
    id block = objc_getAssociatedObject(self, _cmd);
    return block;
}

- (UITapGestureRecognizer *)zn_tapRecognize{
    id recoginze = objc_getAssociatedObject(self, _cmd);
    return recoginze;
}

#pragma ------set-------

- (void)setZn_x:(CGFloat)zn_x{
    [self setZn_ponit:CGPointMake(zn_x, self.zn_ponit.y)];
}

- (void)setZn_y:(CGFloat)zn_y{
    [self setZn_ponit:CGPointMake(self.zn_ponit.x, zn_y)];
}

- (void)setZn_width:(CGFloat)zn_width{
    [self setZn_size:CGSizeMake(zn_width, self.zn_size.height)];
}

- (void)setZn_height:(CGFloat)zn_height{
    [self setZn_size:CGSizeMake(self.zn_size.width, zn_height)];
}

- (void)setZn_size:(CGSize)zn_size{
    CGRect rect = self.frame;
    rect.size = zn_size;
    self.frame = rect;
}

- (void)setZn_ponit:(CGPoint)zn_ponit{
    CGRect rect = self.frame;
    rect.origin = zn_ponit;
    self.frame = rect;
}

- (void)setZn_tapRecognizeBlock:(void (^)(id))zn_tapRecognizeBlock{
    objc_setAssociatedObject(self, @selector(zn_tapRecognizeBlock), zn_tapRecognizeBlock, OBJC_ASSOCIATION_COPY);
    if (!self.zn_tapRecognize) {
        UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognize:)];
        [self addGestureRecognizer:recognizer];
    }
}

- (void)setZn_tapRecognize:(UITapGestureRecognizer *)zn_tapRecognize{
    objc_setAssociatedObject(self, @selector(zn_tapRecognize), zn_tapRecognize, OBJC_ASSOCIATION_COPY);
}

/// 圆弧，向下凸
/// @param radian <#radian description#>
- (void)zn_radianBottomWithRadin:(CGFloat) radian{
    if(radian == 0) return;
    
    CGFloat t_width = CGRectGetWidth(self.frame); // 宽
    CGFloat t_height = CGRectGetHeight(self.frame); // 高
    CGFloat height = fabs(radian); // 圆弧高度
    CGFloat x = 0;
    CGFloat y = 0;
        
    // 计算圆弧的最大高度
    CGFloat _maxRadian = 0;
    
    _maxRadian =  MIN(t_height, t_width / 2);

    if(height > _maxRadian){
        NSLog(@"圆弧半径过大, 跳过设置。");
        return;
    }
    
    // 计算半径
    CGFloat radius = 0;
    
    CGFloat c = sqrt(pow(t_width / 2, 2) + pow(height, 2));
    CGFloat sin_bc = height / c;
    radius = c / ( sin_bc * 2);
    
    // 画圆
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    CGMutablePathRef path = CGPathCreateMutable();
    
    if(radian > 0){
        CGPathMoveToPoint(path,NULL, t_width,t_height - height);
        CGPathAddArc(path,NULL, t_width / 2, t_height - radius, radius, asin((radius - height ) / radius), M_PI - asin((radius - height ) / radius), NO);
    }else{
        CGPathMoveToPoint(path,NULL, t_width,t_height);
        CGPathAddArc(path,NULL, t_width / 2, t_height + radius - height, radius, 2 * M_PI - asin((radius - height ) / radius), M_PI + asin((radius - height ) / radius), YES);
    }
    
    CGPathAddLineToPoint(path,NULL, x, y);
    CGPathAddLineToPoint(path,NULL, t_width, y);
    
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    self.layer.mask = shapeLayer;
}

/// 圆弧，顶部向下凸
/// @param radian <#radian description#>
- (void)zn_radianTopWithRadin:(CGFloat)radian{
    if(radian == 0) return;
    CGFloat t_width = CGRectGetWidth(self.frame); // 宽
    CGFloat t_height = CGRectGetHeight(self.frame); // 高
    CGFloat height = fabs(radian); // 圆弧高度
    CGFloat x = 0;
    CGFloat y = 0;
       
    // 计算圆弧的最大高度
    CGFloat _maxRadian = 0;
   
    _maxRadian =  MIN(t_height, t_width / 2);

    if(height > _maxRadian){
        NSLog(@"圆弧半径过大, 跳过设置。");
        return;
    }
   
    // 计算半径
    CGFloat radius = 0;
   
    CGFloat c = sqrt(pow(t_width / 2, 2) + pow(height, 2));
    CGFloat sin_bc = height / c;
    radius = c / ( sin_bc * 2);
   
    // 画圆
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    CGMutablePathRef path = CGPathCreateMutable();
    
    if(radian > 0){
    CGPathMoveToPoint(path,NULL, t_width, height);
        CGPathAddArc(path,NULL, t_width / 2, radius, radius, 2 * M_PI - asin((radius - height ) / radius), M_PI + asin((radius - height ) / radius), YES);
        
    }else{
        CGPathMoveToPoint(path,NULL, t_width, y);
        CGPathAddArc(path,NULL, t_width / 2, height - radius, radius, asin((radius - height ) / radius), M_PI - asin((radius - height ) / radius), NO);
    }

    CGPathAddLineToPoint(path,NULL, x, t_height);
    CGPathAddLineToPoint(path,NULL, t_width, t_height);

    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    self.layer.mask = shapeLayer;
}

#pragma mark ------设置边框颜色，大小，视图背景，圆角--------

- (instancetype)zn_BezierRoundWithR:(CGFloat) r{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:r];
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.path = path.CGPath;
    self.layer.mask = layer;
    return self;
}

/**
 获取当前控制器
 
 @return <#return value description#>
 */
- (UIViewController *)zn_obtainController{
    for (UIView *next = self ; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (instancetype)zn_getLineViewWithColor:(UIColor *) color{
    UIView *view = [UIView new];
    view.backgroundColor = color;
    return view;
}

/**
 设置底部的线条

 @param color 线条颜色
 @param edge 距离
 */
- (void)zn_setBottomLineWithColor:(UIColor*) color
                        distance:(UIEdgeInsets)edge{
    UIView * lineView = UIView.zn_create.zn_backgroundColor(color);
    [self addSubview:lineView];
    
    lineView.sd_layout
    .bottomSpaceToView(self, edge.bottom)
    .leftSpaceToView(self, edge.left)
    .rightSpaceToView(self, edge.right)
    .heightIs(0.5);
}

/**
 设置底部的线条
 
 @param edge <#edge description#>
 */
- (void)zn_setBottomLineWithDistance:(UIEdgeInsets)edge{
    [self zn_setBottomLineWithColor:LINE_COlOR distance:edge];
}

/**
 设置底部的线条
 
 @param color 线条颜色
 */
- (void)zn_setBottomLineWithColor:(UIColor*) color{
    [self zn_setBottomLineWithColor:color distance:UIEdgeInsetsMake(0, 0, 0, 0)];
}

/**
 设置底部的线条
 
 @param bottom <#edge description#>
 */
- (void)zn_setBottomLineWithBottom:(CGFloat) bottom{
    [self zn_setBottomLineWithColor:LINE_COlOR distance:UIEdgeInsetsMake(0, 0, bottom, 0)];
}

/**
 设置view的阴影效果
 
 @param cornerRadius <#cornerRadius description#>
 @param color <#color description#>
 */
- (void)zn_setShadowWithCornerRadius:(CGFloat)cornerRadius
                       color:(UIColor*) color{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = cornerRadius;
}

/// 旋转动画
/// @param fromValuse <#fromValuse description#>
/// @param toValuse <#toValuse description#>
- (void)zn_animationTransformWithFrome:(int) fromValuse
                                    to:(int) toValuse
                               durTime:(CGFloat)durTime{
    CABasicAnimation *rotateAnimation   = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.removedOnCompletion = YES;
    rotateAnimation.duration = durTime;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:fromValuse];
    rotateAnimation.toValue   = [NSNumber numberWithFloat:toValuse];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:rotateAnimation forKey:@"strokeEnd"];
}

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
 
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
 
    [shapeLayer setBounds:lineView.bounds];
 
    if (isHorizonal) {
 
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
 
    } else{
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
        
    }
 
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
 
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
 
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
