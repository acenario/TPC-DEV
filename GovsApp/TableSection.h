//
//  TableSection.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/27/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableSection : NSObject

@property (nonatomic, copy) NSString* header;
@property (nonatomic, copy) NSArray* rows;

- (NSInteger)numberOfRows;
- (UITableViewCell*)cellInTableView: (UITableView*)tableView forRow: (NSInteger)row;




@end
