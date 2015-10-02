//
//  RBIViewController.m
//  RBIDrawerViewController
//
//  Created by yifeic on 10/02/2015.
//  Copyright (c) 2015 yifeic. All rights reserved.
//

#import "RBIViewController.h"
#import "RBIDrawerViewController.h"
#import "RBIMainViewController.h"
#import "RBISideViewController.h"

@interface RBIViewController ()

@end

@implementation RBIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    RBIMainViewController *main = [RBIMainViewController new];
    RBISideViewController *side = [RBISideViewController new];
    
    RBIDrawerViewController *drawer = [[RBIDrawerViewController alloc] initWithMainViewController:main sideViewController:side];
    
    
    [self addChildViewController:drawer];
    UIView *drawerView = drawer.view;
    drawerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:drawerView];
    [drawer didMoveToParentViewController:self];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[drawerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(drawerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[drawerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(drawerView)]];

}

@end
