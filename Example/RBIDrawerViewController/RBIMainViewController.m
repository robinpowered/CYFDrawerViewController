//
//  RBIMainViewController.m
//  RBIDrawerViewController
//
//  Created by Victor on 10/2/15.
//  Copyright © 2015 yifeic. All rights reserved.
//

#import "RBIMainViewController.h"

@interface RBIMainViewController ()

@end

@implementation RBIMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"RBIMainViewController viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"RBIMainViewController viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"RBIMainViewController viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"RBIMainViewController viewDidDisappear");
}

@end
