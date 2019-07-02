//
//  ZNCollectionImageView.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/11.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNCollectionImageView.h"
#import "ZNImageLookViewController.h"

#import <Photos/Photos.h>

@interface ZNCollectionImageView()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
ZNCImageCollectionViewCellDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property(nonatomic,strong) UICollectionView * imageCollectView;

@property(nonatomic,strong) UICollectionViewFlowLayout *imageLayout;

@property(nonatomic,strong) ZNCommtentImageManager * manager;

//移动到删除的按键上进行删除
@property(nonatomic,strong) UIButton * deleteBtn;

//根据手势移动的cell视图(是cell的截图)
@property(nonatomic,strong) UIView * moveCell;

//被选中移动的cell
@property(nonatomic,strong) UICollectionViewCell * moveCollectionCell;

//上一个手势的坐标点
@property(nonatomic,assign) CGPoint lastPoint;

//要移动删除的cell相对屏幕的坐标位置以及大小
@property(nonatomic,assign) CGRect cellFrom;

//被选中的图片model
@property(nonatomic,strong) ZNCommentImageModel * chooseModel;

//图片来自url集合
@property(nonatomic,assign) BOOL isImageResourceUrl;

//图片集合，可能是url，可能是image
@property(nonatomic,strong) NSArray * imageResourceArr;

@end

@implementation ZNCollectionImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setConfig];
        [self setInitUI];
    }
    return self;
}

- (void)setConfig{
    self.leftSpace = zn_AutoWidth(30);
    self.rightSpace = zn_AutoWidth(30);
    self.topSpace = zn_AutoWidth(15);
    CGFloat width = (screenWidth - zn_AutoWidth(60) - zn_AutoWidth(20) - 1)/3;
    self.itemSize = CGSizeMake(width, width);
}

- (void)upUIItemSize{
    CGFloat width = (screenWidth - self.leftSpace - self.rightSpace - zn_AutoWidth(20) - 1)/3;
    self.itemSize = CGSizeMake(width, width);
}

- (void)setInitUI{
    [self addSubview:self.imageCollectView];
    self.imageCollectView.sd_layout
    .topSpaceToView(self, self.topSpace)
    .leftSpaceToView(self, self.leftSpace)
    .rightSpaceToView(self, self.rightSpace)
    .heightIs(self.itemSize.height);
}

#pragma mark - public

- (void)setCollectViewBackColor:(UIColor *)collectViewBackColor{
    _collectViewBackColor = collectViewBackColor;
    self.imageCollectView.backgroundColor = collectViewBackColor;
}

- (void)setImages:(NSArray<UIImage *> *)images{
    self.isImageResourceUrl = NO;
    self.imageResourceArr = [images copy];
    [self.manager setImages:images];
    [self updateUI];
}

- (void)setImageUrls:(NSArray<NSString *> *)urls{
    self.isImageResourceUrl = YES;
    self.imageResourceArr = [urls copy];
    [self.manager setImageUrls:urls];
    [self updateUI];
}

/**
 更新UI界面展示
 */
- (void)updateUI{
    CGFloat number = ceil(self.manager.imageModels.count/(screenWidth/self.itemSize.width));
    CGFloat lineHeght = self.imageLayout.minimumLineSpacing;
    
    CGFloat height = self.itemSize.height * number + lineHeght * ( number - 1 );
    
    //如果高度算出来不变，则不进行重置
    if (height == self.imageCollectView.height) {
        return;
    }
    self.imageCollectView.sd_layout
    .topSpaceToView(self, self.topSpace)
    .leftSpaceToView(self, self.leftSpace)
    .rightSpaceToView(self, self.rightSpace)
    .heightIs(height);
    
    if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(upDataUIHeight:)]) {
        CGFloat selfHeight = [self obtainDataHeight];
        [self.znDelegate upDataUIHeight:selfHeight];
    }
}

/**
 根据数据进行获取高度
 
 @return <#return value description#>
 */
- (CGFloat)obtainDataHeight{
    CGFloat number = ceil(self.manager.imageModels.count/(screenWidth/self.itemSize.width));
    CGFloat lineHeght = self.imageLayout.minimumLineSpacing;
    CGFloat height = self.itemSize.height * number + lineHeght * ( number - 1 );
    return height + self.topSpace;;
}

#pragma mark - ZNCImageCollectionViewCellDelegate

- (void)longTouchAction:(ZNBaseCollectionViewCell *)cell model:(ZNCommentImageModel *)model longPress:(nonnull UILongPressGestureRecognizer *)longPress{
    self.moveCollectionCell = cell;
    self.cellFrom = [cell zn_screenRect];
    self.chooseModel = model;
    UIView *tempMoveCell = [cell snapshotViewAfterScreenUpdates:NO];
    tempMoveCell.alpha = 0.6;
    self.moveCell = tempMoveCell;
    self.moveCell.frame = [cell zn_screenRect];
    
    UIWindow * window = [[UIApplication sharedApplication] delegate].window;
    
    [window addSubview:self.deleteBtn];
    
    [window addSubview:self.moveCell];
    
    self.deleteBtn.sd_layout
    .bottomEqualToView(window)
    .leftEqualToView(window)
    .rightEqualToView(window)
    .heightIs(zn_AutoWidth(50));
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.moveCell.frame;
        frame = CGRectMake(frame.origin.x - zn_AutoWidth(2), frame.origin.y - zn_AutoWidth(2), frame.size.width + zn_AutoWidth(2), frame.size.height + zn_AutoWidth(2));
        
        self.moveCell.frame = frame;
        
    }];
    //隐藏cell
    cell.hidden = YES;
    //记录当前手指位置
    self.lastPoint = [longPress locationOfTouch:0 inView:longPress.view];
}

