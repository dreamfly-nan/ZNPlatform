//
//  CommentUserModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/24.
//  Copyright © 2019 社会人. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface CommentUserModel : BmobObject

@property (nonatomic , copy) NSString  * userIcon;

@property (nonatomic , copy) NSString  * userNikeName;

@property (nonatomic , copy) NSString  * userId;

@property (copy , nonatomic) NSString * createTime;

//评论内容
@property (nonatomic , copy) NSString  * commentText;

//被评论的评论Id
@property (nonatomic , copy) NSString  * commentId;

//点赞数量
@property(nonatomic,strong) NSString * thumpNumebr;

@end

NS_ASSUME_NONNULL_END
