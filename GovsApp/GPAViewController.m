//
//  GPAViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/12/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "GPAViewController.h"
#import <Scringo/ScringoAgent.h>
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"

@interface GPAViewController () {
    double gpa1;
    double gpa2;
    double gpa3;
    double gpa4;
    double gpa5;
    double gpa6;
    int out;
    BOOL none;
    float points;
    

}

@property (weak, nonatomic) IBOutlet FUIButton *btn1;
@property (weak, nonatomic) IBOutlet FUIButton *btn2;
@property (weak, nonatomic) IBOutlet FUIButton *btn3;
@property (weak, nonatomic) IBOutlet FUIButton *btn4;
@property (weak, nonatomic) IBOutlet FUIButton *btn5;
@property (weak, nonatomic) IBOutlet FUIButton *btn6;
@property (weak, nonatomic) IBOutlet FUIButton *gpaBtn;


@end

@implementation GPAViewController

@synthesize GPAPickerView;
@synthesize class1, class2, class3, class4, class5, class6;
@synthesize GPA, gpaLabel;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [pickerArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    }

-(void)customizeScreen {
    self.btn1.buttonColor = [UIColor alizarinColor];
    self.btn1.shadowColor = [UIColor pomegranateColor];
    self.btn1.shadowHeight = 3.0f;
    self.btn1.cornerRadius = 6.0f;
    self.btn1.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.btn1 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.btn2.buttonColor = [UIColor alizarinColor];
    self.btn2.shadowColor = [UIColor pomegranateColor];
    self.btn2.shadowHeight = 3.0f;
    self.btn2.cornerRadius = 6.0f;
    self.btn2.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.btn2 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.btn3.buttonColor = [UIColor alizarinColor];
    self.btn3.shadowColor = [UIColor pomegranateColor];
    self.btn3.shadowHeight = 3.0f;
    self.btn3.cornerRadius = 6.0f;
    self.btn3.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.btn3 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.btn3.buttonColor = [UIColor alizarinColor];
    self.btn3.shadowColor = [UIColor pomegranateColor];
    self.btn3.shadowHeight = 3.0f;
    self.btn3.cornerRadius = 6.0f;
    self.btn3.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.btn3 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.btn4.buttonColor = [UIColor alizarinColor];
    self.btn4.shadowColor = [UIColor pomegranateColor];
    self.btn4.shadowHeight = 3.0f;
    self.btn4.cornerRadius = 6.0f;
    self.btn4.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.btn4 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.btn4 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.btn5.buttonColor = [UIColor alizarinColor];
    self.btn5.shadowColor = [UIColor pomegranateColor];
    self.btn5.shadowHeight = 3.0f;
    self.btn5.cornerRadius = 6.0f;
    self.btn5.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.btn5 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.btn5 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.btn6.buttonColor = [UIColor alizarinColor];
    self.btn6.shadowColor = [UIColor pomegranateColor];
    self.btn6.shadowHeight = 3.0f;
    self.btn6.cornerRadius = 6.0f;
    self.btn6.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.btn6 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.btn6 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.gpaBtn.buttonColor = [UIColor alizarinColor];
    self.gpaBtn.shadowColor = [UIColor pomegranateColor];
    self.gpaBtn.shadowHeight = 3.0f;
    self.gpaBtn.cornerRadius = 6.0f;
    self.gpaBtn.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.gpaBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.gpaBtn setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    UIFont *myFont = [UIFont flatFontOfSize:17];
    UIColor *myColor = [UIColor cloudsColor];
    UIColor *fontColor = [UIColor wetAsphaltColor];
    
    class1.font = myFont;
    class1.textColor = fontColor;
    class2.font = myFont;
    class2.textColor = fontColor;
    class3.font = myFont;
    class3.textColor = fontColor;
    class4.font = myFont;
    class4.textColor = fontColor;
    class5.font = myFont;
    class5.textColor = fontColor;
    class6.font = myFont;
    class6.textColor = fontColor;
    GPA.font = myFont;
    GPA.textColor = fontColor;
    gpaLabel.font = myFont;
    gpaLabel.textColor = fontColor;
   

    
    self.view.backgroundColor = myColor;
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customizeScreen];
    
    none = YES;
    
    [ScringoAgent pauseSwipe];
    
    pickerArray = [[NSMutableArray alloc] init];
    
    [pickerArray addObject:@"None"];
    [pickerArray addObject:@"A+"];
    [pickerArray addObject:@"A"];
    [pickerArray addObject:@"A-"];
    [pickerArray addObject:@"B+"];
    [pickerArray addObject:@"B"];
    [pickerArray addObject:@"B-"];
    [pickerArray addObject:@"C+"];
    [pickerArray addObject:@"C"];
    [pickerArray addObject:@"C-"];
    [pickerArray addObject:@"D+"];
    [pickerArray addObject:@"D"];
    [pickerArray addObject:@"D-"];
    [pickerArray addObject:@"E"];
    [pickerArray addObject:@"F"];
    
    
    
	// Do any additional setup after loading the view.
}

