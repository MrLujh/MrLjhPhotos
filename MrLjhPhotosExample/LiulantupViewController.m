//
//  LiulantupViewController.m
//  MrLjhPhotosExample
//
//  Created by lujh on 2018/11/5.
//  Copyright © 2018 MeiLCmera. All rights reserved.
//

#import "LiulantupViewController.h"

@interface LiulantupViewController ()

@end

@implementation LiulantupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:self.view.bounds];
    im.contentMode = UIViewContentModeScaleAspectFit;
    im.image = self.imagege;
    [self.view addSubview:im];
}

@end
