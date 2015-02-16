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

@interface FiltersTableViewController () <FilterCellDelegate>

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSMutableSet *selectedCategories;

@end

@implementation FiltersTableViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initCategories];
        self.selectedCategories = [NSMutableSet set];
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
}

-(void)onCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)onApply {
    if (self.delegate != nil) {
        NSMutableArray *filterCodes = [NSMutableArray array];
        for (NSDictionary *category in self.selectedCategories) {
            [filterCodes addObject:category[@"code"]];
        }
        NSString *filters = [filterCodes componentsJoinedByString:@","];
        [self.delegate filtersTableViewController:self didChangeFilters:filters];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
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
    if (section == 0) {
        return @"Price";
    } else {
        return @"Categories";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PriceCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PriceCell"];
        return cell;
    } else {
        FilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
        [cell setTitle:self.categories[indexPath.row][@"name"] ];
        [cell setOn:[self.selectedCategories containsObject:self.categories[indexPath.row]] animated:NO];
        cell.delegate = self;
        return cell;
    }
}

-(void)filterCell:(FilterCell *)filterCell didChangeValue:(BOOL)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:filterCell];
    if (value) {
        [self.selectedCategories addObject:self.categories[indexPath.row]];
    } else {
        [self.selectedCategories removeObject:self.categories[indexPath.row]];
    }
}

