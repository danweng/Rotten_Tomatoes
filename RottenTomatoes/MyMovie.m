//
//  MyMovie.m
//  RottenTomatoes
//
//  Created by Dan Weng on 6/16/15.
//  Copyright (c) 2015 com.danweng. All rights reserved.
//

#import "MyMovie.h"

@implementation MyMovie

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse{
    [super prepareForReuse];
    self.posterImg.image = nil;
}

@end
