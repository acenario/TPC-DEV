//
//  Location.m
//  GovsApp
//
//  Created by William Nee on 2/25/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "Location.h"


@implementation Location

@dynamic latitude;
@dynamic longitude;
@dynamic date;
@dynamic locationDescription;
@dynamic category;
@dynamic placemark;

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self. longitude doubleValue]);
}
- (NSString *)title
{
    if ([self.locationDescription length] > 0) {
        return self.locationDescription;
    } else {
        return @"(No Description)";
    } }
- (NSString *)subtitle
{
    return self.category;
}

@end