-(void)initCategories {
    self.categories = @[
                        @{@"name": @"Afghan", @"code": @"afghani"},
                        @{@"name": @"African", @"code": @"african"},
                        @{@"name": @"American (New)", @"code": @"newamerican"},
                        @{@"name": @"American (Traditional)", @"code": @"tradamerican"},
                        @{@"name": @"Arabian", @"code": @"arabian"},
                        @{@"name": @"Argentine", @"code": @"argentine"},
                        @{@"name": @"Armenian", @"code": @"armenian"},
                        @{@"name": @"Asian Fusion", @"code": @"asianfusion"},
                        @{@"name": @"Australian", @"code": @"australian"},
                        @{@"name": @"Austrian", @"code": @"austrian"},
                        @{@"name": @"Bangladeshi", @"code": @"bangladeshi"},
                        @{@"name": @"Barbeque", @"code": @"bbq"},
                        @{@"name": @"Basque", @"code": @"basque"},
                        @{@"name": @"Belgian", @"code": @"belgian"},
                        @{@"name": @"Brasseries", @"code": @"brasseries"},
                        @{@"name": @"Brazilian", @"code": @"brazilian"},
                        @{@"name": @"Breakfast & Brunch", @"code": @"breakfast_brunch"},
                        @{@"name": @"British", @"code": @"british"},
                        @{@"name": @"Buffets", @"code": @"buffets"},
                        @{@"name": @"Burgers", @"code": @"burgers"},
                        @{@"name": @"Burmese", @"code": @"burmese"},
                        @{@"name": @"Cafes", @"code": @"cafes"},
                        @{@"name": @"Cafeteria", @"code": @"cafeteria"},
                        @{@"name": @"Cajun/Creole", @"code": @"cajun"},
                        @{@"name": @"Cambodian", @"code": @"cambodian"},
                        @{@"name": @"Caribbean", @"code": @"caribbean"},
                        @{@"name": @"Catalan", @"code": @"catalan"},
                        @{@"name": @"Cheesesteaks", @"code": @"cheesesteaks"},
                        @{@"name": @"Chicken Shop", @"code": @"chickenshop"},
                        @{@"name": @"Chicken Wings", @"code": @"chicken_wings"},
                        @{@"name": @"Chinese", @"code": @"chinese"},
                        @{@"name": @"Comfort Food", @"code": @"comfortfood"},
                        @{@"name": @"Creperies", @"code": @"creperies"},
                        @{@"name": @"Cuban", @"code": @"cuban"},
                        @{@"name": @"Czech", @"code": @"czech"},
                        @{@"name": @"Delis", @"code": @"delis"},
                        @{@"name": @"Diners", @"code": @"diners"},
                        @{@"name": @"Ethiopian", @"code": @"ethiopian"},
                        @{@"name": @"Fast Food", @"code": @"hotdogs"},
                        @{@"name": @"Filipino", @"code": @"filipino"},
                        @{@"name": @"Fish & Chips", @"code": @"fishnchips"},
                        @{@"name": @"Fondue", @"code": @"fondue"},
                        @{@"name": @"Food Court", @"code": @"food_court"},
                        @{@"name": @"Food Stands", @"code": @"foodstands"},
                        @{@"name": @"French", @"code": @"french"},
                        @{@"name": @"Gastropubs", @"code": @"gastropubs"},
                        @{@"name": @"German", @"code": @"german"},
                        @{@"name": @"Gluten-Free", @"code": @"gluten_free"},
                        @{@"name": @"Greek", @"code": @"greek"},
                        @{@"name": @"Halal", @"code": @"halal"},
                        @{@"name": @"Hawaiian", @"code": @"hawaiian"},
                        @{@"name": @"Himalayan/Nepalese", @"code": @"himalayan"},
                        @{@"name": @"Hot Dogs", @"code": @"hotdog"},
                        @{@"name": @"Hot Pot", @"code": @"hotpot"},
                        @{@"name": @"Hungarian", @"code": @"hungarian"},
                        @{@"name": @"Iberian", @"code": @"iberian"},
                        @{@"name": @"Indian", @"code": @"indpak"},
                        @{@"name": @"Indonesian", @"code": @"indonesian"},
                        @{@"name": @"Irish", @"code": @"irish"},
                        @{@"name": @"Italian", @"code": @"italian"},
                        @{@"name": @"Japanese", @"code": @"japanese"},
                        @{@"name": @"Korean", @"code": @"korean"},
                        @{@"name": @"Kosher", @"code": @"kosher"},
                        @{@"name": @"Laotian", @"code": @"laotian"},
                        @{@"name": @"Latin American", @"code": @"latin"},
                        @{@"name": @"Live/Raw Food", @"code": @"raw_food"},
                        @{@"name": @"Malaysian", @"code": @"malaysian"},
                        @{@"name": @"Mediterranean", @"code": @"mediterranean"},
                        @{@"name": @"Falafel", @"code": @"falafel"},
                        @{@"name": @"Mexican", @"code": @"mexican"},
                        @{@"name": @"Middle Eastern", @"code": @"mideastern"},
                        @{@"name": @"Modern European", @"code": @"modern_european"},
                        @{@"name": @"Mongolian", @"code": @"mongolian"},
                        @{@"name": @"Moroccan", @"code": @"moroccan"},
                        @{@"name": @"Pakistani", @"code": @"pakistani"},
                        @{@"name": @"Persian/Iranian", @"code": @"persian"},
                        @{@"name": @"Peruvian", @"code": @"peruvian"},
                        @{@"name": @"Pizza", @"code": @"pizza"},
                        @{@"name": @"Polish", @"code": @"polish"},
                        @{@"name": @"Portuguese", @"code": @"portuguese"},
                        @{@"name": @"Poutineries", @"code": @"poutineries"},
                        @{@"name": @"Russian", @"code": @"russian"},
                        @{@"name": @"Salad", @"code": @"salad"},
                        @{@"name": @"Sandwiches", @"code": @"sandwiches"},
                        @{@"name": @"Scandinavian", @"code": @"scandinavian"},
                        @{@"name": @"Scottish", @"code": @"scottish"},
                        @{@"name": @"Seafood", @"code": @"seafood"},
                        @{@"name": @"Singaporean", @"code": @"singaporean"},
                        @{@"name": @"Slovakian", @"code": @"slovakian"},
                        @{@"name": @"Soul Food", @"code": @"soulfood"},
                        @{@"name": @"Soup", @"code": @"soup"},
                        @{@"name": @"Southern", @"code": @"southern"},
                        @{@"name": @"Spanish", @"code": @"spanish"},
                        @{@"name": @"Sri Lankan", @"code": @"srilankan"},
                        @{@"name": @"Steakhouses", @"code": @"steak"},
                        @{@"name": @"Sushi Bars", @"code": @"sushi"},
                        @{@"name": @"Taiwanese", @"code": @"taiwanese"},
                        @{@"name": @"Tapas Bars", @"code": @"tapas"},
                        @{@"name": @"Tapas/Small Plates", @"code": @"tapasmallplates"},
                        @{@"name": @"Tex-Mex", @"code": @"tex-mex"},
                        @{@"name": @"Thai", @"code": @"thai"},
                        @{@"name": @"Turkish", @"code": @"turkish"},
                        @{@"name": @"Ukrainian", @"code": @"ukrainian"},
                        @{@"name": @"Uzbek", @"code": @"uzbek"},
                        @{@"name": @"Vegan", @"code": @"vegan"},
                        @{@"name": @"Vegetarian", @"code": @"vegetarian"},
                        @{@"name": @"Vietnamese", @"code": @"vietnamese"}
                        ];
}

@end
