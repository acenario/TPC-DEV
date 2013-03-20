//
//  GovLifeViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/27/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "GovLifeViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import <Scringo/ScringoAgent.h>

@interface GovLifeViewController ()

@end

@implementation GovLifeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    NSInteger red   = 178;
    NSInteger green = 8;
    NSInteger blue  = 56;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0];
    
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

#pragma mark - Sidebar Button Code
- (IBAction)searchBtn:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
    
}

- (IBAction)shieldBtn:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
    
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
