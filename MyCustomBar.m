//
//  MyCustomBar.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 3/14/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "MyCustomBar.h"

@implementation MyCustomBar

-(void) drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed: @"navbar2.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
