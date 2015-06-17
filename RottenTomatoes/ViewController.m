//
//  ViewController.m
//  RottenTomatoes
//
//  Created by Dan Weng on 6/15/15.
//  Copyright (c) 2015 com.danweng. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+AFNetworking.h>

@interface ViewController ()


//http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=7ue5rxaj9xn4mhbmsuexug54&limit=20

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    NSString *posterUrl = [self.movie valueForKeyPath:@"posters.detailed"];
    posterUrl = [self convertPosterUrlStringToHighRes:posterUrl];
    [self.PosterImg setImageWithURL:[NSURL URLWithString:posterUrl]];
    
    
    //[self getMoviceData];

}

- (NSString *)convertPosterUrlStringToHighRes:(NSString *)urlString{
    NSRange range = [urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue = urlString;
    if(range.length > 0){
        returnValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    return returnValue;
}

/*
- (void)getMoviceData{
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=7ue5rxaj9xn4mhbmsuexug54&limit=20";
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError){
         id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         
     }];
}
*/
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
