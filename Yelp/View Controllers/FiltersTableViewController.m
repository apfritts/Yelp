//
//  FiltersTableViewController.m
//  Yelp
//
//  Created by AP Fritts on 2/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FiltersTableViewController.h"
#import "FilterCell.h"
#import "PriceCell.h"
#import "HeaderView.h"
#import "SortCell.h"
#import "Filters.h"

@interface FiltersTableViewController () <FilterCellDelegate, SortCellDelegate>

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *sortOrders;
@property (nonatomic, strong) NSMutableSet *selectedCategories;
@property (nonatomic, strong) SortCell *selectedSortMethod;
@property (nonatomic, assign) NSInteger selectedSortMethodId;

@end

@implementation FiltersTableViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initData];
        self.selectedCategories = [NSMutableSet set];
        self.selectedSortMethodId = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApply)];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FilterCell" bundle:nil] forCellReuseIdentifier:@"FilterCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PriceCell" bundle:nil] forCellReuseIdentifier:@"PriceCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SortCell" bundle:nil] forCellReuseIdentifier:@"SortCell"];
}

-(void)onCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)onApply {
    if (self.delegate != nil) {
        [self.delegate filtersTableViewController:self didChangeFilters:[Filters filter]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        default:
            return self.categories.count;
            break;
    }
}

/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderView *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HeaderView"];
    if (section == 0) {
        [view setLabelTitle:@"Price"];
    } else {
        [view setLabelTitle:@"Category"];
    }
    return view;
}
*/

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Price";
            break;
        case 1:
            return @"Sort";
            break;
        default:
            return @"Categories";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return [self.tableView dequeueReusableCellWithIdentifier:@"PriceCell"];
            break;
        case 1:
        {
            SortCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SortCell"];
            [cell setTitle:self.sortOrders[indexPath.row]];
            if (indexPath.row == [Filters sortMethod]) {
                [cell setOn:YES];
                self.selectedSortMethod = cell;
            }
            cell.delegate = self;
            return cell;
            break;
        }
        default:
        {
            FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
            [cell setTitle:self.categories[indexPath.row][@"name"] ];
            [cell setOn:[Filters containsCategory:self.categories[indexPath.row]] animated:NO];
            cell.delegate = self;
            return cell;
            break;
        }
    }
}

-(void)filterCell:(FilterCell *)filterCell didChangeValue:(BOOL)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:filterCell];
    if (value) {
        [self.selectedCategories addObject:self.categories[indexPath.row]];
        [Filters addCategory:self.categories[indexPath.row]];
    } else {
        [self.selectedCategories removeObject:self.categories[indexPath.row]];
    }
}

-(void)sortCell:(SortCell *)sortCell isSelected:(BOOL)selected {
    if (self.selectedSortMethod != nil) {
        [self.selectedSortMethod setOn:NO];
    }
    self.selectedSortMethodId = [self.tableView indexPathForCell:sortCell].row;
    self.selectedSortMethod = sortCell;
}

-(void)initData {
    self.sortOrders = [Filters allSortOrders];
    self.categories = [Filters allCategories];
}

@end
