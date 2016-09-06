//
//  HSYangTransiton.m
//  KYPresentationControllerDemo
//
//  Created by caozhen@neusoft on 16/9/1.
//  Copyright © 2016年 Kitten Yang. All rights reserved.
//

#import "HSPickLikeTransition.h"
#import "HSPickLikePresentedController.h"
@interface HSPickLikeTransition ()
@property (nonatomic,assign) BOOL isPresenting;

@end

@implementation HSPickLikeTransition

- (instancetype)initWithBool:(BOOL)isPresenting {

    if (self = [super init]) {
        self.isPresenting = isPresenting;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    if (self.isPresenting) { // present
        HSPickLikePresentedController *toVC = (HSPickLikePresentedController *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *containView = [transitionContext containerView];
        // 设定presented view 一开始的位置,在屏幕下方
        CGRect finialFrame = [transitionContext finalFrameForViewController:toVC];
        CGRect startFrame = CGRectOffset(finialFrame, 0, finialFrame.size.height);
        toView.frame = startFrame;
        [containView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveLinear animations:^{
            toView.frame = finialFrame;
        } completion:^(BOOL finished) {
            if (finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }
            
        }];
    } else { //dismiss
        
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveLinear animations:^{
            
            CGRect fromViewFinalRect = fromView.frame;
            fromViewFinalRect.origin.y = containerView.frame.size.height;
            fromView.frame = fromViewFinalRect;
            
        } completion:^(BOOL finished) {
            if (finished) {
                [transitionContext completeTransition:![transitionContext transitionWasCancelled] || ![transitionContext isInteractive]];
            }
        }];
    }
}


@end

