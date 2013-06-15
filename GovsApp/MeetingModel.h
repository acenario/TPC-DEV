//
//  MeetingModel.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/14/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "JSONModel.h"

@protocol MeetingModel @end


@interface MeetingModel : JSONModel

@property (strong, nonatomic) NSString* block_abbreviation;
@property (strong, nonatomic) NSString* day;
@property (strong, nonatomic) NSString* room;







@end
