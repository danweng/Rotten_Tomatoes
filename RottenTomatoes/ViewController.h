//
//  ViewController.h
//  RottenTomatoes
//
//  Created by Dan Weng on 6/15/15.
//  Copyright (c) 2015 com.danweng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *PosterImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@property(strong, nonatomic) NSDictionary *movie;

@end

