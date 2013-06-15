//
//  EditClassViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/14/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditClassViewControllerDelegate <NSObject>
@end

@interface EditClassViewController : UITableViewController

@property (nonatomic, strong) NSString *idValue;
@property (nonatomic, strong) id <EditClassViewControllerDelegate> delegate;

@end
