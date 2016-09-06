//
//  HSPresentationController.m
//  KYPresentationControllerDemo
//
//  Created by caozhen@neusoft on 16/9/1.
//  Copyright © 2016年 Kitten Yang. All rights reserved.
//
#define frameOffset 200
#import "HSPickLikePresentationController.h"

@interface HSPickLikePresentationController ()

// 转场调度器
@property (nonatomic,strong) id<UIViewControllerTransitionCoordinator>transitonCorrdinator;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIVisualEffectView *blurView;


@end

@implementation HSPickLikePresentationController

// 增加蒙版
- (void)presentationTransitionWillBegin {
    
    self.bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.blurView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.blurView.frame = self.containerView.bounds;
    
    [self.bgView insertSubview:self.blurView atIndex:0];
    
    UIView *containerView = self.containerView;
    [containerView addSubview:self.bgView];
    [containerView addSubview:self.presentedView];
    
    self.transitonCorrdinator = self.presentingViewController.transitionCoordinator;
    
    self.bgView.alpha = 0.0;
    [self.transitonCorrdinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  context) {
        self.bgView.alpha = 0.7;
    } completion:nil];
}

// present失败 移除蒙版
- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [self.bgView removeFromSuperview];
    }
}
- (void)dismissalTransitionWillBegin {
    self.transitonCorrdinator = self.presentingViewController.transitionCoordinator;
    [self.transitonCorrdinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.bgView.alpha = 0;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
        
    } completion:nil];

}

// dismiss 完成移除蒙版，并将presentingVC增加到keyWindow上(疑似UIPresentionViewController自有bug)
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    
    if (completed) {
        [self.bgView removeFromSuperview];
    }
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.presentingViewController.view];

}

- (BOOL)shouldRemovePresentersView {
    return NO;
}

- (CGRect)frameOfPresentedViewInContainerView {
    if (!self.dataSource) {
        @throw [NSException exceptionWithName:@"HSError" reason:@"HSPickLikePresentationController的dataSource不能为空" userInfo:nil];
        return CGRectZero;
    };
    
    if (![self.dataSource respondsToSelector:@selector(heightOfPickLikePresentationController)]) {
        @throw [NSException exceptionWithName:@"HSError" reason:@"heightOfPickLikePresentationController未实现" userInfo:nil];
        return CGRectZero;
    }
    
    CGFloat height = [self.dataSource heightOfPickLikePresentationController];
    CGRect rect1 = self.containerView.bounds;
    CGFloat yoffset = rect1.size.height - height;
    return CGRectMake(rect1.origin.x, rect1.origin.y + yoffset, rect1.size.width, height);
}

//调整presented的圆角效果
- (UIView *)presentedView{
    
    UIView *pretedView = self.presentedViewController.view;
//    pretedView.layer.cornerRadius = 8.0f;
    return pretedView;
}

@end
