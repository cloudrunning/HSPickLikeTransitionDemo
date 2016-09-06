//
//  HSYangTransiton.h
//  KYPresentationControllerDemo
//
//  Created by caozhen@neusoft on 16/9/1.
//  Copyright © 2016年 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSPickLikeTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithBool:(BOOL)isPresenting;

@end
