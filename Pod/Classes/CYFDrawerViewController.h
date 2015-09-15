//
//  CYFDrawerViewController.h
//  Pods
//
//  Created by Victor on 9/15/15.
//
//

#import <UIKit/UIKit.h>
#import "CYFShadowView.h"

typedef NS_ENUM(NSUInteger, CYFDrawerViewStatus) {
    CYFDrawerViewStatusClosed,
    CYFDrawerViewStatusOpen,
    CYFDrawerViewStatusOpening,
    CYFDrawerViewStatusClosing
};

@interface CYFDrawerViewController : UIViewController

@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, strong) UIViewController *sideViewController;
@property (nonatomic) CGFloat openRevealDistance;
@property (nonatomic, readonly) CYFDrawerViewStatus status;
@property (nonatomic, strong, readonly) CYFShadowView *shadowView;
@property (nonatomic, strong, readonly) UIScreenEdgePanGestureRecognizer *screenEdgeGesture;
@property (nonatomic, strong, readonly) UISwipeGestureRecognizer *swipeGesture;

- (instancetype)initWithMainViewController:(UIViewController *)mainViewController
                        sideViewController:(UIViewController *)sideViewController;

- (void)openDrawer:(void (^)(void))completionBlock;
- (void)closeDrawer:(void (^)(void))completionBlock;

@end
