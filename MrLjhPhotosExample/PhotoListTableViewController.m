//
//  PhotoListTableViewController.m
//  MrLjhPhotosExample
//
//  Created by lujh on 2018/11/5.
//  Copyright © 2018 MeiLCmera. All rights reserved.
//

#import "PhotoListTableViewController.h"
#import "MrLjhALAsset.h"
#import "SinglePhotoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

@interface PhotoListTableViewController ()

@end

@implementation PhotoListTableViewController

- (void)viewWillAppear:(BOOL)animated{
 
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.text = @"相册";
    label.font = [UIFont systemFontOfSize:17];
    [label sizeToFit];
    self.navigationItem.titleView = label;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = cancel;
}

- (void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        
        
        [self showNoAuthorityVC];
        return;
    } else if (status == PHAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusDenied) {
                
                // 用户点击了不允许
             
              [self showNoAuthorityVC];
            }
           
            
          [self showNoAuthorityVC];
            
        }];
    }
    
    
    ASSETHELPER.bReverse = YES;
    [ASSETHELPER getGroupList:^(NSArray *a) {
        [self.tableView reloadData];
        ASSETHELPER.currentGroupIndex = 0;
        SinglePhotoViewController *picker = [[SinglePhotoViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:picker animated:NO];
    }];
}

#pragma mark - 显示无权限视图
- (void)showNoAuthorityVC
{
    UIAlertController *LovePHCamXPhotoAlertVC = [UIAlertController alertControllerWithTitle:@"" message:@"Please allow MrLjhPhotosExample to access your device's Photos in \"Settings\"->\"Privacy\"->\"Photos\"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *LovePHCamXPhotoAlertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }];
    
    [LovePHCamXPhotoAlertVC addAction:LovePHCamXPhotoAlertAction];
    
    [self presentViewController:LovePHCamXPhotoAlertVC animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[MrLjhALAsset sharedAssetHelper] getGroupCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
    }
    ALAssetsGroup *group = [ASSETHELPER getGroupAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:[group posterImage]];
    cell.textLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)[group numberOfAssets]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ASSETHELPER.currentGroupIndex = indexPath.row;
    SinglePhotoViewController *picker = [[SinglePhotoViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:picker animated:YES];
}

@end
