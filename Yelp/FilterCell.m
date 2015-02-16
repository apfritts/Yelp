//
//  FilterCell.m
//  Yelp
//
//  Created by AP Fritts on 2/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "FilterCell.h"

@interface FilterCell()

@property (weak, nonatomic) IBOutlet UILabel *filterLabel;
@property (weak, nonatomic) IBOutlet UISwitch *filterSwitch;
- (IBAction)filterChanged:(id)sender;

@end

@implementation FilterCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)filterChanged:(id)sender {
    if (self.delegate != nil) {
        [self.delegate filterCell:self didChangeValue:self.filterSwitch.on];
    }
}

-(void)setOn:(BOOL)on animated:(BOOL)animated {
    [self.filterSwitch setOn:on animated:animated];
}

-(void)setTitle:(NSString *)title {
    self.filterLabel.text = title;
}

@end
