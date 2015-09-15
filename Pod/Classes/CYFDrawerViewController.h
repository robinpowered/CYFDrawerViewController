//
//  CYFDrawerViewController.h
//  Pods
//
//  Created by Victor on 9/15/15.
//
//

#import <UIKit/UIKit.h>
@class CYFDrawerViewController;
typedef NS_ENUM(NSUInteger, CYFDrawerViewStatus) {
    CYFDrawerViewStatusClosed,
    CYFDrawerViewStatusOpen,
    CYFDrawerViewStatusOpening,
    CYFDrawerViewStatusClosing
};

@protocol CYFDrawerViewControllerDelegate <NSObject>


@end

@interface CYFDrawerViewController : UIViewController

@property (nonatomic, weak) id<CYFDrawerViewControllerDelegate> delegate;
@property (nonatomic, strong, readonly) UIViewController *mainViewController;
@property (nonatomic, strong, readonly) UIViewController *sideViewController;
@property (nonatomic) CGFloat openRevealDistance;
@property (nonatomic, readonly) CYFDrawerViewStatus status;
@property (nonatomic, strong, readonly) UIScreenEdgePanGestureRecognizer *screenEdgeGesture;
@property (nonatomic, strong, readonly) UISwipeGestureRecognizer *swipeGesture;

- (instancetype)initWithMainViewController:(UIViewController *)mainViewController
                        sideViewController:(UIViewController *)sideViewController;

- (void)openDrawer:(void (^)(void))completionBlock;
- (void)closeDrawer:(void (^)(void))completionBlock;

@end
