//
//  RPBaseTableViewCell.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPBaseTableViewCell : UITableViewCell

+ (NSString *)idString;

- (NSMutableAttributedString*)createStr:(NSString*)str;

- (NSTextAttachment *)createAttachment:(NSString*)imageName;

- (NSMutableAttributedString *)createAttstr:(NSString *)str attachment:(NSTextAttachment *)attachment;

@end
