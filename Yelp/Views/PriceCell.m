//
//  PriceCell.m
//  Yelp
//
//  Created by AP Fritts on 2/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "PriceCell.h"

@interface PriceCell()

@property (weak, nonatomic) IBOutlet UISegmentedControl *priceSegment;
- (IBAction)priceSegmentsChanged:(id)sender;

@end

@implementation PriceCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)priceSegmentsChanged:(id)sender {
    NSLog(@"%@", sender);
}

@end
