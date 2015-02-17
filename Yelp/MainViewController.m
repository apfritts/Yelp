//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "BusinessCell.h"
#import "FiltersTableViewController.h"
#import <FontAwesome+iOS/NSString+FontAwesome.h>
#import <FontAwesome+iOS/UIFont+FontAwesome.h>

NSString * const kYelpConsumerKey = @"y8PdBHAl5iPRkOxsBx8dnw";
NSString * const kYelpConsumerSecret = @"bbmW5U3940Lkt0Q0U11hlrciu00";
NSString * const kYelpToken = @"NTf7f_lcyk3tdf7AF3sUcH6lvZrw3vLX";
NSString * const kYelpTokenSecret = @"V-fVdhmlySYLvCygbgeMuiNdYAU";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, FiltersTableViewControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
-(void)searchWithQuery:(NSString *)query andParams:(NSDictionary *)params;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    }
    return self;
}

-(void)searchWithQuery:(NSString *)query andParams:(NSDictionary *)params {
    [self.client searchWithTerm:query withParams:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSArray *businessesDictionary = response[@"businesses"];
        self.businesses = [Business businessesWithDictionaries:businessesDictionary];
        //NSLog(@"%@", businessesDictionary[0]);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup table view
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    
    // Start the search!
    [self searchWithQuery:@"Restaurants" andParams:nil];
    
    // Set tab bar
    /*
    UILabel *filterButtonLabel = [[UILabel alloc] init];
    filterButtonLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:16];
    filterButtonLabel.text = [NSString fontAwesomeIconStringForEnum:FAIconFilter];
    [filterButtonLabel sizeToFit];
    CGSize labelSize = [filterButtonLabel bounds].size;
    [filterButtonLabel setBounds:CGRectMake(0, 0, labelSize.width, labelSize.height)];
    UIView *filterButtonView = [[UIView alloc] init];
    [filterButtonView addSubview:filterButtonLabel];
    [filterButtonView sizeToFit];
    CGSize viewSize = [filterButtonView bounds].size;
    NSLog(@"%f x %f", viewSize.width, viewSize.height);
    //UIBarButtonItem *filterBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString fontAwesomeIconStringForEnum:FAIconGithub] style:UIBarButtonItemStylePlain target:self action:@selector(onFilter)];
    //self.navigationItem.leftBarButtonItem = filterBarButtonItem;
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] init];
    leftBarButton.customView = filterButtonView;
    [leftBarButton.customView sizeToFit];
    self.navigationItem.leftBarButtonItem = leftBarButton;
     */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilter)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(onSearch)];
    
    // Setup the search bar
    UISearchBar *search = [[UISearchBar alloc] init];
    search.text = @"Restaurants";
    search.delegate = self;
    self.navigationItem.titleView = search;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}

-(void)onFilter {
    FiltersTableViewController *ftvc = [[FiltersTableViewController alloc] init];
    ftvc.delegate = self;
    UINavigationController *fnc = [[UINavigationController alloc] initWithRootViewController:ftvc];
    [self presentViewController:fnc animated:YES completion:nil];
}

-(void)filtersTableViewController:(FiltersTableViewController *)ftvc didChangeFilters:(NSDictionary *)filters {
    UISearchBar *searchBar = (UISearchBar *)self.navigationItem.titleView;
    [self searchWithQuery:searchBar.text andParams:filters];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchWithQuery:searchBar.text andParams:nil];
    [searchBar endEditing:YES];
}

-(void)onSearch {
    UISearchBar *searchBar = (UISearchBar *)self.navigationItem.titleView;
    NSString *query = searchBar.text;
    if ([query length] == 0) {
        [searchBar becomeFirstResponder];
    } else {
        [self searchWithQuery:query andParams:nil];
        [searchBar endEditing:YES];
    }
}

@end
