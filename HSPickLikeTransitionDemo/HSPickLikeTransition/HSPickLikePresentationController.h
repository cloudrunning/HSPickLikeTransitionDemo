//
//  HSPresentationController.h
//  KYPresentationControllerDemo
//
//  Created by caozhen@neusoft on 16/9/1.
//  Copyright © 2016年 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HSPickLikePresentationControllerDataSource <NSObject>

- (CGFloat)heightOfPickLikePresentationController;

@end

@interface HSPickLikePresentationController : UIPresentationController
@property (nonatomic,weak)   id<HSPickLikePresentationControllerDataSource> dataSource;


@end
