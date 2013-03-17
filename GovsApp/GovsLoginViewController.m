//
//  GovsLoginViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/13/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "GovsLoginViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GovsLoginViewController ()

@end

@implementation GovsLoginViewController

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
	
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"govs_dashboard-header.png"]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
