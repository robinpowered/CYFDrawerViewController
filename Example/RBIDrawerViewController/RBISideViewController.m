//
//  RBISideViewController.m
//  RBIDrawerViewController
//
//  Created by Victor on 10/2/15.
//  Copyright © 2015 yifeic. All rights reserved.
//

#import "RBISideViewController.h"

@interface RBISideViewController ()

@end

@implementation RBISideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"RBISideViewController viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"RBISideViewController viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"RBISideViewController viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"RBISideViewController viewDidDisappear");
}

@end
