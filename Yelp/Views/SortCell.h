//
//  SortCell.h
//  Yelp
//
//  Created by AP Fritts on 2/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"

@class SortCell;

@protocol SortCellDelegate <NSObject>

-(void)sortCell:(SortCell *)sortCell isSelected:(BOOL)selected;

@end

@interface SortCell : UITableViewCell

@property (nonatomic, weak) id<SortCellDelegate> delegate;
-(void)setTitle:(NSString *)title;
-(void)setOn:(BOOL)on;

@end
