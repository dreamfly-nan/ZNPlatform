//
//  NewsDetailModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/18.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "NewsDetailModel.h"

@implementation NewsDetailModel

- (void)setImageurls:(NSArray<NewsImageModel *> *)imageurls{
    _imageurls = imageurls;
    if (imageurls) {
        if (imageurls.count <= 3) {
            self.type = (int)imageurls.count;
        }else{
            self.type = 3;
        }
    }
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"imageurls":[NewsImageModel class]};
}

@end
