//
//  ScheduleResultCell.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/14/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "ScheduleResultCell.h"


@implementation ScheduleResultCell 
@synthesize nameLabel = _nameLabel;
@synthesize idLabel = _idLabel;
@synthesize blockLabel = _blockLabel;
@synthesize teacherLabel = _teacherLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImage *image = [UIImage imageNamed:@"TableCellGradient"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:image];
    self.backgroundView = backgroundImageView;
    
    UIImage *image2 = [UIImage imageNamed:@"selectedGradient"];
    UIImageView *selectedBackgroundImageView = [[UIImageView alloc] initWithImage:image2];
    self.selectedBackgroundView = selectedBackgroundImageView;
    
    //_nameLabel.text = @"Hello";
  
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