-(IBAction)goBack
{

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)class1Add {
    NSString *value;
    NSInteger *row;
    row = [GPAPickerView selectedRowInComponent:0];
    value = [pickerArray objectAtIndex:row];
    none = NO;
    if ([class1.text isEqualToString:@"Class 1"]) {
        out += 1;
    }
    
    class1.text = value;
    
    if ([value isEqualToString:@"A+"]) {
        gpa1 = 4.3;
    }
    else if ([value isEqualToString:@"A"]) {
        gpa1 = 4.0;
    }
    else if ([value isEqualToString:@"A-"]) {
        gpa1 = 3.7;
    }
    else if ([value isEqualToString:@"B+"]) {
        gpa1 = 3.3;
    }
    else if ([value isEqualToString:@"B"]) {
        gpa1 = 3.0;
    }
    else if ([value isEqualToString:@"B-"]) {
        gpa1 = 2.7;
    }
    else if ([value isEqualToString:@"C+"]) {
        gpa1 = 2.3;
    }
    else if ([value isEqualToString:@"C"]) {
        gpa1 = 2.0;
    }
    else if ([value isEqualToString:@"C-"]) {
        gpa1 = 1.7;
    }
    else if ([value isEqualToString:@"D+"]) {
        gpa1 = 1.3;
    }
    else if ([value isEqualToString:@"D"]) {
        gpa1 = 1.0;
    }
    else if ([value isEqualToString:@"D-"]) {
        gpa1 = 0.7;
    }
    else if ([value isEqualToString:@"E"]) {
        gpa1 = 0.3;
    }
    else if ([value isEqualToString:@"F"]) {
        gpa1 = 0.0;
    }
    else if ([value isEqualToString:@"None"]) {
        out -= 1;
    }

}

-(IBAction)class2Add {
    NSString *value;
    NSInteger *row;
    row = [GPAPickerView selectedRowInComponent:0];
    value = [pickerArray objectAtIndex:row];
    none = NO;
    if ([class2.text isEqualToString:@"Class 2"]) {
        out += 1;
    }
    
    class2.text = value;
    
    if ([value isEqualToString:@"A+"]) {
        gpa2 = 4.3;
    }
    else if ([value isEqualToString:@"A"]) {
        gpa2 = 4.0;
    }
    else if ([value isEqualToString:@"A-"]) {
        gpa2 = 3.7;
    }
    else if ([value isEqualToString:@"B+"]) {
        gpa2 = 3.3;
    }
    else if ([value isEqualToString:@"B"]) {
        gpa2 = 3.0;
    }
    else if ([value isEqualToString:@"B-"]) {
        gpa2 = 2.7;
    }
    else if ([value isEqualToString:@"C+"]) {
        gpa2 = 2.3;
    }
    else if ([value isEqualToString:@"C"]) {
        gpa2 = 2.0;
    }
    else if ([value isEqualToString:@"C-"]) {
        gpa2 = 1.7;
    }
    else if ([value isEqualToString:@"D+"]) {
        gpa2 = 1.3;
    }
    else if ([value isEqualToString:@"D"]) {
        gpa2 = 1.0;
    }
    else if ([value isEqualToString:@"D-"]) {
        gpa2 = 0.7;
    }
    else if ([value isEqualToString:@"E"]) {
        gpa2 = 0.3;
    }
    else if ([value isEqualToString:@"F"]) {
        gpa2 = 0.0;
    }
    else if ([value isEqualToString:@"None"]) {
        out -= 1;
    }
}

