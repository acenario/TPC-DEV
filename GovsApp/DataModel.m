//
//  DataModel.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/29/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "DataModel.h"
#import "Planner.h"

@implementation DataModel

@synthesize lists;

- (NSString *)documentsDirectory
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
    
}

- (NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Planner.plist"];
    
}

- (void)savePlanners
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:lists forKey:@"Planners"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    
}

- (void)loadPlanners {
    
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        lists = [unarchiver decodeObjectForKey:@"Planners"];
        [unarchiver finishDecoding];
        
    }
    else {
        lists = [[NSMutableArray alloc] initWithCapacity:20];
        
    }
}

- (void)registerDefaults
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:-1], @"PlannerIndex",
                                [NSNumber numberWithBool:YES], @"FirstTime",
                                [NSNumber numberWithBool:YES], @"Shake",
                                [NSNumber numberWithInt:0], @"PlannerItemId",
                                nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (void)handleFirstTime
{
    BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];
                      if (firstTime) {
                          Planner *planner = [[Planner alloc] init];
                          planner.name = @"To-Do";
                          [self.lists addObject:planner];
                          [self setIndexOfSelectedPlanner:0];
                        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];
                     
                      }
    
}



- (id)init
{
    if ((self = [super init])) {
        [self loadPlanners];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

- (int)indexOfSelectedPlanner
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"PlannerIndex"];
}

- (void)setIndexOfSelectedPlanner:(int)index

{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"PlannerIndex"];
    
}

- (void)sortPlanners
{
    [self.lists sortUsingSelector:@selector(compare:)];
}



+ (int)nextPlannerItemId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int itemId = [userDefaults integerForKey:@"PlannerItemId"];
    
    [userDefaults setInteger:itemId + 1 forKey:@"PlannerItemId"];
    [userDefaults synchronize];
    
    return itemId;
}


@end
