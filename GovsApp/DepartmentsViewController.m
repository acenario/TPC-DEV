//
//  DepartmentsViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/24/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "DepartmentsViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import <Scringo/ScringoAgent.h>

@interface DepartmentsViewController ()

@end

@implementation DepartmentsViewController

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
    
    
    //self.tableView.layer.shadowOpacity = 0.75f;
    //self.tableView.layer.shadowRadius = 10.0f;
    //self.tableView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    NSInteger red   = 178;
    NSInteger green = 8;
    NSInteger blue  = 56;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0];
    
    //self.view.layer.masksToBounds = NO;
    

    
    /* causes lag
     self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;*/
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)searchBtn:(id)sender {
    //[self.slidingViewController anchorTopViewTo:ECLeft];
    [ScringoAgent openSidebar];
    
}

- (IBAction)shieldBtn:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

        
        
    
    
}



- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
