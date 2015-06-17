//
//  MoviceViewController.m
//  RottenTomatoes
//
//  Created by Dan Weng on 6/16/15.
//  Copyright (c) 2015 com.danweng. All rights reserved.
//

#import "MoviceViewController.h"
#import "MyMovie.h"
#import <UIImageView+AFNetworking.h>
#import "ViewController.h"
#import <SVProgressHUD.h>

@interface MoviceViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIView *sectionHeaderView;

@end

@implementation MoviceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self getMoviesData];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableview addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    //[self checkConnection];
    /*
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:10
        target:self selector:@selector(checkConnection)
        userInfo:nil repeats:YES];
     */
}

- (void)refreshTable {
    [self.refreshControl endRefreshing];
    [self getMoviesData];
    //[self checkConnection];
}

-(void)checkConnection{
    NSURL *scriptUrl = [NSURL URLWithString:@"https://tw.yahoo.com/"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];

    if (data){
        [self hideConnectionWarn];
    }else{
        [self showConnectionWarn];
    }
}

-(void)getMoviesData{
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=7ue5rxaj9xn4mhbmsuexug54&limit=20";
    
    [SVProgressHUD show];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError){
         if(connectionError == nil){
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             self.movies = dict[@"movies"];
             [self.tableview reloadData];
             [self hideConnectionWarn];
         }else{
             [self showConnectionWarn];
         }
         [SVProgressHUD dismiss];
         
     }];

}

-(void)hideConnectionWarn{
 [self.sectionHeaderView setHidden:YES];
}

-(void)showConnectionWarn{
    self.sectionHeaderView = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 0, self.tableview.frame.size.width, 40.0)];
    self.sectionHeaderView.backgroundColor = [UIColor yellowColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(5, 5, self.sectionHeaderView.frame.size.width, 25.0)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.text = @"⚠️Network Error";
    [headerLabel setFont:[UIFont fontWithName:@"Verdana" size:20.0]];
    [self.sectionHeaderView addSubview:headerLabel];
    [self.tableview addSubview:self.sectionHeaderView];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyMovie *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMovieCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];

    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    NSString *postUrl = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterImg setImageWithURL:[NSURL URLWithString:postUrl]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MyMovie *cell = sender;
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    NSDictionary *movie = self.movies[indexPath.row];
    
    ViewController *destVC = segue.destinationViewController;
    destVC.movie = movie;
}

@end
