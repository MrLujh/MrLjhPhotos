//
//  MrLjhImageManager.h
//  MrLjhPhotosExample
//
//  Created by lujh on 2018/11/5.
//  Copyright © 2018 MeiLCmera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MrLjhALAsset.h"
#import <ImageIO/ImageIO.h>

@interface MrLjhImageManager : NSObject
+ (MrLjhImageManager *)sharedManager;
- (void)clearMem;
- (void)startCahcePhotoThumbWithSize:(CGSize)size;
- (void)thumbWithAsset:(ALAsset *)asset
         resultHandler:(void (^)(UIImage *result))resultHandler;
- (void)imageWithAsset:(ALAsset *)asset
         resultHandler:(void (^)(CGImageRef imageRef, BOOL longImage))resultHandler;
@end


