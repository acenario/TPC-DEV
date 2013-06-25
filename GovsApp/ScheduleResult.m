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
@synthesize name = _name;
@synthesize teacher = _teacher;
@synthesize block = _block;


- (NSComparisonResult)compareBlock:(ScheduleResult *)other
{
    return [self.block localizedStandardCompare:other.block];
}



@end