- (void)touchMoveAction:(UILongPressGestureRecognizer *)longPress{
    //计算移动距离
    CGFloat tranX = [longPress locationOfTouch:0 inView:longPress.view].x - self.lastPoint.x;
    CGFloat tranY = [longPress locationOfTouch:0 inView:longPress.view].y - self.lastPoint.y;
    //设置截图视图位置
    self.moveCell.center = CGPointApplyAffineTransform(self.moveCell.center, CGAffineTransformMakeTranslation(tranX, tranY));
    self.lastPoint = [longPress locationOfTouch:0 inView:longPress.view];
}

- (void)touchMoveEndAction:(UILongPressGestureRecognizer *)longPress{
    if (CGRectIntersectsRect(self.deleteBtn.frame, self.moveCell.frame)) {
        self.moveCollectionCell.hidden = NO;
        //交叉
        [self.manager.imageModels removeObject:self.chooseModel];
        self.chooseModel = nil;
        [self.deleteBtn removeFromSuperview];
        [self.moveCell removeFromSuperview];
        [self updateUI];
        [self.imageCollectView reloadData];
        
    }else{
        //抹油交叉,麻溜的动画移动回去
        CGRect frame = self.moveCell.frame;
        CGFloat lineLenght =sqrtf((frame.origin.x - self.cellFrom.origin.x) * (frame.origin.x - self.cellFrom.origin.x) + (frame.origin.y - self.cellFrom.origin.y)*(frame.origin.y - self.cellFrom.origin.y));
        CGFloat time = lineLenght / 400;
        if (time > 0.8) {
            time = 0.8;
        }
        [UIView animateWithDuration:time animations:^{
            self.moveCell.frame = self.cellFrom;
        } completion:^(BOOL finished) {
            if (finished) {
                self.moveCollectionCell.hidden = NO;
                [self.deleteBtn removeFromSuperview];
                [self.moveCell removeFromSuperview];
            }
        }];
    }
}

- (void)touchMoveCancelAction:(UILongPressGestureRecognizer *)longPress{
    self.moveCollectionCell.hidden = NO;
    [self.deleteBtn removeFromSuperview];
    [self.moveCell removeFromSuperview];
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //图片在这里压缩一下
    [self.manager.imageModels insertObject:[ZNCommentImageModel initWithImage:image] atIndex:self.manager.imageModels.count-1];
    [self.manager.newAddImages addObject:image];
    [self updateUI];
    [self.imageCollectView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ZNCommentImageModel * model = self.manager.imageModels[indexPath.row];
    if (model.cellType == ZNCommentImageCellTypeAddImage) {
        //这个是添加图片
        znWeakSelf(self)
        
        [ZNAlertDialogTool zn_showController:[self zn_obtainController]  arrayStr:@[@"拍照",@"相册",@"取消"] block:^(int index) {
            znStrongSelf
            switch (index) {
                case 0:
                {
                    NSString *mediaType = AVMediaTypeVideo;
                    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
                    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                        [MBProgressHUD zn_showError:@"请在'设置'中打开相机权限"];
                        return;
                    }
                    
                    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                        [MBProgressHUD zn_showError:@"照相机不可用"];
                        return;
                    }
                    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
                    vc.delegate = weakSelf;
                    vc.allowsEditing = YES;
                    vc.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [[weakSelf zn_obtainController] presentViewController:vc animated:YES completion:nil];
                }
                    break;
                case 1:
                {
                    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
                    vc.delegate = weakSelf;
                    vc.allowsEditing = YES;
                    vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [[weakSelf zn_obtainController] presentViewController:vc animated:YES completion:nil];
                }
                    break;
            }
        }];
    }else{
        //图片浏览
        ZNImageLookViewController * controller = [ZNImageLookViewController new];
        UIViewController * presentController = [self zn_obtainController];
        
        for (ZNCommentImageModel * model in self.manager.imageModels) {
            if (model.cellType != ZNCommentImageCellTypeAddImage) {
                if (model.resourceType == ZNCommentImageCellResourceURL) {
                    [controller addImageWithModel:[ZNImageLookModel initWithUrl:model.imageUrl]];
                }else if(model.resourceType == ZNCommentImageCellResourceImage){
                    [controller addImageWithModel:[ZNImageLookModel initWithImage:model.image]];
                }
            }
        }
        
        [controller setCurrentpageNumber:(int)indexPath.row];
        
        if (presentController.navigationController) {
            [presentController.navigationController pushViewController:controller animated:YES];
        }else{
            [presentController presentViewController:controller animated:YES completion:nil];
        }
    }
}

#pragma mark - UIConllectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.manager.imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZNCImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZNCImageCollectionViewCell idString] forIndexPath:indexPath];
    cell.model = self.manager.imageModels[indexPath.row];
    cell.znDelegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemSize;
}

#pragma mark - get

- (UICollectionView *)imageCollectView{
    if (!_imageCollectView) {
        _imageCollectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.imageLayout];
        [_imageCollectView registerClass:[ZNCImageCollectionViewCell class] forCellWithReuseIdentifier:[ZNCImageCollectionViewCell idString]];
        _imageCollectView.backgroundColor = [UIColor whiteColor];
        _imageCollectView.delegate = self;
        _imageCollectView.dataSource = self;
    }
    return _imageCollectView;
}

- (UICollectionViewFlowLayout *)imageLayout{
    if (!_imageLayout) {
        _imageLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _imageLayout;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton new];
        _deleteBtn.enabled = NO;
        _deleteBtn.backgroundColor = [UIColor redColor];
        _deleteBtn.titleLabel.font = zn_font(15);
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}

- (ZNCommtentImageManager *)manager{
    if (!_manager) {
        _manager = [ZNCommtentImageManager new];
    }
    return _manager;
}

@end
