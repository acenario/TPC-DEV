//
//  PopupViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 3/19/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "PopupViewController.h"

@interface PopupViewController ()

- (IBAction)close:(id)sender;

@end

@implementation PopupViewController

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
