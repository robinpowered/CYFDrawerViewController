//
//  CYFViewController.m
//  CYFDrawerViewController
//
//  Created by yifeic on 09/15/2015.
//  Copyright (c) 2015 yifeic. All rights reserved.
//

#import "CYFViewController.h"
#import "CYFMainViewController.h"
#import "CYFSideViewController.h"
#import "CYFDrawerViewController.h"

@interface CYFViewController ()

@end

@implementation CYFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CYFMainViewController *main = [CYFMainViewController new];
    CYFSideViewController *side = [CYFSideViewController new];
    
    CYFDrawerViewController *drawer = [[CYFDrawerViewController alloc] initWithMainViewController:main sideViewController:side];
    
    
    [self addChildViewController:drawer];
    [drawer didMoveToParentViewController:self];
    
    UIView *drawerView = drawer.view;
    drawerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:drawerView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[drawerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(drawerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[drawerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(drawerView)]];
}


@end