-(IBAction)class3Add {
    NSString *value;
    NSInteger *row;
    row = [GPAPickerView selectedRowInComponent:0];
    value = [pickerArray objectAtIndex:row];
    none = NO;
    if ([class3.text isEqualToString:@"Class 3"]) {
        out += 1;
    }
    
    class3.text = value;
    
    if ([value isEqualToString:@"A+"]) {
        gpa3 = 4.3;
    }
    else if ([value isEqualToString:@"A"]) {
        gpa3 = 4.0;
    }
    else if ([value isEqualToString:@"A-"]) {
        gpa3 = 3.7;
    }
    else if ([value isEqualToString:@"B+"]) {
        gpa3 = 3.3;
    }
    else if ([value isEqualToString:@"B"]) {
        gpa3 = 3.0;
    }
    else if ([value isEqualToString:@"B-"]) {
        gpa3 = 2.7;
    }
    else if ([value isEqualToString:@"C+"]) {
        gpa3 = 2.3;
    }
    else if ([value isEqualToString:@"C"]) {
        gpa3 = 2.0;
    }
    else if ([value isEqualToString:@"C-"]) {
        gpa3 = 1.7;
    }
    else if ([value isEqualToString:@"D+"]) {
        gpa3 = 1.3;
    }
    else if ([value isEqualToString:@"D"]) {
        gpa3 = 1.0;
    }
    else if ([value isEqualToString:@"D-"]) {
        gpa3 = 0.7;
    }
    else if ([value isEqualToString:@"E"]) {
        gpa3 = 0.3;
    }
    else if ([value isEqualToString:@"F"]) {
        gpa3 = 0.0;
    }
    else if ([value isEqualToString:@"None"]) {
        out -= 1;
    }
    
    
}

-(IBAction)class4Add {
    NSString *value;
    NSInteger *row;
    row = [GPAPickerView selectedRowInComponent:0];
    value = [pickerArray objectAtIndex:row];
    none = NO;
    if ([class4.text isEqualToString:@"Class 4"]) {
        out += 1;
    }
    
    class4.text = value;
    
    if ([value isEqualToString:@"A+"]) {
        gpa4 = 4.3;
    }
    else if ([value isEqualToString:@"A"]) {
        gpa4 = 4.0;
    }
    else if ([value isEqualToString:@"A-"]) {
        gpa4 = 3.7;
    }
    else if ([value isEqualToString:@"B+"]) {
        gpa4 = 3.3;
    }
    else if ([value isEqualToString:@"B"]) {
        gpa4 = 3.0;
    }
    else if ([value isEqualToString:@"B-"]) {
        gpa4 = 2.7;
    }
    else if ([value isEqualToString:@"C+"]) {
        gpa4 = 2.3;
    }
    else if ([value isEqualToString:@"C"]) {
        gpa4 = 2.0;
    }
    else if ([value isEqualToString:@"C-"]) {
        gpa4 = 1.7;
    }
    else if ([value isEqualToString:@"D+"]) {
        gpa4 = 1.3;
    }
    else if ([value isEqualToString:@"D-"]) {
        gpa4 = 0.7;
    }
    else if ([value isEqualToString:@"E"]) {
        gpa4 = 0.3;
    }
    else if ([value isEqualToString:@"F"]) {
        gpa4 = 0.0;
    }
    else if ([value isEqualToString:@"None"]) {
        out -= 1;
    }
    
}

