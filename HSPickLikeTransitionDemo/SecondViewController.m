//
//  SecondViewController.m
//  HSPickLikeTransitionDemo
//
//  Created by caozhen@neusoft on 16/9/5.
//  Copyright © 2016年 Neusoft. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (CGFloat)heightOfPickLikePresentationController {
    return 100;
}

@end
