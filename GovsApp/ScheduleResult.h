//
//  ScheduleResult.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/13/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleResult : NSObject

@property (nonatomic, copy) NSString *class_fk;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *teacher;
@property (nonatomic, copy) NSString *block;




- (NSComparisonResult)compareBlock:(ScheduleResult *)other;



@end
