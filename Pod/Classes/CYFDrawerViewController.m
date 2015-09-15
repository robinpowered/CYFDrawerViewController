//
//  CYFDrawerViewController.m
//  Pods
//
//  Created by Victor on 9/15/15.
//
//

#import "CYFDrawerViewController.h"

@interface CYFDrawerViewController ()
@property (nonatomic, strong) NSLayoutConstraint *sideViewWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *mainViewLeftConstraint;
@end

@implementation CYFDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewController:self.mainViewController];
    [self.mainViewController didMoveToParentViewController:self];
    [self addChildViewController:self.sideViewController];
    [self.sideViewController didMoveToParentViewController:self];
    
    // setup sideView constraints
    UIView *sideView = self.sideViewController.view;
    sideView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:sideView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sideView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(sideView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[sideView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(sideView)]];
    self.sideViewWidthConstraint = [NSLayoutConstraint constraintWithItem:sideView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.openRevealDistance];
    [sideView addConstraint:self.sideViewWidthConstraint];
    
    // setup mainView constraints
    UIView *mainView = self.mainViewController.view;
    [self.view addSubview:mainView];
    mainView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(mainView)]];
    self.mainViewLeftConstraint = [NSLayoutConstraint constraintWithItem:mainView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.view addConstraint:self.mainViewLeftConstraint];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:mainView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    _screenEdgeGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeFromEdge)];
    self.screenEdgeGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.screenEdgeGesture];
    
    _swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToClose)];
    self.swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.swipeGesture];
    self.swipeGesture.enabled = NO;
}

- (instancetype)init
{
    self = [self initWithMainViewController:nil sideViewController:nil];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithMainViewController:(UIViewController *)mainViewController
                        sideViewController:(UIViewController *)sideViewController
{
    self = [super init];
    if (self) {
        _mainViewController = mainViewController;
        _sideViewController = sideViewController;
        _openRevealDistance = 267;
        _status = CYFDrawerViewStatusClosed;
    }
    return self;
}

- (void)openDrawer:(void (^)(void))completionBlock {
    if (self.status != CYFDrawerViewStatusClosed) {
        return;
    }
    
    _status = CYFDrawerViewStatusOpening;
    [self setNeedsStatusBarAppearanceUpdate];
    self.screenEdgeGesture.enabled = NO;
    self.mainViewLeftConstraint.constant = self.openRevealDistance;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        _status = CYFDrawerViewStatusOpen;
        if (completionBlock) {
            completionBlock();
        }
        self.swipeGesture.enabled = YES;
    }];
}

- (void)closeDrawer:(void (^)(void))completionBlock {
    if (self.status != CYFDrawerViewStatusOpen) {
        return;
    }
    self.swipeGesture.enabled = NO;
    _status = CYFDrawerViewStatusClosing;
    self.mainViewLeftConstraint.constant = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        _status = CYFDrawerViewStatusClosed;
        if (completionBlock) {
            completionBlock();
        }
        self.screenEdgeGesture.enabled = YES;
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
}

- (void)swipeFromEdge {
    [self openDrawer:nil];
}

- (void)swipeToClose {
    [self closeDrawer:nil];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    if (self.status == CYFDrawerViewStatusClosed) {
        return self.mainViewController;
    }
    return self.sideViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    if (self.status == CYFDrawerViewStatusClosed) {
        return self.mainViewController;
    }
    return self.sideViewController;
}

@end
