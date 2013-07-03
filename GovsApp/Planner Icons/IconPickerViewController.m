//
//  IconPickerViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/30/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "IconPickerViewController.h"
#import <Scringo/ScringoAgent.h>

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController {
    NSArray *icons;
}

@synthesize delegate;

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
    
    [ScringoAgent pauseSwipe];
    
    //Code for Red Bar
    NSInteger red   = 178;
    NSInteger green = 8;
    NSInteger blue  = 56;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0];
    
    icons = [NSArray arrayWithObjects:
             @"No Icon",
             @"Classes",
             @"Appointments",
             @"Chores",
             @"Email",
             @"Fun",
             @"Groceries",
             @"Photos",
             @"Trips",
             @"Birthdays",
             nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [icons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
                             NSString *icon = [icons objectAtIndex:indexPath.row];
                             cell.textLabel.text = icon;
                             cell.imageView.image = [UIImage imageNamed:icon];
                             return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *iconName = [icons objectAtIndex:indexPath.row];
    [self.delegate iconPicker:self didPickIcon:iconName];
}

@end
