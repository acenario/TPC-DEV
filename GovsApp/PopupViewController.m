//
//  PopupViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 3/19/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "PopupViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ComingSoonViewController.h"

@interface PopupViewController ()

- (IBAction)close:(id)sender;

@property (nonatomic, weak) IBOutlet UIView *backgroundView;
@property (nonatomic, weak) IBOutlet UIButton *closeButton;

@end

@implementation PopupViewController {
    ComingSoonViewController *comingSoon;
}

@synthesize backgroundView = _backgroundView;
@synthesize closeButton = _closeButton;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.backgroundView.layer.borderWidth = 3.0f;
    self.backgroundView.layer.cornerRadius = 10.0f;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)close:(id)sender
{
    [self dismissFromParentViewController];
}

- (void)dismissFromParentViewController
{
    [self willMoveToParentViewController:nil];
    [UIView animateWithDuration:0.4 animations:^
     {
         CGRect rect = self.view.bounds;
         rect.origin.y += rect.size.height;
         self.view.frame = rect;
         comingSoon.alpha = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         [self.view removeFromSuperview];
         [comingSoon removeFromSuperview];
         [self removeFromParentViewController];
     }];
}

-(void)layoutForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    CGRect rect = self.closeButton.frame;
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        rect.origin = CGPointMake(28, 87);
    } else {
        rect.origin = CGPointMake(108, 7);
    }
    self.closeButton.frame = rect;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self layoutForInterfaceOrientation:toInterfaceOrientation];
}

- (void)presentInParentViewController:(UIViewController *)parentViewController
{
    comingSoon = [[ComingSoonViewController alloc]initWithFrame:parentViewController.view.bounds];
    [parentViewController.view addSubview:comingSoon];
    
    //self.view.frame = parentViewController.view.bounds;
    [self layoutForInterfaceOrientation:parentViewController.interfaceOrientation];
    [parentViewController.view addSubview:self.view];
    [parentViewController addChildViewController:self];
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.duration = 0.4;
    bounceAnimation.delegate = self;
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.7f],
                              [NSNumber numberWithFloat:1.2f],
                              [NSNumber numberWithFloat:0.9f],
                              [NSNumber numberWithFloat:1.0f],
                              nil];
    bounceAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.0f],
                                [NSNumber numberWithFloat:0.334f],
                                [NSNumber numberWithFloat:0.666f],
                                [NSNumber numberWithFloat:1.0f],
                                nil];
    bounceAnimation.timingFunctions = [NSArray arrayWithObjects:
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       nil];
    [self.view.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    fadeAnimation.duration = 0.1;
    [comingSoon.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self didMoveToParentViewController:self.parentViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
