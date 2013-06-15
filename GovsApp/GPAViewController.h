//
//  GPAViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/12/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPAViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIPickerView *GPAPickerView;
    NSMutableArray *pickerArray;
    
}

@property (nonatomic, retain) IBOutlet UIPickerView *GPAPickerView;
@property (strong, nonatomic) IBOutlet UILabel *class1;
@property (strong, nonatomic) IBOutlet UILabel *class2;
@property (strong, nonatomic) IBOutlet UILabel *class3;
@property (strong, nonatomic) IBOutlet UILabel *class4;
@property (strong, nonatomic) IBOutlet UILabel *class5;
@property (strong, nonatomic) IBOutlet UILabel *class6;
@property (strong, nonatomic) IBOutlet UILabel *GPA;
@property (strong, nonatomic) IBOutlet UILabel *gpaLabel;
- (IBAction)class1Add;
- (IBAction)class2Add;
- (IBAction)class3Add;
- (IBAction)class4Add;
- (IBAction)class5Add;
- (IBAction)class6Add;
- (IBAction)calcGPA:(id)sender;
- (IBAction)goBack;





@end
