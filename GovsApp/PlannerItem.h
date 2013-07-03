//
//  PlannerItem.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/26/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlannerItem : NSObject <NSCoding>

- (void)toggleChecked;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, copy) NSDate *dueDate;
@property (nonatomic, assign) BOOL shouldRemind;
@property (nonatomic, assign) int itemId;
@property (nonatomic, assign) BOOL toDelete;

- (void)scheduleNotification;

@end
