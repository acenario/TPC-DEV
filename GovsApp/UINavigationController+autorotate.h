//
//  UINavigationController+autorotate.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/13/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (autoRotate)

-(BOOL)shouldAutorotate;
- (NSUInteger)supportedInterfaceOrientations;

@end