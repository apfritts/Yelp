//
//  FilterCell.h
//  Yelp
//
//  Created by AP Fritts on 2/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterCell;

@protocol FilterCellDelegate <NSObject>

-(void)filterCell:(FilterCell *)filterCell didChangeValue:(BOOL)value;

@end

@interface FilterCell : UITableViewCell

@property (nonatomic, weak) id<FilterCellDelegate> delegate;

-(void)setOn:(BOOL)on animated:(BOOL)animated;
-(void)setTitle:(NSString *)title;

@end
