//
//  MyMovie.h
//  RottenTomatoes
//
//  Created by Dan Weng on 6/16/15.
//  Copyright (c) 2015 com.danweng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMovie : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end
