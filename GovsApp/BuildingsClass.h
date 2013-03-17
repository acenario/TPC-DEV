//
//  BuildingsClass.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/28/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/MKAnnotation.h>

@interface BuildingsClass : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    UIImage *image;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, retain) UIImage *image;


@end
