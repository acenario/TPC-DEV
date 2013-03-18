//
//  SearchResult.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 3/16/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *place;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *startDate;

- (NSComparisonResult)compareName:(SearchResult *)other;

@end
