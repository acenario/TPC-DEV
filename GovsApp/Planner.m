//
//  Planner.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/29/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "Planner.h"
#import "PlannerItem.h"

@implementation Planner

@synthesize name, items, iconName;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
        self.iconName = [aDecoder decodeObjectForKey:@"IconName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
}

- (id)init
{
    if ((self = [super init])) {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
        self.iconName = @"No Icon";
    }
    return self;
}

- (int)countUncheckedItems
{
    int count = 0;
    for (PlannerItem *item in self.items) {
        if (!item.checked) {
            count += 1;
        }
    }
    return count;
}



- (NSComparisonResult)compare:(Planner *)otherPlanner
{
    return [self.name localizedStandardCompare:otherPlanner.name];
}

@end
