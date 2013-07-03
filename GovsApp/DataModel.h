//
//  DataModel.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/29/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

- (void)savePlanners;
- (int)indexOfSelectedPlanner;
- (void)setIndexOfSelectedPlanner:(int)index;
- (void)sortPlanners;

+ (int)nextPlannerItemId;


@end