//
//  ViewController.m
//  ClockView
//
//  Created by Yang Chao on 3/26/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
 
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.redView.layer.anchorPoint = CGPointMake(0.5, 1);
}

#pragma mark - Overriden
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CALayer *redViewLayer = self.redView.layer;
//    redViewLayer.anchorPoint = CGPointMake(0.5, 1.0);
    redViewLayer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
}

@end
