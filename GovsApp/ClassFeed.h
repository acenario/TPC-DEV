//
//  ClassFeed.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/14/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "JSONModel.h"
#import "MeetingModel.h"

@interface ClassFeed : JSONModel

@property (strong, nonatomic) NSString* teacher_full_name;
@property (strong, nonatomic) NSString* course;


@property (strong, nonatomic) NSArray<MeetingModel>* meeting_times;


@end
