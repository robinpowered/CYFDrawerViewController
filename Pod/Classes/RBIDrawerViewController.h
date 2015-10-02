//
//  RBIDrawerViewController.h
//  Pods
//
//  Created by Victor on 10/2/15.
//
//

#import <UIKit/UIKit.h>
#import "RBIShadowView.h"

typedef NS_ENUM(NSUInteger, RBIDrawerViewStatus) {
    RBIDrawerViewStatusClosed,
    RBIDrawerViewStatusOpen,
    RBIDrawerViewStatusOpening,
    RBIDrawerViewStatusClosing
};

@interface RBIDrawerViewController : UIViewController

@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, strong) UIViewController *sideViewController;
@property (nonatomic) CGFloat openRevealDistance;
@property (nonatomic) NSTimeInterval openDuration;
@property (nonatomic, readonly) RBIDrawerViewStatus status;
@property (nonatomic, strong, readonly) RBIShadowView *shadowView;
@property (nonatomic, strong, readonly) UIScreenEdgePanGestureRecognizer *screenEdgeGesture;
@property (nonatomic, strong, readonly) UISwipeGestureRecognizer *swipeGesture;

- (instancetype)initWithMainViewController:(UIViewController *)mainViewController
                        sideViewController:(UIViewController *)sideViewController;

- (void)openDrawer:(void (^)(void))completionBlock;
- (void)closeDrawer:(void (^)(void))completionBlock;

@end
