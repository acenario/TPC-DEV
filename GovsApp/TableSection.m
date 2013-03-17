//
//  TableSection.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/27/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "TableSection.h"

@implementation TableSection

@synthesize header;
@synthesize rows;

- (NSInteger)numberOfRows {
    return rows.count;
}

- (UITableViewCell*)cellInTableView: (UITableView*)tableView forRow: (NSInteger)row {
    // create/reuse, setup and return a UITableViewCell
    return nil;
}


@end
