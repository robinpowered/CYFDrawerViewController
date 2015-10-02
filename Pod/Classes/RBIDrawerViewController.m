//
//  RBIDrawerViewController.m
//  Pods
//
//  Created by Victor on 10/2/15.
//
//

#import "RBIDrawerViewController.h"
#import "RBIShadowView.h"

@interface RBIDrawerViewController () {
    CGFloat _openRevealDistance;
}

@property (nonatomic, strong) NSLayoutConstraint *sideViewWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *mainViewLeftConstraint;
@property (nonatomic) RBIDrawerViewStatus status;

@end

@implementation RBIDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.mainViewController];
    [self.mainViewController didMoveToParentViewController:self];
    [self addChildViewController:self.sideViewController];
    [self.sideViewController didMoveToParentViewController:self];
    
    UIView *sideView = self.sideViewController.view;
    sideView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:sideView];
    
    RBIShadowView *shadowView = [[RBIShadowView alloc] init];
    shadowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:shadowView];
    
    UIView *mainView = self.mainViewController.view;
    [self.view addSubview:mainView];
    mainView.translatesAutoresizingMaskIntoConstraints = false;
    
    // setup sideView constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sideView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(sideView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[sideView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(sideView)]];
    self.sideViewWidthConstraint = [NSLayoutConstraint constraintWithItem:sideView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.openRevealDistance];
    [sideView addConstraint:self.sideViewWidthConstraint];
    
    // setup shadowView constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[shadowView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(shadowView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:shadowView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:mainView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [shadowView addConstraint:[NSLayoutConstraint constraintWithItem:shadowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80]];
    _shadowView = shadowView;
    self.shadowView.shadowColor = [UIColor blackColor];
    self.shadowView.shadowRadius = 10.0;
    self.shadowView.shadowOpacity = 0.6;
    
    // setup mainView constraints
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
        _status = RBIDrawerViewStatusClosed;
        _openDuration = 0.25;
    }
    return self;
}

- (void)openDrawer:(void (^)(void))completionBlock {
    if (self.status != RBIDrawerViewStatusClosed) {
        return;
    }
    
    self.status = RBIDrawerViewStatusOpening;
    self.mainViewController.view.userInteractionEnabled = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    self.screenEdgeGesture.enabled = NO;
    self.mainViewLeftConstraint.constant = self.openRevealDistance;
    [self.sideViewController beginAppearanceTransition:YES animated:YES];
    [UIView animateWithDuration:self.openDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.status = RBIDrawerViewStatusOpen;
        if (completionBlock) {
            completionBlock();
        }
        self.swipeGesture.enabled = YES;
        [self.sideViewController endAppearanceTransition];
    }];
}

- (void)closeDrawer:(void (^)(void))completionBlock {
    if (self.status != RBIDrawerViewStatusOpen) {
        return;
    }
    self.swipeGesture.enabled = NO;
    self.status = RBIDrawerViewStatusClosing;
    self.mainViewLeftConstraint.constant = 0;
    [self.sideViewController beginAppearanceTransition:NO animated:YES];
    [UIView animateWithDuration:self.openDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.status = RBIDrawerViewStatusClosed;
        if (completionBlock) {
            completionBlock();
        }
        self.screenEdgeGesture.enabled = YES;
        self.mainViewController.view.userInteractionEnabled = YES;
        [self.sideViewController endAppearanceTransition];
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
    if (self.status == RBIDrawerViewStatusClosed) {
        return self.mainViewController;
    }
    return self.sideViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    if (self.status == RBIDrawerViewStatusClosed) {
        return self.mainViewController;
    }
    return self.sideViewController;
}

- (CGFloat)openRevealDistance {
    return _openRevealDistance;
}

- (void)setOpenRevealDistance:(CGFloat)openRevealDistance {
    _openRevealDistance = openRevealDistance;
    if (self.sideViewWidthConstraint) {
        self.sideViewWidthConstraint.constant = openRevealDistance;
    }
}

#pragma mark - Lifecycle

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mainViewController beginAppearanceTransition:YES animated:animated];
    
    if (self.status == RBIDrawerViewStatusOpen) {
        [self.sideViewController beginAppearanceTransition:YES animated:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self.mainViewController endAppearanceTransition];
    
    if (self.status == RBIDrawerViewStatusOpen) {
        [self.sideViewController endAppearanceTransition];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.mainViewController beginAppearanceTransition:NO animated:animated];
    
    if (self.status == RBIDrawerViewStatusOpen) {
        [self.sideViewController beginAppearanceTransition:NO animated:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.mainViewController endAppearanceTransition];
    
    if (self.status == RBIDrawerViewStatusOpen) {
        [self.sideViewController endAppearanceTransition];
    }
}

@end
