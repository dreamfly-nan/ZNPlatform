//
//  RPMyselfViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPMyselfViewController.h"
#import "RPMySetViewController.h"
#import "RPMySystemMessageViewController.h"
#import "RPMyAttentionViewController.h"
#import "RPMyCommentViewController.h"
#import "RPMyInformationViewController.h"

#import <Photos/Photos.h>

#import "RPMyItemCollectionViewCell.h"
#import "RPMyselfDataModel.h"
#import "RPMyselfViewModel.h"

@interface RPMyselfViewController ()
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (nonatomic , strong) RPMyselfViewModel *viewModel;

@property (nonatomic , strong) RPMyselfDataModel *dataModel;

@end

@implementation RPMyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我   的";
    [self.viewModel setupInitUI];
    [self setBangding];
}

- (void)setBangding{
    znWeakSelf(self)
    [[self.viewModel.headView.iconHeadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        [weakSelf showActionSheet];
    }];
}

-(void)showActionSheet
{
    znWeakSelf(self)
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        znStrongSelf
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            [weakSelf showError:@"请在'设置'中打开相机权限"];
            return;
        }
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [weakSelf showError:@"照相机不可用"];
            return;
        }
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.delegate = self;
        vc.allowsEditing = YES;
        vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.delegate = self;
        vc.allowsEditing = YES;
        vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //图片在这里压缩一下
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1f);
    if (imageData.length/1024 > 1024*1)
    {
        [self showError:@"图片过大"];
    }
    else
    {
        //使用时间戳当做文件名
        BmobFile * file = [[BmobFile alloc] initWithFileName:[NSString stringWithFormat:@"%@_%@.jpg",[RPConfig sharedInstance].userData.username,DataModelTimeIntervalSince1970] withFileData:imageData];
       ImageModel * model = [ImageModel initWithAssetId:[RPConfig sharedInstance].userData.objectId imageFile:file type:@"0"];
        
        [self showLoading];
        
        znWeakSelf(self)
        [model upFileAddModel:^(BOOL isSuccess, NSError *error) {
            znStrongSelf
            [weakSelf hideLoading];
            if (isSuccess) {
                [[RPConfig sharedInstance].userData zn_updateWithDic:@{@"iconUrl":model.imageFile.url} ResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccess) {
                        [RPConfig sharedInstance].userData.iconUrl = model.imageFile.url;
                        [weakSelf.viewModel.headView.iconImage sd_setImageWithURL:[NSURL URLWithString:model.imageFile.url] placeholderImage:[UIImage imageNamed:@"head_background"]];
                        [weakSelf.viewModel.headView.backgroundImage sd_setImageWithURL:[NSURL URLWithString:model.imageFile.url] placeholderImage:[UIImage imageNamed:@"head_background"]];
                    }else{
                        [weakSelf showError:@"头像修改失败！"];
                    }
                }];
            }else{
                [weakSelf showError:@"上传失败！"];
            }
        }];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -----------UICollectionViewDelegate-------------

#pragma mark -----------UICollectionViewDataSource----------

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            RPMyInformationViewController * controller = [RPMyInformationViewController new];
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }
        case 1:
        {
            RPMyCommentViewController * controller = [RPMyCommentViewController new];
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }
        case 2:
        {
            RPMySystemMessageViewController * controller = [RPMySystemMessageViewController new];
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }
        case 3:
        {
            RPMySetViewController * controller = [RPMySetViewController new];
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataModel.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RPMyItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RPMyItemCollectionViewCell idString] forIndexPath:indexPath];
    cell.model = self.dataModel.items[indexPath.row];
    
    
    return cell;
}

#pragma mark -----------get-----------

- (RPMyselfViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [RPMyselfViewModel new];
        _viewModel.viewController = self;
        _viewModel.dataModel = self.dataModel;
    }
    return _viewModel;
}

- (RPMyselfDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [RPMyselfDataModel new];
    }
    return _dataModel;
}
@end
