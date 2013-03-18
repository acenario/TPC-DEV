//
//  SearchResult.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 3/16/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

@synthesize name = _name;
@synthesize place = _place;
@synthesize time = _time;
@synthesize startDate = _startDate;


- (NSComparisonResult)compareName:(SearchResult *)other
{
    return [self.startDate localizedStandardCompare:other.startDate];
}


@end
