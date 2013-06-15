//
//  ScheduleResult.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/13/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "ScheduleResult.h"

@implementation ScheduleResult

@synthesize class_fk = _class_fk;

- (NSComparisonResult)compareName:(ScheduleResult *)other
{
    return [self.class_fk localizedStandardCompare:other.class_fk];
}



@end
