//
//  DFBrowserAnimator.m
//  Technology
//
//  Created by user on 3/1/17.
//  Copyright © 2017年 DFF. All rights reserved.
//

#import "DFBrowserAnimator.h"

@implementation DFBrowserAnimator


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.isPresented = YES;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    self.isPresented = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.isPresented) {
        if (!self.presentedDelegate || !self.indexPath) {
            return;
        }
        UIView *presentedView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        UIImageView *imageView = [self.presentedDelegate getImageView:self.indexPath];
        [transitionContext.containerView addSubview:imageView];
        imageView.frame = [self.presentedDelegate getStartRect:self.indexPath];
        transitionContext.containerView.backgroundColor = [UIColor clearColor];
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        
        [UIView animateWithDuration:duration animations:^{
            transitionContext.containerView.backgroundColor = [UIColor blackColor];
            imageView.frame = [self.presentedDelegate getEndRect:self.indexPath];

        } completion:^(BOOL finished) {
            [[transitionContext containerView] addSubview:presentedView];
            [imageView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    }else{
        if (!self.presentedDelegate || !self.dismissDelegate) {
            return;
        }
        UIView *dismissView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        [dismissView removeFromSuperview];
        UIImageView *imageView = [self.dismissDelegate getImageView];
        [transitionContext.containerView addSubview:imageView];
        NSIndexPath *indexPath = [self.dismissDelegate getIndexPath];
        
        CGRect endRect = [self.presentedDelegate getStartRect:indexPath];
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            transitionContext.containerView.backgroundColor = [UIColor clearColor];
            imageView.frame = endRect;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}



@end
