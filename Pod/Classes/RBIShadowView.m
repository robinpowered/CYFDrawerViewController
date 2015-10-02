//
//  RBIShadowView.m
//  Pods
//
//  Created by Victor on 10/2/15.
//
//

#import "RBIShadowView.h"

@interface RBIShadowLayer : CALayer

@end

@implementation RBIShadowLayer

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

@implementation RBIShadowView

+ (Class)layerClass
{
    return [RBIShadowLayer class];
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
