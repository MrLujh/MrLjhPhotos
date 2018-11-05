//
//  SiglePhotoCollectionViewCell.h
//  MrLjhPhotosExample
//
//  Created by lujh on 2018/11/5.
//  Copyright © 2018 MeiLCmera. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SiglePhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *numOfSelect;
- (void)selectOfNum:(NSInteger)num;
@end

NS_ASSUME_NONNULL_END
