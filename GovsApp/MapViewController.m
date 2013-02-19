//
//  MapViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/13/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "MapViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"


@interface MapViewController ()

@end

@implementation MapViewController

@synthesize govBtn; //Not needed on Mountain Lion





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)screenUpdate {
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    UINavigationBar *naviBarObj = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    [self.view addSubview:naviBarObj];
    
    NSInteger red   = 178;
    NSInteger green = 8;
    NSInteger blue  = 56;
    
    
    [naviBarObj setTintColor:[UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0]];
    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:@"Governors"];
    naviBarObj.items = [NSArray arrayWithObjects: navigItem,nil];
    
    self.govBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    govBtn.frame = CGRectMake(8, 10, 34, 24);
    [govBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [govBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.govBtn];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self screenUpdate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self screenUpdate];
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    
    
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}



/*#pragma mark - Logout button handler

- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
}*/

@end
