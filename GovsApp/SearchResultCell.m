//
//  SearchResultCell.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 3/16/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

@synthesize nameLabel = _nameLabel;
@synthesize placeLabel = _placeLabel;
@synthesize timeLabel = _timeLabel;
@synthesize dateLabel = _dateLabel;



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
