//
//  ImageModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/23.
//  Copyright © 2019 社会人. All rights reserved.
//

@interface ImageModel : BmobObject

//关联id，当type为0l时，为用户id，type为1时，为评论id
@property (nonatomic , copy) NSString * assetId;

//文件数据
@property (nonatomic , strong) BmobFile * imageFile;

@property (nonatomic , copy) NSString*  type;

+ (instancetype)initWithAssetId:(NSString*) assetId
                      imageFile:(BmobFile*) imageFile
                           type:(NSString*)type;

- (void)upFileAddModel:(void (^)(BOOL isSuccess,NSError * error)) block;

@end