-(IBAction)class5Add {
    NSString *value;
    NSInteger *row;
    row = [GPAPickerView selectedRowInComponent:0];
    value = [pickerArray objectAtIndex:row];
    none = NO;
    if ([class5.text isEqualToString:@"Class 5"]) {
        out += 1;
    }
    
    class5.text = value;
    
    if ([value isEqualToString:@"A+"]) {
        gpa5 = 4.3;
    }
    else if ([value isEqualToString:@"A"]) {
        gpa5 = 4.0;
    }
    else if ([value isEqualToString:@"A-"]) {
        gpa5 = 3.7;
    }
    else if ([value isEqualToString:@"B+"]) {
        gpa5 = 3.3;
    }
    else if ([value isEqualToString:@"B"]) {
        gpa5 = 3.0;
    }
    else if ([value isEqualToString:@"B-"]) {
        gpa5 = 2.7;
    }
    else if ([value isEqualToString:@"C+"]) {
        gpa5 = 2.3;
    }
    else if ([value isEqualToString:@"C"]) {
        gpa5 = 2.0;
    }
    else if ([value isEqualToString:@"C-"]) {
        gpa5 = 1.7;
    }
    else if ([value isEqualToString:@"D+"]) {
        gpa5 = 1.3;
    }
    else if ([value isEqualToString:@"D-"]) {
        gpa5 = 0.7;
    }
    else if ([value isEqualToString:@"E"]) {
        gpa5 = 0.3;
    }
    else if ([value isEqualToString:@"F"]) {
        gpa5 = 0.0;
    }
    else if ([value isEqualToString:@"None"]) {
        out -= 1;
    }

    
}

-(IBAction)class6Add {
    NSString *value;
    NSInteger *row;
    row = [GPAPickerView selectedRowInComponent:0];
    value = [pickerArray objectAtIndex:row];
    none = NO;
    if ([class6.text isEqualToString:@"Class 6"]) {
        out += 1;
    }
    
    class6.text = value;
    
    if ([value isEqualToString:@"A+"]) {
        gpa6 = 4.3;
    }
    else if ([value isEqualToString:@"A"]) {
        gpa6 = 4.0;
    }
    else if ([value isEqualToString:@"A-"]) {
        gpa6 = 3.7;
    }
    else if ([value isEqualToString:@"B+"]) {
        gpa6 = 3.3;
    }
    else if ([value isEqualToString:@"B"]) {
        gpa6 = 3.0;
    }
    else if ([value isEqualToString:@"B-"]) {
        gpa6 = 2.7;
    }
    else if ([value isEqualToString:@"C+"]) {
        gpa6 = 2.3;
    }
    else if ([value isEqualToString:@"C"]) {
        gpa6 = 2.0;
    }
    else if ([value isEqualToString:@"C-"]) {
        gpa6 = 1.7;
    }
    else if ([value isEqualToString:@"D+"]) {
        gpa6 = 1.3;
    }
    else if ([value isEqualToString:@"D-"]) {
        gpa6 = 0.7;
    }
    else if ([value isEqualToString:@"E"]) {
        gpa6 = 0.3;
    }
    else if ([value isEqualToString:@"F"]) {
        gpa6 = 0.0;
    }
    else if ([value isEqualToString:@"None"]) {
        out -= 1;
    }
}

-(void)showError {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Error!"
                              //message:@"This is my first app!"
                              message:@"You must enter at least one grade!"
                              delegate:self
                              cancelButtonTitle:@"Check In Here!"
                              otherButtonTitles:nil];
    [alertView show];
    
}

-(void)reset {
    class1.text = @"Class 1";
    class2.text = @"Class 2";
    class3.text = @"Class 3";
    class4.text = @"Class 4";
    class5.text = @"Class 5";
    class6.text = @"Class 6";
    out = 0;
}

- (IBAction)calcGPA:(id)sender {
    float gpa;
    points = 0;
    gpa = 0;
    if (none == NO) {
        points += gpa1;
        points += gpa2;
        points += gpa3;
        points += gpa4;
        points += gpa5;
        points += gpa6;
        gpa = points/out;
        GPA.text = [NSString stringWithFormat:@"%.3f",gpa];
        [self reset];
    } else {
        [self showError];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
