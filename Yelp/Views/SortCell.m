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

-(instancetype)initWithTitle:(NSString *)title isOn:(BOOL)on {
    self = [super init];
    if (self) {
        [self setTitle:title];
        [self setOn:on];
    }
    return self;
}

-(void)setTitle:(NSString *)title {
    self.radioLabel.text = title;
}

-(void)setOn:(BOOL)on {
    if (on && !self.on) {
        self.on = YES;
        [self.radioButton setSelected:YES];
        if (self.delegate != nil) {
            [self.delegate sortCell:self isSelected:YES];
        }
    }
}

- (IBAction)radioButtonTap:(id)sender {
    [self setOn:YES];
}

@end
