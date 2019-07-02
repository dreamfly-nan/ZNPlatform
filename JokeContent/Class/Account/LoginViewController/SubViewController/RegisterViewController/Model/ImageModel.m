//
//  ImageModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/23.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

+ (instancetype)initWithAssetId:(NSString*) assetId
                      imageFile:(BmobFile*) imageFile
                           type:(NSString*)type{
    ImageModel * model = [ImageModel new];
    model.assetId = assetId;
    model.imageFile = imageFile;
    model.type = type;
    return model;
}

- (void)upFileAddModel:(void (^)(BOOL isSuccess,NSError * error)) block{
    znWeakSelf(self)
    [self.imageFile saveInBackground:^(BOOL isSuccessful, NSError *error) {
        znStrongSelf
        if (isSuccessful) {
            [weakSelf zn_addData:^(BOOL success, NSError * _Nonnull error) {
                if (block) {
                    block(success,error);
                }
            }];
        }else{
            if (block) {
                block(NO,[NSError new]);
            }
        }
    }];
}

@end
