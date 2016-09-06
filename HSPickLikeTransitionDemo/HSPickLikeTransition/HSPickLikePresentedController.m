//
//  HSPickLikePresentedController.m
//  KYPresentationControllerDemo
//
//  Created by caozhen@neusoft on 16/9/5.
//  Copyright © 2016年 Kitten Yang. All rights reserved.
//

#import "HSPickLikePresentedController.h"
#import "HSPickLikeTransition.h"

@interface HSPickLikePresentedController (){
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
    CGFloat percent;
}


@end

@implementation HSPickLikePresentedController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
    [self.view addGestureRecognizer:pan];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;
        
    }
    return self;
}


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate  = self;
        
    }
    return self;
}

-(void)panGes:(UIPanGestureRecognizer *)gesture{
    CGFloat yOffset = [gesture translationInView:self.view].y;
    percent =  yOffset / 1800;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        //这句必须加上！！
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        [percentDrivenInteractiveTransition updateInteractiveTransition:percent];
    }else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded){
        [percentDrivenInteractiveTransition finishInteractiveTransition];

        //这句也必须加上！！
        percentDrivenInteractiveTransition = nil;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
// SourceViewController 与 PresentedViewController 之间夹的controlller,用来添加模板等操作
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    HSPickLikePresentationController *presentation = [[HSPickLikePresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    presentation.dataSource = self;
    return presentation;
}

// present 动画
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    HSPickLikeTransition * present = [[HSPickLikeTransition alloc]initWithBool:YES];
    return present;
}

// dismiss动画
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    if (dismissed) {
        HSPickLikeTransition * present = [[HSPickLikeTransition alloc]initWithBool:NO];
        
        return present;
    }else{
        return nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    if (animator) {
        return percentDrivenInteractiveTransition;
    }else{
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)heightOfPickLikePresentationController {
    return 0;
}

@end
