//
//  FiltersTableViewController.h
//  Yelp
//
//  Created by AP Fritts on 2/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersTableViewController;

@protocol FiltersTableViewControllerDelegate <NSObject>

@required
-(void)filtersTableViewController:(FiltersTableViewController *)ftvc didChangeFilters:(NSDictionary *)filters;

@end

@interface FiltersTableViewController : UITableViewController

@property (nonatomic, weak) id<FiltersTableViewControllerDelegate> delegate;

@end
