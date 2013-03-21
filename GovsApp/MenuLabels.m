//
//  MenuLabels.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 3/21/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "MenuLabels.h"

@implementation MenuLabels

@synthesize nameLabel = _nameLabel;
@synthesize artworkImageView = _artworkImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
