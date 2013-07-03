//
//  ListDetailViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/29/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Planner.h"
#import <Scringo/ScringoAgent.h>

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController {
    NSString *iconName;
}

@synthesize delegate;
@synthesize plannerToEdit;



- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        iconName = @"Assignments";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ScringoAgent pauseSwipe];

    if (self.plannerToEdit != nil) {
        self.title = @"Edit Category";
        self.textField.text = self.plannerToEdit.name;
        self.doneBarButton.enabled = YES;
        iconName = self.plannerToEdit.iconName;
    }
    
    self.iconImageView.image = [UIImage imageNamed:iconName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel
{
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done
{
    if (self.plannerToEdit == nil) {
        Planner *planner = [[Planner alloc] init];
        planner.name = self.textField.text;
        planner.iconName = iconName;
        
        [self.delegate listDetailViewController:self didFinishAddingPlanner:planner];
        
    } else {
        self.plannerToEdit.name = self.textField.text;
        self.plannerToEdit.iconName = iconName;
        
        [self.delegate listDetailViewController:self didFinishEditingPlanner:self.plannerToEdit];
    }
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return indexPath;
    } else {
        return nil;
    }
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    self.doneBarButton.enabled = ([newText length] > 0);
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickIcon"]) {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName
{
    iconName = theIconName;
    self.iconImageView.image = [UIImage imageNamed:iconName];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
