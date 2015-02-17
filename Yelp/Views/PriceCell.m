//
//  PriceCell.m
//  Yelp
//
//  Created by AP Fritts on 2/17/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "PriceCell.h"
#import <THSegmentedControl/THSegmentedControl.h>

@interface PriceCell()

@property (strong, nonatomic) THSegmentedControl *priceSegment;

@end

@implementation PriceCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    NSArray *segments = @[@"$", @"$$", @"$$$", @"$$$$"];
    self.priceSegment = [[THSegmentedControl alloc] initWithSegments:segments];
    [self.priceSegment addTarget:self action:@selector(thControlChangedSegment:) forControlEvents:UIControlEventValueChanged | UIControlEventTouchUpInside];
    [self addSubview:self.priceSegment];
    CGSize bounds = [[UIScreen mainScreen] bounds].size;
    [self.priceSegment setBounds:CGRectMake(8, 8, bounds.width - 16, 34)];
    [self.priceSegment setCenter:CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, 25)];
    NSLog(@"%f x %f", self.priceSegment.center.x, self.priceSegment.center.y);
}

-(void)thControlChangedSegment:(THSegmentedControl *)thSegmentedControl {
    NSOrderedSet *orderedIndexes = thSegmentedControl.selectedIndexes;
    for (NSNumber *selection in orderedIndexes) {
        NSLog(@"I'm a selected segment %@", [thSegmentedControl titleForSegmentAtIndex:[selection intValue]]);
    }
}

-(CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 50);
}

@end
