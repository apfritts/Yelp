//
//  SortCell.m
//  Yelp
//
//  Created by AP Fritts on 2/16/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "SortCell.h"

@interface SortCell()

@property (weak, nonatomic) IBOutlet UIButton *radioButton;
@property (weak, nonatomic) IBOutlet UILabel *radioLabel;
- (IBAction)radioButtonTap:(id)sender;

@end

@implementation SortCell


- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setTitle:(NSString *)title {
    self.radioLabel.text = title;
}

-(void)setOn:(BOOL)on {
    if (on && !self.radioButton.selected) {
        [self.radioButton setSelected:YES];
        if (self.delegate != nil) {
            [self.delegate sortCell:self isSelected:YES];
        }
    } else if (on == NO) {
        [self.radioButton setSelected:NO];
    }
}

- (IBAction)radioButtonTap:(id)sender {
    [self setOn:YES];
}

@end
