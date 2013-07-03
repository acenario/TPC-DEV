//
//  AllListsViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/29/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "AllListsViewController.h"
#import "Planner.h"
#import "PlannerItem.h"
#import <Scringo/ScringoAgent.h>

@interface AllListsViewController ()

@end

@implementation AllListsViewController

@synthesize dataModel;
 

 

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.dataModel = [[DataModel alloc] init];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
    int index = [self.dataModel indexOfSelectedPlanner];
    
    if (index >= 0 && index < [self.dataModel.lists count]) {
        
        Planner *planner = [self.dataModel.lists objectAtIndex:index];
        
        [self performSegueWithIdentifier:@"ShowPlanner" sender:planner];
        
    }
 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ScringoAgent pauseSwipe];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goBack
{
    [self.dataModel savePlanners];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)savePlanner {
    [self.dataModel savePlanners];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Planner *planner = [self.dataModel.lists objectAtIndex:indexPath.row];
    UIFont *myFont = [UIFont flatFontOfSize:18];
    UIColor *myColor = [UIColor midnightBlueColor];
    int count = [planner countUncheckedItems];

    cell.textLabel.font = myFont;
    cell.textLabel.textColor = myColor;
    cell.textLabel.text = planner.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.imageView.image = [UIImage imageNamed:planner.iconName];
    
    if ([planner.items count] == 0) {
        cell.detailTextLabel.text = @"(No Items)";
    }
    else if (count == 0) {
        cell.detailTextLabel.text = @"All Done!";
    } else {
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Remaining", [planner countUncheckedItems]];
    }
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel setIndexOfSelectedPlanner:indexPath.row];
    
    Planner *planner = [self.dataModel.lists objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowPlanner" sender:planner];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowPlanner"]) {
        
        PlannerViewController *controller = segue.destinationViewController;
        controller.planner = sender;
    } else if ([segue.identifier isEqualToString:@"AddPlanner"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.plannerToEdit = nil;
    }
}

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingPlanner:(Planner *)planner
{
    [self.dataModel.lists addObject:planner];
    [self.dataModel sortPlanners];
    [self.tableView reloadData];
    
    /*
    int newRowIndex = [self.dataModel.lists count];
    [self.dataModel.lists addObject:planner];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    */
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingPlanner:(Planner *)planner
{
    [self.dataModel sortPlanners];
    [self.tableView reloadData];
    
    /*int index = [self.dataModel.lists indexOfObject:planner];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = planner.name;*/
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    
    controller.delegate = self;
    
    Planner *planner = [self.dataModel.lists objectAtIndex:indexPath.row];
    
    controller.plannerToEdit = planner;
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        [self.dataModel setIndexOfSelectedPlanner:-1];
        
         }
         
}

@end
