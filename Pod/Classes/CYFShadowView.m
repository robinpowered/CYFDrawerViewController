//
//  CYFShadowView.m
//  Pods
//
//  Created by Victor on 9/15/15.
//
//

#import "CYFShadowView.h"

@interface CYFShadowLayer : CALayer

@end

@implementation CYFShadowLayer

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self updateShadowPath];
}

- (void)updateShadowPath
{
    CGRect shadowPathRect = self.bounds;
    self.shadowPath = [[UIBezierPath bezierPathWithRect:shadowPathRect] CGPath];
}

@end

@implementation CYFShadowView

+ (Class)layerClass
{
    return [CYFShadowLayer class];
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    self.layer.shadowColor = shadowColor.CGColor;
}

- (UIColor *)shadowColor
{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity
{
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)shadowOpacity
{
    return self.layer.shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowRadius
{
    return self.layer.shadowRadius;
}

@end
