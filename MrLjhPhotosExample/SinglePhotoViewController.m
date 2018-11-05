//
//  SinglePhotoViewController.m
//  MrLjhPhotosExample
//
//  Created by lujh on 2018/11/5.
//  Copyright © 2018 MeiLCmera. All rights reserved.
//

#import "SinglePhotoViewController.h"
#import "MrLjhALAsset.h"
#import "MrLjhImageManager.h"
#import <ImageIO/ImageIO.h>
#import "LiulantupViewController.h"
#import "SiglePhotoCollectionViewCell.h"

@interface SinglePhotoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation SinglePhotoViewController{
    UICollectionView *photosList;
    NSInteger currentIndex;
    BOOL scrollToToping;
    NSTimer *timer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{

    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.text = @"照片库";
    label.font = [UIFont systemFontOfSize:17];
    [label sizeToFit];
    self.navigationItem.titleView = label;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = cancel;
   
}

-(void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationItem.title = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (UICollectionView *)collectionView{
    return photosList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 3;
    NSInteger size = [UIScreen mainScreen].bounds.size.width/4-1;
    if (size%2!=0) {
        size-=1;
    }
    flowLayout.itemSize = CGSizeMake(size, size);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    photosList = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    photosList.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    photosList.scrollIndicatorInsets = photosList.contentInset;
    photosList.delegate = self;
    photosList.dataSource = self;
    photosList.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:photosList];
    [photosList registerClass:[SiglePhotoCollectionViewCell class] forCellWithReuseIdentifier:@"imagePickerCell"];
    [ASSETHELPER getPhotoListOfGroupByIndex:ASSETHELPER.currentGroupIndex result:^(NSArray *r) {
        [[MrLjhImageManager sharedManager] startCahcePhotoThumbWithSize:CGSizeMake(size, size)];
        [photosList reloadData];
        
        for (NSDictionary *dict in ASSETHELPER.selectdPhotos) {
            NSArray *temp = [[[dict allKeys] firstObject] componentsSeparatedByString:@"-"];
            NSInteger row = [temp[0] integerValue];
            NSInteger group = [temp[1] integerValue];
            if (group==ASSETHELPER.currentGroupIndex) {
                [photosList scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
                break;
            }
        }
    }];
    
    // 获得相册首张图片
   // [self huodexiangceshougetupian];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [ASSETHELPER getPhotoCountOfCurrentGroup];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SiglePhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagePickerCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.tag = indexPath.item;
    ALAsset *asset = [ASSETHELPER getAssetAtIndex:indexPath.row];
    
    [[MrLjhImageManager sharedManager] thumbWithAsset:asset resultHandler:^(UIImage *result) {
        
        cell.imageView.image = result;
    }];
   
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    ALAsset *asset = [ASSETHELPER getAssetAtIndex:indexPath.row];
    
    [[MrLjhImageManager sharedManager] imageWithAsset:asset resultHandler:^(CGImageRef imageRef, BOOL longImage) {
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            LiulantupViewController *vc = [[LiulantupViewController alloc] init];
            vc.imagege = image;
            
            [self.navigationController pushViewController:vc animated:YES];
        });
    }];
    
   
}

-(void)huodexiangceshougetupian{
    
    [ASSETHELPER getPhotoListOfGroupByIndex:ASSETHELPER.currentGroupIndex result:^(NSArray *r) {
        
        
    }];
    
    
    ALAsset *asset = [ASSETHELPER getAssetAtIndex:0];
    
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:self.view.bounds];
    im.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:im];
    
    [[MrLjhImageManager sharedManager] imageWithAsset:asset resultHandler:^(CGImageRef imageRef, BOOL longImage) {
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            im.image = image;
        });
    }];
}

@end
