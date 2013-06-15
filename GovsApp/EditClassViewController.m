//
//  EditClassViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/14/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "EditClassViewController.h"
#import "JSONModelLib.h"
#import "ClassFeed.h"

@interface EditClassViewController () 

@end

@implementation EditClassViewController {
    ClassFeed* _feed;
    NSString *url;
}

@synthesize idValue;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    url = [NSString stringWithFormat:@"https://api.gda:phevarE3r@api.veracross.com/gda/v1/classes/%@.json", idValue];
    
    //show loader view
    [SVProgressHUD showWithStatus:@"Loading Info"];
    
    //fetch the feed
    _feed = [[ClassFeed alloc] initFromURLWithString:url
                                          completion:^(JSONModel *model, JSONModelError *err) {
                                              
                                              //hide the loader view
                                              [SVProgressHUD dismiss];
                                              
                                              //json fetched
                                              NSLog(@"Class: %@", _feed.course);
                                              NSLog(@"Teacher: %@", _feed.teacher_full_name);
                                              NSLog(@"Meeting Info: %@", _feed.meeting_times);

                                              [self.tableView reloadData];
                                              
                                          }];
    
    

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //NSLog(@"info: %@", idValue);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _feed.meeting_times.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeetingModel* meeting = _feed.meeting_times[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"day: %@ and block: %@ and room: %@", meeting.day, meeting.block_abbreviation, meeting.room];
    
    return cell;
}



@end
