//
//  ViewController.m
//  MrLjhPhotosExample
//
//  Created by lujh on 2018/11/5.
//  Copyright © 2018 MeiLCmera. All rights reserved.
//

#import "ViewController.h"
#import "PhotoListTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)PushClick:(UIButton *)sender
{
    PhotoListTableViewController *vc = [[PhotoListTableViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
